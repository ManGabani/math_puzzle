import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:math_puzzal/View/Screen/Second_Screen.dart';
import 'package:math_puzzal/View/Screen/Second_Screen.dart';
import 'package:math_puzzal/View/Screen/Third_Screen.dart';

import '../../Controller/play_Controller/play_controller.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({Key? key});

  @override
  Widget build(BuildContext context) {
    var ctrl=Get.put(PlayController());

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(49, 54, 63, 10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsetsDirectional.fromSTEB(110, 0, 110, 50),
                color: Colors.transparent,
                child: Center(
                  child: Image.asset('image/0.png'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(Third_Screen());
              },
              child: Container(
                height: 50,
                width: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(49, 54, 63, 10),
                  //
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.asset('image/1.png'),
                    SizedBox(width: 20,),
                    Text(
                      ' Play',
                      style: TextStyle(fontSize:30, color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                Get.to(Second_Screen());
              },
              child: Container(
                height:60,
                width:170,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.asset('image/2.jpg',height:100,width:50,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Levels',
                      style: TextStyle(fontSize:30, color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height:250,),
          ],
        ),
      ),
    );
  }
}
