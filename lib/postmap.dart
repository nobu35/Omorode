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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  GeoPoint convertLatLngToGeoPoint(LatLng latLng) {
    double latitude = latLng.latitude;
    double longitude = latLng.longitude;
    return GeoPoint(latitude, longitude);
  }

  void onLongPress(LatLng latLng) {
    GeoPoint geoPoint = convertLatLngToGeoPoint(latLng);
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
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  GeoPoint initialGeoPoint =
                      convertLatLngToGeoPoint(_initialPosition);

                  return AddItem(geoPoint: initialGeoPoint);
                }))
              },
              child: Text(
                "次へ",
              ),
            ),
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
