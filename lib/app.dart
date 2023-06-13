import 'package:flutter/material.dart';
import 'account.dart';
import 'home.dart';
import 'notification.dart';

//コピペです
//「src」直下にボトムバーの設定のapp.dart
//「screens」直下に遷移するページを入れる。

//テーマの色決め(?)
MaterialColor customSwatch = const MaterialColor(0xFF9CDBC5, <int, Color>{
  50: Color(0xFFF7FCFB),
  100: Color(0xFFECF9F5),
  200: Color(0xFFE0F5EE),
  300: Color(0xFFD3F0E7),
  400: Color(0xFFC9EDE1),
  500: Color(0xFFC0EADC),
  600: Color(0xFFBAE7D8),
  700: Color(0xFFB2E4D3),
  800: Color(0xFFAAE1CE),
  900: Color(0xFF9CDBC5),
});

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //ここで上のやつを引っ張ってくる
        primarySwatch: customSwatch,
      ),
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const _screens = [
    //移動する画面の一覧
    HomeScreen(),
    NotificationScreen(),
    AccountScreen()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            //アイコンのデザインと下の文字の設定
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
