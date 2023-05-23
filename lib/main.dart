import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

// MyAppのクラス
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3. タイトルとテーマを設定する。画面の本体はMyHomePageで作る。
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: const {},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// main関数、MyApp、MyHomePageはデフォルトから変更がないため省略

//初期画面を設定する
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
//                              ↓this
    return const Scaffold(body: Login());
  }
}
