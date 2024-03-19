import 'dart:async';
import 'package:animal/view/authentication/login/login.dart';
import 'package:animal/view/home/home_page.dart';
import 'package:animal/view_model/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Login(),));
      SplashServices.isLogin(context: context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(size: 50,),
            SizedBox(height: 5,),
            Text('    Animal',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
