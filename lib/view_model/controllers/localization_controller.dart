import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum Languages{english,marathi,hindi}
class LocalizationController extends ChangeNotifier{
  Locale language=const Locale('en');
  String selectLanguage='English';

  LocalizationController(String lang){
    fetchLocale(lang: lang);
  }
  fetchLocale({required String lang}){
      language=Locale(lang.isEmpty ?"en" : lang);
      notifyListeners();
  }
  changeLanguage({required Locale type})async{
    final SharedPreferences pref=await SharedPreferences.getInstance();
    if(type==Locale('en')){
      pref.setString('language_code', 'en');
    }else if(type==Locale('hi')){
      pref.setString('language_code', 'hi');
    }else{
      pref.setString('language_code', 'mr');
    }
    language=type;
    notifyListeners();
  }

  setLanguage({required String lan}){
    selectLanguage=lan;
    notifyListeners();
  }
}