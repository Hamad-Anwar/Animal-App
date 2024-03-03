import 'package:animal/view/splash/splash_view.dart';
import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:animal/view_model/controllers/post_animal_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAB4SNUvwIhWOy6jCWai06BUQlWzTOttrk',
        appId: '1:348390019689:android:26a7cc8974a102c70b08f8',
        messagingSenderId: 'animal-dd877.appspot.com',
        projectId: 'animal-dd877')
  );

  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PostAnimalController(),),
      ChangeNotifierProvider(create: (_) => HomePageController(),),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    ),
    );
  }
}

