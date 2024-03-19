import 'package:animal/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static saveUser({required UserModel user}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final List<String> tempList=List.from(user.nearestLocations);
    preferences.setString('NAME', user.name!);
    preferences.setString('EMAIL', user.email!);
    preferences.setStringList('nearestLocations', tempList);
    preferences.setString('PHONENUMBER', user.phoneNumber!);
    preferences.setString('AGE', user.age!);
    preferences.setString('LOCATION', user.location!);
    preferences.setString('TOKEN', user.token!);

  }

  static Future<UserModel> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return UserModel(name: preferences.getString('NAME'),
        age: preferences.getString('AGE'),
        nearestLocations: preferences.getStringList('nearestLocations') ?? [],
        token: preferences.getString('TOKEN'),
        location: preferences.getString('LOCATION'),
        email: preferences.getString('EMAIL'),
        phoneNumber: preferences.getString('PHONENUMBER'));
  }

}