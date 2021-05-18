import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(                 // 리스트 생성하기엔 최적, 스크롤 가능
        physics: BouncingScrollPhysics(),  // 자연스러운 스크롤
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20, top: 20),
              child: Text('MemoMemo',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Colors.blue,
              ),),
              )
            ],
          ),
          ...LoadMemo()   // 메모 리스트 가져오는 메서드 , '...' : 클래스의 객체생성 없이 메서드 구현할 때
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,CupertinoPageRoute(builder: (context) => EditPage()) ); // 버튼 누르면 edit 화면으로 이동, 현 위젯의 context 넘겨주고 이동할 화면 정보적기
        },
        tooltip: '노트를 추가하려면 클릭하세요~',  // ?
        label: Text('노트 추가'), // 버튼 위 텍스트
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> LoadMemo() { // Container(자료형 Widget) 반환
    List<Widget> memoList = [];

    memoList.add(
    Container(
      color: Colors.purple,
      height: 100.0,
    ));
    memoList.add(
        Container(
          color: Colors.red,
          height: 100.0,
        ));

    return memoList;
  }
}
