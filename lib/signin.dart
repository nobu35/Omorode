import 'package:flutter/material.dart';
import 'app.dart';
import 'login.dart';

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('OmO Road'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        color: Colors.black,
                        child: const Text('Signin',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 36,
                                color: Color.fromARGB(255, 3, 248, 11)))),
                    //各種必要事項の入力窓
                    const TextField(
                        decoration: InputDecoration(labelText: 'e-mail')),
                    const TextField(
                        decoration: InputDecoration(labelText: 'name')),
                    const TextField(
                        decoration: InputDecoration(labelText: 'pass')),
                    const TextField(
                      decoration: InputDecoration(labelText: 'password'),
                      obscureText: true,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //「Login」画面に移動
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Login();
                            }))
                          },
                          child: const Text('modoru'),
                        ),
                        //「掲示板」画面に移動
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const App();
                            }));
                          },
                          child: const Text('login'),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
