
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_puzzal/View/Screen/Third_Screen.dart';

import '../../Controller/play_Controller/play_controller.dart';

class WinningScreen extends StatelessWidget {
  WinningScreen({Key? key}) : super(key: key);
  RxBool _nativeadloaded = false.obs;
  NativeAd? _nativeAd;

  void loadAd() {
    _nativeAd = NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/2247696110",
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            _nativeAd=ad as NativeAd?;
            _nativeadloaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.cyan,
                backgroundColor: Colors.red,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.red,
                backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.amber,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }






  @override
  Widget build(BuildContext context) {
    loadAd();

    // var ctrl1=Get.put(PlayController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
            height: 150,
            width: 150,
            child: const Image(image: AssetImage('image/3.png')),
          ),
          const Center(
            child: Text(
              '         Congratulations!\n Your Answer is Correct.🏆',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Obx(() {
            if (_nativeadloaded.value) {
              return Container(
                alignment: Alignment.center,
                width: 320,
                height: 300,
                child: AdWidget(ad:_nativeAd!),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),

          Container(
            margin: const EdgeInsetsDirectional.fromSTEB(55, 100, 55, 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(20)),
            child: ListTile(
              leading: Image.asset('image/4.jpg'),
              title: Text(
                'Next Level',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Get.off(Third_Screen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
