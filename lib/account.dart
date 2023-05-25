import 'package:flutter/material.dart';
import 'login.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('アカウント'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, right: 30, bottom: 0, left: 30),
        child: Column(children: [
          const Text('アカウント画面', style: TextStyle(fontSize: 32.0)),
          ElevatedButton(
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Login();
              }))
            },
            child: const Text('signin'),
          ),
        ]),
      ),
    ));
  }
}
