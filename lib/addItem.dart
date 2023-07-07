// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Listpage.dart';
import 'app.dart';

class AddItem extends StatefulWidget {
  final GeoPoint geoPoint;
  const AddItem({Key? key, required this.geoPoint}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerName = TextEditingController();
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    latitude = widget.geoPoint.latitude;
    longitude = widget.geoPoint.longitude;
  }

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Text');

  String imageUrl = '';
  final userID = FirebaseAuth.instance.currentUser!.uid;
  String uid = '';

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
                decoration: const InputDecoration(
                    hintText: 'Enter the name of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }

                  return null;
                },
              ),
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
                    print(latitude);
                    print(longitude);
                    print(GeoPoint(latitude, longitude));
                    String FileName = file?.name ?? "";

                    late File? image = null;
                    image == null
                        ? Container()
                        : SizedBox(
                            height: 100.0,
                            child: Image.file(image, fit: BoxFit.cover),
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
                  icon: const Icon(Icons.camera_alt)),
              ElevatedButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));

                      return;
                    }

                    if (key.currentState!.validate()) {
                      String itemName = _controllerName.text;
                      DateTime timestamp = DateTime.now();
                      //Create a Map of data
                      Map<String, dynamic> dataToSend = {
                        'coment': itemName,
                        'image': imageUrl,
                        'uid': userID,
                        'posttime': Timestamp.fromDate(timestamp),
                        'lat': latitude,
                        'lng': longitude,

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
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const App();
                        }));
                      });
                    }
                  },
                  child: const Text('保存')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ItemList();
                    }));
                  },
                  child: const Text('ListPage'))
            ],
          ),
        ),
      ),
    );
  }
}
