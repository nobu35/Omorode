import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<AccountScreen> {
  late Stream<QuerySnapshot> _stream;
  List<Map<String, dynamic>> items = [];
  late String currentUserUid;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('Text').snapshots();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Text').get();
      final documents = querySnapshot.docs;

      for (final document in documents) {
        final uid = document['uid'];

        if (uid != currentUserUid) {
          continue;
        }

        final userDoc =
            await FirebaseFirestore.instance.collection('User').doc(uid).get();
        final userName = userDoc['UserName'];

        final item = {
          'coment': document['coment'],
          'userName': userName,
          'image': document['image'],
        };

        items.add(item);
      }

      setState(() {});
    } catch (error) {
      print('エラーが発生しました: $error');
    }
  }

  void _handleTap(String userName) {
    print('Tapped userName: $userName');
    // ここにタップされたuserNameに対する処理を追加できます。
  }

  @override
  Widget build(BuildContext context) {
    currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              _handleTap(item['userName']);
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                            '${item['coment']}',
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
              ),
            ),
          );
        },
      ),
    );
  }
}
