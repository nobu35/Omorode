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

  @override
  Widget build(BuildContext context) {
    currentUserUid = FirebaseAuth.instance.currentUser?.uid ?? '';

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
                const Divider(
                  color: Colors.black,
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
