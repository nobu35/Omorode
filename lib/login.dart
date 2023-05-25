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
            //「body」の始まり
            body: Padding(
                padding: const EdgeInsets.only(
                    top: 70, right: 30, bottom: 0, left: 30),
                child: Column(
                  children: [
                    //textお遊び
                    const SizedBox(
                        width: double.infinity,
                        //color: Colors.black,
                        child: Text('Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 36,
                                color: Color.fromARGB(255, 42, 249, 49)))),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    //e-mailを入力する窓
                    const TextField(
                      //中の文字の大きさ
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      decoration: InputDecoration(
                        labelText: 'メールアドレス',
                        //paddingの設定
                        contentPadding: EdgeInsets.all(10), //任意の値を入れてpaddingを調節
                        //フォーカスしてないときの枠の設定
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        //フォーカスしてるときの枠の設定
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 50)),

                    //パスワードを入力する窓
                    const TextField(
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      decoration: InputDecoration(
                        labelText: 'パスワード',
                        //paddingの設定
                        contentPadding: EdgeInsets.all(10), //任意の値を入れてpaddingを調節
                        //フォーカスしてないときの枠の設定
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        //フォーカスしてるときの枠の設定
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    //パスワードを忘れた人用ボタン
                    TextButton(
                      onPressed: () => {},
                      child: const Text(
                        'パスワードを忘れた場合はこちら',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 169, 6),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    //横１列のボタングループ
                    ButtonBar(
                      //サイドに開く
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //「Signin」画面に移動ボタン
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Signin();
                            }))
                          },
                          child: const Text('signin'),
                        ),
                        //「掲示板」画面に移動ボタン
                        ElevatedButton(
                          //ボタンの大きさ変更
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 100)),
                          //押した時の設定
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const App();
                            }));
                          },
                          //ボタンの中のテキスト
                          child: const Text('login'),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
