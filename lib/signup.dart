import 'package:flutter/material.dart';
import 'app.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Padding(
                //余白
                padding: const EdgeInsets.only(
                    top: 70, right: 30, bottom: 0, left: 30),
                child: Column(
                  children: [
                    //text
                    const SizedBox(
                        width: double.infinity,
                        //color: Colors.black,
                        child: Text('Signup',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 36,
                                color: Color.fromARGB(255, 42, 249, 49)))),

                    //余白
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    //各種必要事項の入力窓
                    //メールアドレス
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
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    //ユーザーネーム
                    const TextField(
                      //中の文字の大きさ
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      decoration: InputDecoration(
                        labelText: 'ユーザーネーム',
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
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    //パスワード
                    const TextField(
                      //中の文字の大きさ
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
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    //パスワード(確認)
                    const TextField(
                      //中の文字の大きさ
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
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    //利用規約のところ
                    Row(
                      // 中央寄せ
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          // できるだけボタンを小さくする
                          style: TextButton.styleFrom(
                              minimumSize: const Size(1, 1)),
                          onPressed: () {},
                          child: const Text('利用規約'),
                        ),
                        const Text('について'),
                      ],
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
