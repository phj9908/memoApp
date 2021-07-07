import 'package:flutter/material.dart';
import 'package:memomemo/screens/launch_page.dart';
import 'screens/home_page.dart';

// 중간중간 빨간 화면 뜸 , 시작화면, 로딩화면 끼워도 똑같
// https://www.youtube.com/watch?v=LSwVmfzzDFA&list=PLnIaYcDMsScxP2Nl8pEbmI__wkF0YVu0a&index=26 참고하였음

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // debug 배너 없애기
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,primaryColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LaunchPage();
  }
}