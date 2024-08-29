import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:math_puzzal/View/Screen/Third_Screen.dart';
import 'package:math_puzzal/View/Stroage/List_Stroage.dart';


class Second_Screen extends StatelessWidget with ListStroage {
  Second_Screen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'LEVELS',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white70,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white70,
                )),
          ],
          backgroundColor:    Color.fromRGBO(49, 54, 63, 10),
        ),
        backgroundColor: Colors.white12,
        body: GridView.builder(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: levels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(Third_Screen(page: index,));
              },

              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Text(
                  '${index + 1}',

                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
              ),
            );
          },
        ));
  }
}
