import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'account.dart';
import 'home.dart';
import 'search.dart';
import 'login.dart';

//テーマの色決め
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

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      home: const config(),
    );
  }
}

// ignore: camel_case_types
class config extends StatefulWidget {
  const config({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<config> {
  //ボタンの文字はここ
  final _usStates = ["ログアウト"];
  //ログイン中のユーザー情報を取得
  final userID = FirebaseAuth.instance.currentUser!.uid;

  static const _screens = [
    //設定を共有する画面の一覧
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String s) {
                setState(() {});
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(builder: (context) => const Login()),
                  (Route<dynamic> route) => false,
                );
              },
              itemBuilder: (BuildContext context) {
                return _usStates.map((String s) {
                  return PopupMenuItem(
                    value: s,
                    child: Text(s),
                  );
                }).toList();
              },
            )
          ],
          centerTitle: false,
          title: const Text('     Omorode',
              style: TextStyle(
                fontSize: 40,
              )),
          elevation: 0,
        ),
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
