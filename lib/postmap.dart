import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'addItem.dart';
import 'app.dart';

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
  LatLng? latLng;

  void deleteMarkers() {
    setState(() {
      markers.clear();
      latLng = null;
    });
  }

  //マーカー
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onLongPress(LatLng latLng) {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
      ));
      print('latLng: $latLng');

      double latitude = latLng.latitude;
      double longitude = latLng.longitude;
      print('lat.latitude: $latitude');
      print('lat.longitude: $longitude');
      this.latLng = latLng;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getUserLocation();
  }

  void _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
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
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 102, 205, 170),
              ),
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const App();
                }))
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (latLng != null) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddItem(latLng: latLng!);
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('座標が選択されていません')),
                  );
                }
              },
              child: Text(
                "次へ",
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteMarkers,
            )
          ],
        ),
        body: _loading
            ? const CircularProgressIndicator()
            : SafeArea(
                child: Stack(fit: StackFit.expand, children: [
                //googleMap表示プログラム
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
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
}
