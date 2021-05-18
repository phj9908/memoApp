import 'package:flutter/material.dart';
import 'package:memomemo_app/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange, // 버튼 배경
        primaryColor: Colors.white, // 버튼 위 텍스트
      ),
      home: MyHomePage(),
    );
  }
}
