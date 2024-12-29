
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'GetStartedPage.dart';
import '../categories/Grills.dart';
import '../home/HomePage.dart';
import '../home/SplashScreen.dart';
import 'package:provider/provider.dart';
import '../home/FavoritesProvider.dart';
import 'user/userprovider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => userprovider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' daw project ',
      theme: ThemeData(

        // primarySwatch: Colors.amber,
        //   scaffoldBackgroundColor: Colors.lime[50],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),

    );
  }
}
