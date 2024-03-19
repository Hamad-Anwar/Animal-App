import 'package:animal/data/shared_pref/user_pref.dart';
import 'package:animal/model/user_model.dart';
import 'package:animal/view/splash/splash_view.dart';
import 'package:animal/view_model/controllers/authentication_controller.dart';
import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:animal/view_model/controllers/localization_controller.dart';
import 'package:animal/view_model/controllers/post_controller.dart';
import 'package:animal/view_model/controllers/post_image_indicator_controller.dart';
import 'package:animal/view_model/controllers/reels_page_controller.dart';
import 'package:animal/view_model/controllers/user_details_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
UserModel? user;
BuildContext? currentContext;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String locale;
  final SharedPreferences preferences=await SharedPreferences.getInstance();
  locale=preferences.getString('language_code') ?? '';
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAB4SNUvwIhWOy6jCWai06BUQlWzTOttrk',
        appId: '1:348390019689:android:26a7cc8974a102c70b08f8',
        messagingSenderId: 'animal-dd877.appspot.com',
        storageBucket: 'animal-dd877.appspot.com',
        projectId: 'animal-dd877')
  );
  final userModel=await UserPref.getUser();
  if(userModel.token!=null){
    user=userModel;
  }
  runApp(MyApp(locale: locale,));

}
class MyApp extends StatelessWidget {
  final String locale;
  static BuildContext? c;
  const MyApp({super.key, required this.locale});
  @override
  Widget build(BuildContext context) {
    c=context;
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LocalizationController(locale),),
      ChangeNotifierProvider(create: (_) => AuthenticationController()),
      ChangeNotifierProvider(create: (_) => PostAnimalController(),),
      ChangeNotifierProvider(create: (_) => HomePageController(),),
      ChangeNotifierProvider(create: (_) => ReelPageController(),),
      ChangeNotifierProvider(create: (_) => PostImageIndicatorController(),),
      ChangeNotifierProvider(create: (_) => UserDetailsController(),),
    ],
    child: Consumer<LocalizationController>(
      builder: (context, value, child){
       return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: value.language,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,

        ],
        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
          Locale('mr'),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      );}
    ),
    );
  }

}

