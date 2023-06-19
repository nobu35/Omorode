import 'package:flutter/material.dart';

class Emailcheck extends StatefulWidget {
  final String? email;
  final String? password;

  const Emailcheck({Key? key, this.email, this.password}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Emailcheck createState() => _Emailcheck();
}

class _Emailcheck extends State<Emailcheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メール認証'),
      ),
      body: const Center(
        child: Text("メールをお送りしました。"),
      ),
    );
  }
}
