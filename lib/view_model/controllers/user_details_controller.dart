import 'package:animal/data/firebase/user_services.dart';
import 'package:animal/view_model/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
class UserDetailsController extends ChangeNotifier {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  bool loading = false;
  String pinCode = '';
  String loadingMsg = '';
  String locationMessage = "";
  List<String> locationList = [];
  List<String> uniqueList = [];

  setLoading({required bool value}) {
    loading = value;
    notifyListeners();
  }

  getPostalCode() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      setLoadingMsg(msg: 'Getting your location');
      setLoading(value: true);
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((value) async {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(28.287108, 77.173695);
        postalCode.text = placemarks.first.postalCode ?? '';
        setLoadingMsg(msg: '');
        setLoading(value: false);
      });
    } catch (_) {
      setLoading(value: false);
    }
  }
  setLoadingMsg({required String msg}){
    loadingMsg=msg;
    notifyListeners();
  }
  Future<List<String>> getCurrentLocation() async {
    setLoadingMsg(msg: 'Getting nearest locations');
    setLoading(value: true);
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    // locationMessage = "${position.latitude}, ${position.longitude}";

    // await getLocationAndIncrementCoordinates(
    //   // position.latitude
    //     28.287108
    //     , 77.173695, 0.009, 0.009, 10);
    await getLocationAndIncrementCoordinates(
      // position.latitude
        position.latitude
        , position.longitude, 0.009, 0.009, 5);
    setLoadingMsg(msg: '');
    setLoading(value: false);
    return uniqueList;
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
    }catch(_){

    }
  }
  saveUser({required BuildContext context}) async{
    UserServices().createUser(
        context: context,
        phoneNumber:
            Provider.of<AuthenticationController>(context, listen: false)
                .number
                .value
                .text
                .toString(),
        name: name.value.text.toString(),
        email: email.value.text.toString(),
        age: age.value.text.toString(),
        nearestLocations: await getCurrentLocation(),
        postalCode: postalCode.value.text.toString());
  }
}
