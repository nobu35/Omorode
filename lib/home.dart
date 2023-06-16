import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('ホーム', style: TextStyle(fontSize: 32.0))),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: const Color.fromARGB(255, 102, 205, 170),
        closeManually: true,
        onPress: () {
          print("tap");
        }, //短押し処理
        children: [
          SpeedDialChild(
            child: const Icon(Icons.share_rounded),
            label: '共有',
            backgroundColor: Colors.blue,
            onTap: () {
              print('Share Tapped');
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.mail),
            label: 'メール',
            backgroundColor: Colors.blue,
            onTap: () {
              print('Mail Tapped');
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.copy),
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
