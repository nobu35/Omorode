//Post画面テスト


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omorode/app.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  PostsState createState() => PostsState();
}

class PostsState extends State<Posts> {
  String messageText = '';
  final userID = FirebaseAuth.instance.currentUser!.uid;
  String uid = '';
  final ImagePicker _picker = ImagePicker();
  File? _file;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title:const Text('チャット投稿'),
        ),
        body: Column(
        children: [
          Container(
            padding:const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 投稿メッセージ入力
                TextFormField(
                  decoration:const InputDecoration(labelText: '投稿メッセージ'),
                  // 複数行のテキスト入力
                  keyboardType: TextInputType.multiline,
                  // 最大3行
                  maxLines: 3,
                  onChanged: (String value) {
                    setState(() {
                      messageText = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('投稿'),
                    onPressed: () async {
                      DateTime timestamp = DateTime.now(); // 現在の日時
                      print(userID);
                      // 投稿メッセージ用ドキュメント作成
                      await FirebaseFirestore.instance
                          .collection('Text') // コレクションID指定
                          .doc() // ドキュメントID自動生成
                          .set({
                        'TextComent': messageText,
                        'UserID': userID,
                        'PostTime': timestamp,
                        'Tags':'1'
                      });
                      // 1つ前の画面に戻る
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const App();
                    },
                  ),
                );
              }))],
            ),
          ),
          Container(
            child:OutlinedButton(
            onPressed: () async {
              final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
              _file = File(_image!.path);
              setState(() {});
            },
            child: const Text('画像を選択')
          )
          )
        ]),
      );
    }
  }

