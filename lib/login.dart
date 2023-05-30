import 'package:flutter/material.dart';
import 'package:omorode/textfield_widget.dart';
import 'app.dart';
import 'signup.dart';
import 'password.dart';

//このページの名前決め
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            //「body」の始まり
            body: Padding(
                padding: const EdgeInsets.only(
                    top: 70, right: 30, bottom: 0, left: 30),
                child: Column(
                  children: [
                    const SizedBox(
                        width: double.infinity,
                        //color: Colors.black,
                        child: Text('Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 102, 205, 170)))),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 200)),
                    //e-mailを入力する窓
                    const TextA(text: "メールアドレス"),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 80)),
                    //パスワードを入力する窓
                    const TextA(text: "パスワード"),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 120)),
                    //パスワードを忘れた人用ボタン
                    TextButton(
                      onPressed: () => {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const Pass();
                        }))
                      },
                      child: const Text(
                        'パスワードを忘れた場合はこちら',
                        style: TextStyle(
                          color: Color.fromARGB(255, 102, 205, 170),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    //横１列のボタングループ
                    ButtonBar(
                      //サイドに開く
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //「Signin」画面に移動ボタン
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 50),
                              backgroundColor:
                                  const Color.fromARGB(255, 143, 143, 143)),
                          onPressed: () => {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Signup();
                            }))
                          },
                          child: const Text(
                            ('アカウント作成はこちら'),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        //「掲示板」画面に移動ボタン
                        ElevatedButton(
                          //ボタンの大きさ変更
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(70, 50),
                              backgroundColor:
                                  const Color.fromARGB(255, 102, 205, 170)),
                          //押した時の設定
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const App();
                            }));
                          },
                          //ボタンの中のテキスト
                          child: const Text(
                            ('ログイン'),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
