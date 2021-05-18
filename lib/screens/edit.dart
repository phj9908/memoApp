import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method
import 'package:flutter/material.dart';
import 'package:memomemo_app/database/data.dart';
import 'package:memomemo_app/database/memo.dart';

class EditPage extends StatelessWidget {

  String title ='';
  String text ='';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // actions : 아이콘으로 어떤 동작을 하려할 떄
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
              }),
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: (){
                saveDB();
              },
              ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),    // 리스트를 AppBar로 부터 간격주기
        child: Column(
          children: <Widget>[
            TextField(    // 메모의 제목 필드
              onChanged: (String title){this.title = title;}, // 텍스트 필드의 값이 바뀔때 마다 this.title로 전달됨
              keyboardType: TextInputType.multiline, // 화면상의 텍스트필드넘어서 입력했을 때 밑에줄로 입력되도록
              maxLines: null, // 줄 갯수 제한
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
              // 플러터 공식 문서 참고하여 비밀번호치는 텍스트필드 복붙했음
              // obscureText: true,  // 텍스트 암호화 여부
              decoration: InputDecoration(
                hintText: '제목을 적어주세요.',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(    // 메모의 내용입력 필드
              onChanged: (String text){this.text = text;}, // 텍스트 필드의 값이 바뀔때 마다 this.title로 전달됨
              keyboardType: TextInputType.multiline, // 화면상의 텍스트필드넘어서 입력했을 때 밑에줄로 입력되도록
              maxLines: null, // 줄 갯수 제한
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                hintText: '메모의 내용을 적어주세요.',
              ),
            ),
          ],
        ),
      ),
    );
  }






  Future<void> saveDB() async {

    DBhelper sd = DBhelper();

    var fido = Memo();

      fido.id= str2Sha256(DateTime.now().toString());
      fido.title=this.title;
      fido.text=this.text;
      fido.createTime= DateTime.now().toString();
      fido.editTime= DateTime.now().toString();


    // 디버깅용
      print('id : ${fido.id} 입니다');
    print('title : ${fido.title} 입니다');
     print('text : ${fido.text} 입니다');
    print('createTime : ${fido.createTime} 입니다');
    print('editTime : ${fido.editTime} 입니다');

    /*
    await sd.insertMemo(fido);  // 데이터베이스에 memo추가

    print('debugging : '); // 디버깅용, 목록 출력
    print(await sd.getmemos(fido.id)); // 디버깅용, 목록 출력

     sd.close();

     */
  }

    String str2Sha256(String text) { // https://pub.dev/packages/crypto 참고, 아규먼트 및 함수명 수정

      var bytes = utf8.encode(text); // data being hashed

      var digest = sha512.convert(bytes);

      return digest.toString();
    }
}
