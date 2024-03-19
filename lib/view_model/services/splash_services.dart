import 'dart:async';

import 'package:animal/data/shared_pref/user_pref.dart';
import 'package:animal/view/authentication/login/login.dart';
import 'package:animal/view/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashServices{
  static isLogin({required BuildContext context}){
    Timer(Duration(seconds: 2), () async {
      if((await UserPref.getUser()).token!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      }
    });
  }
}