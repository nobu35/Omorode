//「TextField」をまとめたwidget
import 'package:flutter/material.dart';

class TextA extends StatelessWidget {
  const TextA({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //クリックした時の入力バーの色
      cursorColor: const Color.fromARGB(255, 102, 205, 170),
      //エンター押したら次の枠へ行く
      textInputAction: TextInputAction.next,
      //中の文字の大きさ
      style: const TextStyle(
        fontSize: 15,
      ),
      decoration: InputDecoration(
        //枠内の文字の色
        labelText: text,
        //クリックした時の文字の色
        floatingLabelStyle:
            const TextStyle(color: Color.fromARGB(255, 102, 205, 170)),
        //paddingの設定
        contentPadding: const EdgeInsets.all(10), //任意の値を入れてpaddingを調節
        //フォーカスしてないときの枠の設定
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        //フォーカスしてるときの枠の設定
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 102, 205, 170),
          ),
        ),
      ),
    );
  }
}
