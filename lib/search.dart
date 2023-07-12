import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  //タグ選択初期値
  int selectedFilterIndexes = 100;
  //タグリスト
  final tag = ['峠道', '景色が綺麗', 'ドライブデート', '道が綺麗', '海沿い', '夜景', 'フォトスポット'];
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Text');

  //タグで投稿を絞り込みする
  Future<List<Map<String, dynamic>>> _fetchDocuments() async {
    final QuerySnapshot querySnapshot = await _reference.get();
    final List<DocumentSnapshot> documents = querySnapshot.docs;

    final List<DocumentSnapshot> filteredDocuments = documents.where((doc) {
      final List<dynamic>? tagList = doc['tag'] as List<dynamic>?;
      return tagList?.contains(selectedFilterIndexes) ?? false;
    }).toList();

    final List<Map<String, dynamic>> itemList = [];
    for (final document in filteredDocuments) {
      final uid = document['uid'];
      final userDoc =
          await FirebaseFirestore.instance.collection('User').doc(uid).get();
      final userName = userDoc['UserName'];

      final item = {
        'coment': document['coment'],
        'userName': userName,
        'image': document['image'],
      };

      itemList.add(item);
    }

    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Wrap(
            spacing: 8.0,
            children: List<Widget>.generate(7, (index) {
              //タグを表示
              return ChoiceChip(
                label: Text(tag[index]),
                selected: selectedFilterIndexes == index,
                onSelected: (bool selected) {
                  if (mounted) {
                    setState(() {
                      selectedFilterIndexes = index;
                    });
                  }
                },
              );
            }),
          ),
          //検索した投稿を表示
          Expanded( 
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchDocuments(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('エラーが発生しました'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('データが見つかりませんでした'));
                }
                final List<Map<String, dynamic>> itemList = snapshot.data!;
                return ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = itemList[index];
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 5, top: 0, right: 5, bottom: 1),
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
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}