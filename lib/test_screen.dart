import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getPostalCodeFromCoordinates();
    getCurrentLocation();
  }



  String pinCode = '';

  String mobileErrorText = '';
  String locationMessage = "";

  List<String> locationList = [];
  List<String> uniqueList = [];

  void getCurrentLocation() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    // locationMessage = "${position.latitude}, ${position.longitude}";

    await getLocationAndIncrementCoordinates(
        // position.latitude
        22.620186, 88.129843, 0.009, 0.009, 10);
    print(uniqueList);
  }

  Future<void> getLocationAndIncrementCoordinates(
      double initialLatitude,
      double initialLongitude,
      double latitudeIncrement,
      double longitudeIncrement,
      int numberOfIncrements) async {
    double latitude = initialLatitude;
    double longitude = initialLongitude;

    for (int i = 0; i < numberOfIncrements; i++) {
      latitude += latitudeIncrement;

      for (int i = 0; i < numberOfIncrements; i++) {
        await getLocationDetails(latitude, longitude);

        longitude += longitudeIncrement;
      }
      longitude = initialLongitude;
    }
    /////////////
    latitude = initialLatitude;
    longitude = initialLongitude;
    ////////////
    for (int i = 0; i < numberOfIncrements; i++) {
      latitude += latitudeIncrement;
      for (int i = 0; i < numberOfIncrements; i++) {
        await getLocationDetails(latitude, longitude);

        longitude -= longitudeIncrement;
      }
      longitude = initialLongitude;
    }
    /////////////
    latitude = initialLatitude;
    longitude = initialLongitude;
    ////////////
    for (int i = 0; i < numberOfIncrements; i++) {
      latitude -= latitudeIncrement;
      for (int i = 0; i < numberOfIncrements; i++) {
        await getLocationDetails(latitude, longitude);

        longitude += longitudeIncrement;
      }
      longitude = initialLongitude;
    }
    /////////////
    latitude = initialLatitude;
    longitude = initialLongitude;
    ////////////
    for (int i = 0; i < numberOfIncrements; i++) {
      latitude -= latitudeIncrement;
      for (int i = 0; i < numberOfIncrements; i++) {
        await getLocationDetails(latitude, longitude);

        longitude -= longitudeIncrement;
      }
      longitude = initialLongitude;
    }
  }

  Future<void> getLocationDetails(double latitude, double longitude) async {
    Position position = Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      floor: null,
      isMocked: false,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    try{
      locationMessage = "${position.latitude}, ${position.longitude}";


      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude,);
      print(placemarks[0]);
      Placemark place = placemarks[0];

      pinCode = place.postalCode ?? ''; // Pincode

      locationList.add(pinCode);
      for (String item in locationList) {
        if (!uniqueList.contains(item)) {
          if(item.isNotEmpty){
            uniqueList.add(item);

          }
        }
      }

    }catch(e){
    }
  }


  String _postalCode='';
  Future<void> _getPostalCodeFromCoordinates() async {
    try {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((value) async {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            28.287108, 77.173695);
        print('Postal Code${placemarks.first.postalCode}');
        setState(() {
          _postalCode = placemarks.first.postalCode ?? 'null';
        });
      });

    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_postalCode),
      ),
    );
  }
}


