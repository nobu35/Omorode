import 'package:flutter/material.dart';
import 'package:omorode/textfield_widget.dart';
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
                                fontSize: 50,
                                color: Color.fromARGB(255, 102, 205, 170)))),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 170)),
                    //各種必要事項の入力窓
                    //メールアドレス
                    const TextA(text: "メールアドレス"),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    //ユーザーネーム
                    const TextA(text: "ユーザーネーム"),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    //パスワード
                    const TextA(text: "パスワード"),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    //パスワード(確認)
                    const TextA(text: "パスワード"),
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
                    //ボタンのグループ
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
