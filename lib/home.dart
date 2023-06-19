import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:omorode/login.dart';
import 'package:omorode/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeScreen> {
  final _usStates = ["ログアウト"];
  //ログイン中のユーザー情報を取得
  final userID = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String s) {
              setState(() {});
              //後日変更
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
        title: const Text('  Omorode',
            style: TextStyle(
              fontSize: 40,
            )),
        elevation: 0,
      ),
      body: const Center(child: Text('ホーム', style: TextStyle(fontSize: 32.0))),
      backgroundColor: Colors.white,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: const Color.fromARGB(255, 102, 205, 170),
        closeManually: true,
        onPress: () {
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) {
          return const MapPage();
          }));
        }, //短押し処理
        children: [
          SpeedDialChild(
            child: const Icon(Icons.share_rounded),
            label: '共有',
            backgroundColor: Colors.blue,
            onTap: () {
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.mail),
            label: 'メール',
            backgroundColor: Colors.blue,
            onTap: () {
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.copy),
            label: 'コピー',
            backgroundColor: Colors.blue,
            onTap: () {
            },
          ),
        ], //長押し処理
      ),
    );
  }
}
