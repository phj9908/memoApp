// 버전 업그레이드로 코드 수정, https://pub.dev/packages/sqflite sql도우미 참고

import 'dart:io';

import 'package:memomemo_app/database/memo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// data CRUD(creat, read, use, delete) 기능 구현하는 파일


class DBhelper{

  Database _db;

  // 2. 데이터 베이스 초기화
  Future open(String path) async{

    // db가 처음 생성되는 것이라면
    _db = await openDatabase(path, version :1,   // 데이터베이스 경로 요청
        onCreate: (Database db,int version) async{  //  테이블 생성
        await db.execute(
            "CREATE TABLE memos(id TEXT PRIMARY KEY, title TEXT, text TEXT, createTime TEXT, editTime TEXT)",

        );
      },
    );
  }

  // 3_1. 데이터 추가하기
/*
   Future<Memo> insertMemo(Memo memo) async {

    memo.id = await _db.insert(  // 가져온 데이터를 테이블에 삽입
        TableName,
        memo.toMap());

     return memo;
   }
*/
   // 3_2.얻은 데이터를 list<Memo>형으로 변환
   Future<Memo> getmemos(int id) async{
    
    List<Map> maps = await _db.query(TableName,
      columns: [id_, title_, text_, createTime_, editTime_],
     where: '$id_ =?',
     whereArgs: [id]
    );

    if(maps.length >0) return Memo.fromMap(maps.first);
    return null;

   }

   // 4. 데이터 갱신
  Future<int> updateMemo(Memo memo) async{

    // 주어진 데이터 수정
    return await _db.update(
      TableName,
      memo.toMap(),
      where: "$id_ = ?", // 데이터의 id 확인
      whereArgs: [memo.id],  // sql injection 방지
    );
  }

  // 5. 데이터 삭제
  Future<int> deleteMemo(int id) async{

    return await _db.delete(
      TableName,
      where: "$id_ = ?", // 특정 데이터를 삭제하기 위해 where이용
      whereArgs: [id], // sql injection 방지
    );
  }

  Future close() async => _db.close();

}