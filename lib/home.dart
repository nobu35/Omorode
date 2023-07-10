import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:omorode/postmap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeScreen> {
  late Stream<QuerySnapshot> _stream;
  List<Map<String, dynamic>> items = []; // 追加: データを保持するリスト

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Text').snapshots();
    _loadData(); // 追加: データのロード
  }

  Future<void> _loadData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Text').get();
      final documents = querySnapshot.docs;

      // 追加: uidを使ってUserコレクションからUserNameを取得
      for (final document in documents) {
        final uid = document['uid'];
        final userDoc =
            await FirebaseFirestore.instance.collection('User').doc(uid).get();
        final userName = userDoc['UserName'];

        final item = {
          'coment': document['coment'],
          'userName': userName, // userNameフィールドを追加
          'image': document['image'],
        };

        items.add(item);
      }

      setState(() {}); // データが更新されたことを反映させる
    } catch (error) {
      print('エラーが発生しました: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Container(
            padding:
                const EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 1),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item['userName']}',
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '${item['coment']}', // userNameを表示
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    SizedBox(
                      width: 150,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: item.containsKey('image')
                            ? Image.network(
                                '${item['image']}',
                                fit: BoxFit.contain,
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: const Color.fromARGB(255, 102, 205, 170),
        closeManually: true,
        onPress: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const MapPage();
          }));
        },
        children: [
          SpeedDialChild(
            child: const Icon(Icons.share_rounded),
            label: '共有',
            backgroundColor: Colors.blue,
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.mail),
            label: 'メール',
            backgroundColor: Colors.blue,
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.copy),
            label: 'コピー',
            backgroundColor: Colors.blue,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
