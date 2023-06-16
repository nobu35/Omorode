import 'package:flutter/material.dart';
import 'package:omorode/app.dart';

class Postw extends StatelessWidget {
  const Postw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Padding(
      //余白
      padding: const EdgeInsets.only(top: 70, right: 30, bottom: 0, left: 30),
      child: Column(
        children: [
          //text
          const SizedBox(
              width: double.infinity,
              //color: Colors.black,
              child: Text('パスワード\n忘れんな？www',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 36, color: Color.fromARGB(255, 42, 249, 49)))),
          //「Login」画面に移動
          ElevatedButton(
            onPressed: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const App();
              }))
            },
            child: const Text('modoru'),
          ),
        ],
      ),
    )));
  }
}
