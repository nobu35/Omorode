import 'package:flutter/material.dart';

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
        title: const Text('ホーム'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String s) {
              setState(() {});
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
      ),
      body:
          const Center(child: Text('ホーム画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}
