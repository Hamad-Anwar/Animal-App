import 'dart:ffi';

import 'package:animal/data/firebase/authentication_services.dart';
import 'package:animal/utils/utils.dart';
import 'package:animal/view/authentication/otp/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationController extends ChangeNotifier{
  bool otpLoading=false;
  bool numberLoading=false;
  final TextEditingController number=TextEditingController();
  final TextEditingController otp1=TextEditingController();
  final TextEditingController otp2=TextEditingController();
  final TextEditingController otp3=TextEditingController();
  final TextEditingController otp4=TextEditingController();
  final TextEditingController otp5=TextEditingController();
  final TextEditingController otp6=TextEditingController();



  getOtp({required BuildContext context}) async {
    if(number.value.text.toString().isEmpty){
      Utils.showErrorDialog(context: context, error: 'Please enter corerct number');
      return;
    }
    try {
     await AuthenticationServices.requestOtp(number.value.text.toString(), context);
    }catch(_){}
    // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(verificationID: ''),));
  }

  setNumberLoading({required bool value}){
    numberLoading=value;
    notifyListeners();
  }
  setOtpLoading({required bool value}){
    otpLoading=value;
    notifyListeners();
  }

  verifyOtp({required BuildContext context,required String verificationID}){
    otpLoading=true;
    notifyListeners();
    AuthenticationServices.verifyOtp(
    otp1.value.text.toString() + otp2.value.text.toString() +
        otp3.value.text.toString() + otp4.value.text.toString()+
        otp5.value.text.toString() + otp6.value.text.toString()
    , verificationID,context).then((value){
      otpLoading=false;
      notifyListeners();
    }).onError((error, stackTrace){
      otpLoading=false;
      notifyListeners();
    });
  }

}