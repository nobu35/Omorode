import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'emailcheck.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  String infoText = '';
  String email = '';
  String username = '';
  String pass = '';
  String password = '';

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
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    //各種必要事項の入力窓
                    //メールアドレス
                    TextField(
                      //クリックした時の入力バーの色
                      cursorColor: const Color.fromARGB(255, 102, 205, 170),
                      //エンター押したら次の枠へ行く
                      textInputAction: TextInputAction.next,
                      //中の文字の大きさ
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: const InputDecoration(
                        //枠内の文字の色
                        labelText: "メールアドレス",
                        //クリックした時の文字の色
                        floatingLabelStyle: TextStyle(color: Colors.black),
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
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    //ユーザーネーム
                    TextField(
                      //クリックした時の入力バーの色
                      cursorColor: const Color.fromARGB(255, 102, 205, 170),
                      //エンター押したら次の枠へ行く
                      textInputAction: TextInputAction.next,
                      //中の文字の大きさ
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          username = value;
                        });
                      },
                      decoration: const InputDecoration(
                        //枠内の文字の色
                        labelText: "ユーザーネーム",
                        //クリックした時の文字の色
                        floatingLabelStyle: TextStyle(color: Colors.black),
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
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    //パスワード
                    TextField(
                      //クリックした時の入力バーの色
                      cursorColor: const Color.fromARGB(255, 102, 205, 170),
                      //エンター押したら次の枠へ行く
                      textInputAction: TextInputAction.next,
                      //中の文字の大きさ
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          pass = value;
                        });
                      },
                      decoration: const InputDecoration(
                        //枠内の文字の色
                        labelText: "パスワード",
                        //クリックした時の文字の色
                        floatingLabelStyle: TextStyle(color: Colors.black),
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
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    //パスワード(確認)
                    TextField(
                      //クリックした時の入力バーの色
                      cursorColor: const Color.fromARGB(255, 102, 205, 170),
                      //エンター押したら次の枠へ行く
                      textInputAction: TextInputAction.next,
                      //中の文字の大きさ
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: const InputDecoration(
                        //枠内の文字の色
                        labelText: "パスワード(確認用)",
                        //クリックした時の文字の色
                        floatingLabelStyle: TextStyle(color: Colors.black),
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
                    const Padding(padding: EdgeInsets.only(top: 47)),
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
                          child: const Text(
                            ('利用規約'),
                            style: TextStyle(
                              color: Color.fromARGB(255, 102, 205, 170),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Text(("について"),
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ],
                    ),
                    //余白
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    //ボタンのグループ
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //「Login」画面に移動
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 50),
                              backgroundColor:
                                  const Color.fromARGB(255, 102, 205, 170)),
                          onPressed: () => {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Login();
                            }))
                          },
                          child: const Text(
                            ('戻る'),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        //「掲示板」画面に移動
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(20, 50),
                              backgroundColor:
                                  const Color.fromARGB(255, 102, 205, 170)),
                          onPressed: () async {
                            if (pass == password) {
                              try {
                                // メール/パスワードでユーザー登録
                                final FirebaseAuth auth = FirebaseAuth.instance;
                                await auth.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                //uidの取得
                                final uid = auth.currentUser?.uid.toString();
                                DateTime timestamp = DateTime.now();
                                //firestoreにユーザー情報を登録
                                await FirebaseFirestore.instance
                                    .collection('User') // コレクションID
                                    .doc(uid) // ドキュメントID << usersコレクション内のドキュメント
                                    .set({
                                  'Mail': email,
                                  'UserName': username,
                                  'Uid': uid,
                                  'CreatedAt': timestamp
                                });
                                // Email確認のメールを送信
                                await auth.currentUser?.sendEmailVerification();
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Emailcheck(
                                          email: email, password: password),
                                    ));
                              } on FirebaseAuthException catch (e) {
                                switch (e.code) {
                                  case "weak-password":
                                    setState(() {
                                      infoText = "登録に失敗しました\nパスワードは6文字以上です";
                                    });
                                    break;
                                  case "invalid-email":
                                  case "missing-email":
                                    setState(() {
                                      infoText = "登録に失敗しました\n無効なメールアドレスです";
                                    });
                                    break;
                                  case "email-already-in-use":
                                  case "account-exists-with-different-credential":
                                    setState(() {
                                      infoText = "登録に失敗しました\n既に登録済みのメールアドレスです";
                                    });
                                    break;
                                  case "operation-not-allowed":
                                    setState(() {
                                      infoText = "登録に失敗しました\nファイヤーベース問題発生";
                                    });
                                    break;
                                  case "user-disabled":
                                  case "invalid-credential":
                                    setState(() {
                                      infoText = "登録に失敗しました\nユーザーが無効になっています";
                                    });
                                    break;
                                  case "user-not-found":
                                    setState(() {
                                      infoText = "登録に失敗しました\nユーザーが存在しません";
                                    });
                                    break;
                                  case "wrong-password":
                                    setState(() {
                                      infoText = "登録に失敗しました\nパスワードが間違っています";
                                    });
                                    break;
                                  case "invalid-verification-code":
                                    setState(() {
                                      infoText = "登録に失敗しました\n検証コードが無効になっています";
                                    });
                                    break;
                                  case "invalid-verification-id":
                                    setState(() {
                                      infoText = "登録に失敗しました\n検証IDが無効になっています";
                                    });
                                    break;
                                  default:
                                    setState(() {
                                      infoText = "想定外のエラーが発生しました";
                                    });
                                    break;
                                }
                              }
                            } else {
                              setState(() {
                                infoText = "登録に失敗しました\nパスワードが一致しません";
                              });
                            }
                          },
                          child: const Text(
                            ('新規登録'),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Text(infoText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                            )))
                  ],
                ))));
  }
}
