import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_puzzal/View/Screen/Home_Page.dart';

  void main(){
    WidgetsFlutterBinding.ensureInitialized();

    MobileAds.instance.initialize();
    runApp(Math_Puzzle());
  }
class Math_Puzzle extends StatelessWidget {
  const Math_Puzzle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_Page(),
    );
  }
}
