import 'package:flutter/material.dart';
import 'package:omorode/app.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

MaterialColor customSwatch = const MaterialColor(
  0xFFA4C639,
  <int, Color>{
    50: Color(0xFFF4F8E7),
    100: Color(0xFFE4EEC4),
    200: Color(0xFFD2E39C),
    300: Color(0xFFBFD774),
    400: Color(0xFFB2CF57),
    500: Color(0xFFA4C639),
    600: Color(0xFF9CC033),
    700: Color(0xFF92B92C),
    800: Color(0xFF89B124),
    900: Color(0xFF78A417),
  },
);

// MyAppのクラス
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 3. タイトルとテーマを設定する。画面の本体はMyHomePageで作る。
    return MaterialApp(
      title: 'Omoroad',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      home: const MyHomePage(title: 'Flutter Omoroad Home Page'),
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
  Widget build(BuildContext context)=>MaterialApp(
        title: 'Flutter app',
        //ユーザーが以前ログインしていればホーム画面に、ログインしていなければLogin画面に
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // User が null でなない、つまりサインイン済みのホーム画面へ
              return const App();
            }
            // User が null である、つまり未サインインのサインイン画面へ
            return const Login();
          },
        ),
      );
}
