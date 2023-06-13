import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:omorode/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeScreen> {
  final _usStates = ["ログアウト"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String s) {
              setState(() {});
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
      body: const Center(child: Text('ホーム', style: TextStyle(fontSize: 32.0))),
      backgroundColor: Colors.white,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Color.fromARGB(255, 102, 205, 170),
        closeManually: true,
        onPress: () {
          print("tap");
        }, //短押し処理
        children: [
          SpeedDialChild(
            child: Icon(Icons.share_rounded),
            label: '共有',
            backgroundColor: Colors.blue,
            onTap: () {
              print('Share Tapped');
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.mail),
            label: 'メール',
            backgroundColor: Colors.blue,
            onTap: () {
              print('Mail Tapped');
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.copy),
            label: 'コピー',
            backgroundColor: Colors.blue,
            onTap: () {
              print('Copy Tapped');
            },
          ),
        ], //長押し処理
      ),
    );
  }
}
