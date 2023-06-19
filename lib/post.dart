import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omorode/app.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

//GoogleMapの表示
class MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  late LatLng _initialPosition;
  late bool _loading;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: _loading
          ?const CircularProgressIndicator()
          : SafeArea(
            child: Stack(
            fit: StackFit.expand,
        children: [
          //googleMap表示プログラム
          GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:  CameraPosition(
            target: _initialPosition,
            zoom: 17,
          ),
          markers: markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onLongPress: onLongPress,
        ),
    ])));
  }

  //マーカーを表示するためのコード
  void onLongPress(LatLng latLng) {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
      ));
      print(latLng);
    });
  }
}

//投稿画面
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

