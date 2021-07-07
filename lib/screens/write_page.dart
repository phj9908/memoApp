import 'package:flutter/material.dart';
import 'package:memomemo/database/data_form.dart';
import 'package:memomemo/database/db_crud.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:memomemo/screens/home_page.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'loading_page.dart'; // for the utf8.encode method

// 메모를 처음 작성하는 페이지

class WritePage extends StatelessWidget {
  String title= '';
  String text= '';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.delete),
          //   onPressed: (){},
          // ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: (){saveDB(context);
            }
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:Column(
          children: <Widget>[
            TextField(
              onChanged: (String title){ this.title = title;},
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: '메모 제목을 적어주세요.',
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextField(
              onChanged: (String text){ this.text = text;},
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: '메모 내용을 적어주세요.',
              ),
            )
          ],
        ),
        ));
  }

  Future<void> saveDB(BuildContext context) async {

      DBHelper sd = DBHelper();

      var fido = Memo(
      id: Str2Sha512(DateTime.now().toString()),
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos());

    JumpingDotsProgressIndicator(
        fontSize: 20.0,
      );

      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) =>
              MyHomePage()));

      showSnackBar(context , '저장이 되었습니다.');
  }

  String Str2Sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}

void showSnackBar(BuildContext context, String text){

  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text(text,
        textAlign: TextAlign.center,),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      )
  );
}