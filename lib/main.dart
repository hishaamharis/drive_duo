import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_way/providers/cart.dart';
import 'package:volt_way/providers/fav.dart';
import 'package:volt_way/screen/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBUhySB2kBK7ORteaQbONWQQ1GcuPg4OsE",
          appId: "1:1005867028183:android:e71ab2832b1cc46f336a92",
          messagingSenderId: "",
          projectId: "volt-way",
          storageBucket: "volt-way.appspot.com"));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingPage()
    );
  }
}
