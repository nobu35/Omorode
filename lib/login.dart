import 'package:flutter/material.dart';
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
                    //textお遊び
                    const SizedBox(
                        width: double.infinity,
                        //color: Colors.black,
                        child: Text('Login',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromRGBO(102, 205, 170, 1)))),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 200)),
                    //e-mailを入力する窓
                    const TextField(
                      //クリックした時の入力バーの色
                      cursorColor: Color.fromARGB(255, 102, 205, 170),
                      //エンター押したら次の枠へ行く
                      textInputAction: TextInputAction.next,
                      //中の文字の大きさ
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        //枠内の文字の色
                        labelText: 'メールアドレス',
                        //クリックした時の文字の色
                        floatingLabelStyle: TextStyle(
                            color: Color.fromARGB(255, 102, 205, 170)),
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
                            color: Color.fromARGB(255, 102, 205, 170),
                          ),
                        ),
                      ),
                    ),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 80)),

                    //パスワードを入力する窓
                    const TextField(
                      cursorColor: Color.fromARGB(255, 102, 205, 170),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        //クリックした時の入力バーの色
                        focusColor: Color.fromARGB(255, 102, 205, 170),
                        //枠内の文字
                        labelText: 'パスワード',
                        //クリックした時の文字の色
                        floatingLabelStyle: TextStyle(
                            color: Color.fromARGB(255, 102, 205, 170)),
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
                            color: Color.fromARGB(255, 102, 205, 170),
                          ),
                        ),
                      ),
                    ),
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
