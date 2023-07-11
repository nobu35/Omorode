import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omorode/app.dart';
import 'package:omorode/home.dart';
import 'package:omorode/postmap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:omorode/Listpage.dart';

class AddItem extends StatefulWidget {
  final LatLng latLng;

  const AddItem({Key? key, required this.latLng}) : super(key: key);

  LatLng ConvertlatLng(LatLng latLng) {
    double latitude = latLng.latitude;
    double longitude = latLng.longitude;
    return LatLng(latitude, longitude);
  }

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerName = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Text');

  String imageUrl = '';
  final userID = FirebaseAuth.instance.currentUser!.uid;
  String uid = '';
  List<int> selectedFilterIndexes = [];
  final items = ['峠道', '景色が綺麗', 'ドライブデート', '道が綺麗', '海沿い', '夜景', 'フォトスポット'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration:
                    InputDecoration(hintText: 'Enter the name of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }

                  return null;
                },
              ),
              Wrap(
                  spacing: 8.0,
                  children: List<Widget>.generate(7, (index) {
                    return FilterChip(
                        backgroundColor: Colors.grey,
                        label: Text(items[index]),
                        selected: selectedFilterIndexes.contains(index),
                        selectedColor: Colors.white,
                        onSelected: (bool selected) {
                          setState(
                            () {
                              if (selected) {
                                if (selectedFilterIndexes.length < 4) {
                                  selectedFilterIndexes.add(index);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('選択できるタグは最大4つです'),
                                  ));
                                }
                              } else {
                                selectedFilterIndexes.remove(index);
                              }
                            },
                          );
                        });
                  })),
              IconButton(
                  onPressed: () async {
                    /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                    /*Step 1:Pick image*/
                    //Install image_picker
                    //Import the corresponding library

                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print('${file?.path}');
                    print(' ${file?.name}');

                    double latitude = widget.latLng.latitude;
                    double longitude = widget.latLng.longitude;
                    print(latitude);
                    print(longitude);

                    String FileName = file?.name ?? "";

                    late File? image = null;
                    image == null
                        ? Container()
                        : Container(
                            child: Image.file(image, fit: BoxFit.cover),
                            height: 100.0,
                          );

                    if (file == null) return;
                    //Import dart:core
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    /*Step 2: Upload to Firebase storage*/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images2');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(FileName);

                    //Handle errors/success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(file.path));
                      //Success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //Some error occurred
                    }
                  },
                  icon: Icon(Icons.camera_alt)),
              ElevatedButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('画像を選択してください')));

                      return;
                    }

                    if (key.currentState!.validate()) {
                      String itemName = _controllerName.text;
                      DateTime timestamp = DateTime.now();
                      double latitude = widget.latLng.latitude;
                      double longitude = widget.latLng.longitude;
                      //Create a Map of data
                      Map<String, dynamic> dataToSend = {
                        'coment': itemName,
                        'image': imageUrl,
                        'uid': userID,
                        'posttime': Timestamp.fromDate(timestamp),
                        'lat': latitude,
                        'lng': longitude,
                        'tag1': selectedFilterIndexes.length > 0
                            ? items[selectedFilterIndexes[0]]
                            : null,
                        'tag2': selectedFilterIndexes.length > 1
                            ? items[selectedFilterIndexes[1]]
                            : null,
                        'tag3': selectedFilterIndexes.length > 2
                            ? items[selectedFilterIndexes[2]]
                            : null,
                        'tag4': selectedFilterIndexes.length > 3
                            ? items[selectedFilterIndexes[3]]
                            : null,

                        //sjb;hoaein
                      };

                      //Add a new item
                      _reference.add(dataToSend);
                      //投稿完了メッセージの表示
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('投稿しました'),
                        ),
                      );

                      //投稿完了時ホームに戻る
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const App();
                        }));
                      });
                    }
                  },
                  child: Text('保存')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ItemList();
                    }));
                  },
                  child: Text('ListPage'))
            ],
          ),
        ),
      ),
    );
  }
}
