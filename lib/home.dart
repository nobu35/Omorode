import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'postmap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<HomeScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  List<Map<String, dynamic>> items = [];

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
        final userDoc =
            await FirebaseFirestore.instance.collection('User').doc(uid).get();
        final userName = userDoc['UserName'];

        final item = {
          'coment': document['coment'],
          'userName': userName,
          'image': document['image'],
          'lat': document['lat'],
          'lng': document['lng'],
          'tag': document['tag'],
        };

        items.add(item);
      }

      setState(() {});
    } catch (error) {
      print('エラーが発生しました: $error');
    }
  }

  void _navigateToUserPage(String userName, LatLng userLocation) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserPage(userName: userName, userLocation: userLocation);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          final LatLng userLocation =
              LatLng(item['lat'], item['lng']); // ユーザーの座標を取得

          return GestureDetector(
            onTap: () => _navigateToUserPage(item['userName'], userLocation),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 1),
              child: Card(
                child: Padding(
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
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '${item['coment']}',
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            if (item.containsKey('lat') &&
                                item.containsKey('lng') &&
                                item.containsKey('tag'))
                              Column(
                                children: [
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'lat: ${item['lat']}, lng: ${item['lng']}, tag: ${item['tag']}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                ],
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
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const MapPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  final String userName;
  final LatLng userLocation;

  const UserPage({Key? key, required this.userName, required this.userLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Omorode', style: TextStyle(fontSize: 40)),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Welcome, $userName!'),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: userLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('userMarker'),
                  position: userLocation,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
