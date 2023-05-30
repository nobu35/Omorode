import 'package:flutter/material.dart';
import 'account.dart';
import 'bookmark.dart';
import 'home.dart';
import 'notification.dart';

//コピペです
//「src」直下にボトムバーの設定のapp.dart
//「screens」直下に遷移するページを入れる。

//テーマの色決め(?)
MaterialColor customSwatch = const MaterialColor(
  0xFF72E5BE,
  <int, Color>{
    50: Color(0xFFEDF9F5),
    100: Color(0xFFD1F0E6),
    200: Color(0xFFB3E6D5),
    300: Color(0xFF94DCC4),
    400: Color(0xFF7DD5B7),
    500: Color(0xFF72E5BE),
    600: Color(0xFF5EC8A3),
    700: Color(0xFF53C199),
    800: Color(0xFF49BA90),
    900: Color(0xFF38AE7F),
  },
);

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
    BookmarkScreen(),
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
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'お気に入り'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'お知らせ'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
