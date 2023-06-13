import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Omorode'),
      ),
      body: const Center(child: Text('検索', style: TextStyle(fontSize: 32.0))),
    );
  }
}
