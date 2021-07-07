import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'write_page.dart';
import 'package:memomemo/database/data_form.dart';
import 'package:memomemo/database/db_crud.dart';
import 'view_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteid = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(                 // 리스트 생성하기엔 최적, 스크롤 가능
        physics: BouncingScrollPhysics(),  // 자연스러운 스크롤
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20, top: 20),
                child: Text('MEMO',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.grey,
                  ),),
              )
            ],
          ),
          ...LoadMemo()   // 메모 리스트 가져오는 메서드 , '...' : 클래스의 객체생성 없이 메서드 구현할 때
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => WritePage()));
        },
        tooltip: '메모를 추가하려면 클릭하세요',
        label: Text('메모 추가'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Future<void> deleteMemo(String id,BuildContext context) async {
    DBHelper sd = DBHelper();
    return await sd.deleteMemo(id,context);
  }

  void showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 메모는 복구되지 않습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "삭제");
                setState(() {
                  deleteMemo(deleteid, context);
                });
                deleteid = '';
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                deleteid = '';
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
  }

  Widget memoBuilder(BuildContext parentContext) {
    return FutureBuilder(  // 메모들 빌드하는 위젯 : FutureBuilder 사용
      builder: (context, Snap) {
        if (Snap.data.isEmpty) { // 아무 메모가 없으면
          return Container(
            alignment: Alignment.center,
            child: Text(
              '지금 바로 "메모 추가" 버튼을 눌러\n 새 메모를 추가해보세요!\n\n\n\n\n\n\n\n',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              textAlign: TextAlign.center,),
          );
        }
        return ListView.builder( // 작성했던 메모가 있으면
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          itemCount: Snap.data.length,
          itemBuilder: (context, index) {
            Memo memo = Snap.data[index];
            return InkWell( // 컨테이너에 text 및 클릭이벤트 구현
              onTap: (){
                Navigator.push(
                  parentContext, CupertinoPageRoute(
                    builder: (parentContext) => ViewPage(id: memo.id)));
              },
              onLongPress: (){
                  deleteid = memo.id;
                  showAlertDialog(parentContext);
              },
              child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(memo.title,
                              style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,),
                          Text(
                              memo.text,
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("최종 수정 시간: " + memo.editTime.split('.')[0],
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.end),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    boxShadow: [BoxShadow(color: Colors.blue,blurRadius: 3)],
                    borderRadius: BorderRadius.circular(12),
                  )),
            );
          },
        );
      },
      future: loadMemo(),
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