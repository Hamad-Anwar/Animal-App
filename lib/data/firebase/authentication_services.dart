import 'package:animal/data/shared_pref/user_pref.dart';
import 'package:animal/main.dart';
import 'package:animal/model/user_model.dart';
import 'package:animal/utils/utils.dart';
import 'package:animal/view/authentication/details/user_details.dart';
import 'package:animal/view/authentication/otp/otp.dart';
import 'package:animal/view/home/home_page.dart';
import 'package:animal/view_model/controllers/authentication_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationServices {

  static Future<void> requestOtp(String phoneNumber,BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final authController=Provider.of<AuthenticationController>(context,listen: false);
    authController.setNumberLoading(value: true);
    await auth
        .verifyPhoneNumber(
          phoneNumber: phoneNumber,
          codeSent: (String verificationId, int? resendToken) async {
            authController.setNumberLoading(value: false);
            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(verificationID: verificationId,phoneNumber: '$phoneNumber',),
            ));
          },
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException error) {
            authController.setNumberLoading(value: false);
            Utils.showErrorDialog(context: context, error: 'Can\'t send otp! try again');
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // authController.setNumberLoading(value: false);
            // Utils.showErrorDialog(context: context, error: 'Can\'t send otp! try again');
          },
        )
        .onError(
          (error, stackTrace) {
            authController.setNumberLoading(value: false);
            Utils.showErrorDialog(context: context, error: 'Can\'t send otp! try again');
          },
        );
  }

  static Future<void> verifyOtp(String otp, String verificationId,BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final authController=Provider.of<AuthenticationController>(context,listen: false);
    authController.setOtpLoading(value: true);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    await auth
        .signInWithCredential(credential)
        .then(
          (value) async {
            FirebaseFirestore db=FirebaseFirestore.instance;
           final ref= await db.collection('users').doc(value.user!.uid).get();
            if(ref.exists){
              final currentUser=UserModel(name: ref.get('name'),
                  age: ref.get('age'), token: value.user!.uid,
                  nearestLocations: ref.get('nearestLocations'),
                  location: ref.get('postalCode'), email: ref.get('email'), phoneNumber: ref.get('phoneNumber'));
              UserPref.saveUser(user: currentUser);
              user=currentUser;
              authController.setOtpLoading(value: false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
            }else{
              authController.setOtpLoading(value: false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserDetails(),));
            }
          },
        )
        .onError(
          (error, stackTrace) {
            print('zczdf');
            authController.setOtpLoading(value: false);
            Utils.showErrorDialog(context: context, error: error.toString());
          },
        );
  }
}
