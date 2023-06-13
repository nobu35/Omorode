import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app.dart';
import 'signup.dart';
import 'password.dart';

//このページの名前決め
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{

  String infoText = "";
  String email = "";
  String pass = "";
  String isVerified = "";

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
                    TextField(
                      //クリックした時の入力バーの色
                      cursorColor: const Color.fromARGB(255, 102, 205, 170),
                      //エンター押したら次の枠へ行く
                      textInputAction: TextInputAction.next,
                      //中の文字の大きさ
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (String value){
                        setState(() {
                          email = value;
                        });
                      },
                      decoration:const InputDecoration(
                        //枠内の文字の色
                        labelText: "メールアドレス",
                        //クリックした時の文字の色
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 102, 205, 170)),
                        //paddingの設定
                        contentPadding:  EdgeInsets.all(10), //任意の値を入れてpaddingを調節
                        //フォーカスしてないときの枠の設定
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        //フォーカスしてるときの枠の設定
                        focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 102, 205, 170),
                          ),
                        ),
                      ),
                    ),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 80)),
                    //パスワードを入力する窓
                    TextField(
                      //クリックした時の入力バーの色
                      cursorColor: const Color.fromARGB(255, 102, 205, 170),
                      //エンター押したら次の枠へ行く
                      textInputAction: TextInputAction.next,
                      //中の文字の大きさ
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (String value){
                        setState(() {
                          pass = value;
                        });
                      },
                      decoration:const InputDecoration(
                        //枠内の文字の色
                        labelText: "パスワード",
                        //クリックした時の文字の色
                        floatingLabelStyle:
                            TextStyle(color: Color.fromARGB(255, 102, 205, 170)),
                        //paddingの設定
                        contentPadding:  EdgeInsets.all(10), //任意の値を入れてpaddingを調節
                        //フォーカスしてないときの枠の設定
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        //フォーカスしてるときの枠の設定
                        focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 102, 205, 170),
                          ),
                        ),
                      ),
                    ),
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
                          onPressed: () async {
                            try {
                                  // メール/パスワードでユーザーログイン
                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                    await auth.signInWithEmailAndPassword(
                                    email: email,
                                    password: pass,
                                  );
                                  //メール認証完了済みか確認
                                  final isVerified = auth.currentUser!.emailVerified;
                                  //認証済みでない場合ログアウト
                                  if (!isVerified){
                                    FirebaseAuth.instance.signOut();
                                    infoText = "メール認証を完了してください";
                                  //認証済みの場合はホーム画面に遷移
                                  }else{
                                    if (!mounted) return;
                                    Navigator.of(context).pushReplacement
                                      (MaterialPageRoute(builder: (context) {
                                      return const App();
                                      }));
                                  }
                                  }catch(e){
                                    setState(() {
                                      infoText = "登録に失敗しました：${e.toString()}";
                                    });
                                  }
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
