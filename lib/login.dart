import 'package:flutter/material.dart';
import 'app.dart';
import 'signin.dart';

//このページの名前決め
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            //上の文字
            appBar: AppBar(
              title: const Text('OmO Road'),
            ),
            //「body」の始まり
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //textお遊び
                    Container(
                        width: double.infinity,
                        color: Colors.black,
                        child: const Text('Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 36,
                                color: Color.fromARGB(255, 3, 248, 11)))),
                    //e-mailを入力する窓
                    const TextField(
                        decoration: InputDecoration(labelText: 'e-mail')),
                    //パスワードを入力する窓
                    const TextField(
                      decoration: InputDecoration(labelText: 'password'),
                      obscureText: true,
                    ),
                    //パスワードを忘れた人用ボタン
                    TextButton(
                      onPressed: () => {},
                      child: const Text('パスワードを忘れた場合はこちら'),
                    ),
                    //横１列のボタングループ
                    ButtonBar(
                      //サイドに開く
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //「Signin」画面に移動
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Signin();
                            }))
                          },
                          child: const Text('signin'),
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
