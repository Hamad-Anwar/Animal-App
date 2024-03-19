import 'package:animal/data/shared_pref/user_pref.dart';
import 'package:animal/main.dart';
import 'package:animal/model/user_model.dart';
import 'package:animal/utils/utils.dart';
import 'package:animal/view/authentication/details/user_details.dart';
import 'package:animal/view/home/home_page.dart';
import 'package:animal/view_model/controllers/authentication_controller.dart';
import 'package:animal/view_model/controllers/user_details_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  createUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String age,
        required List<String> nearestLocations,
      required String phoneNumber,
      required String postalCode}) async {
    if (FirebaseAuth.instance.currentUser != null) {
      final controller =
          Provider.of<UserDetailsController>(context, listen: false);
      final authController =
      Provider.of<AuthenticationController>(context, listen: false);
      controller.setLoading(value: true);
      try {
        controller.setLoadingMsg(msg: 'Creating Profile');
        _db
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'name': name,
          'phoneNumber' : authController.number.value.text.toString(),
              'email': email,
          'age': age,
          'nearestLocations' : nearestLocations,
          'postalCode': postalCode,
        }).then((value) async {
          final temp = (await _db
              .collection('recommendations')
              .doc('recommendations')
              .get());
          List<dynamic> list = [];
          if (temp.exists) {
            list = temp.get('recommendations') as List<dynamic>;
          }
          _db.collection('recommendations').doc('recommendations').set({
            'recommendations': [
              ...list,
              postalCode,
            ]
          }).then((value) {
            controller.setLoading(value: false);
            UserPref.saveUser(
                user: UserModel(
                    name: name,
                    age: age,
                    nearestLocations: nearestLocations,
                    token: FirebaseAuth.instance.currentUser!.uid,
                    location: postalCode,
                    email: email,
                    phoneNumber: phoneNumber));
            user=UserModel(
                name: name,
                age: age,
                nearestLocations: nearestLocations,
                token: FirebaseAuth.instance.currentUser!.uid,
                location: postalCode,
                email: email,
                phoneNumber: phoneNumber);
            controller.setLoadingMsg(msg: '');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false);
          });
        });
      } catch (_) {
        controller.setLoading(value: false);
        Utils.showErrorDialog(context: context, error: 'Something went wrong');
      }
    }
  }
}
