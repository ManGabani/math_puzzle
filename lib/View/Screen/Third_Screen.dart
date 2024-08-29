import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_puzzal/Controller/play_Controller/play_controller.dart';
import 'package:math_puzzal/View/Screen/WinningScreen.dart';
import 'package:math_puzzal/View/Stroage/List_Stroage.dart';

class Third_Screen extends StatelessWidget with ListStroage {
  Third_Screen({super.key, this.page});

  final int? page;
  RxBool _isLoaded = false.obs;
  RxBool _isRewardedAdLoaded = false.obs;
  var ctrl = Get.find<PlayController>();



  RewardedAd? _rewardedAd;

  @override
  Widget build(BuildContext context) {
    BannerAd _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          _isLoaded.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();

    void loadRewardedAd() {
      RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('Rewarded Ad loaded.');
            _rewardedAd = ad;
            _isRewardedAdLoaded.value = true;
          },
          onAdFailedToLoad: (err) {
            debugPrint('Failed to load a rewarded ad: $err');
            _rewardedAd = null;
          },
        ),
      );
    }

    void showRewardedAd() {
      if (_rewardedAd != null) {
        _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
            debugPrint('User earned reward: ${reward.amount} ${reward.type}');
          },
        );
        _rewardedAd = null;
        _isRewardedAdLoaded.value = false;
        loadRewardedAd();
        ctrl.nextLevel;

      }
    }

    loadRewardedAd();

    int currentLevel = page ?? ctrl.currentLevel;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          LevelNo[currentLevel],
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
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.white70,
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(49, 54, 63, 10),
      ),
      backgroundColor: Colors.black,
      body: Card(
        margin: const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 240),
        color: Colors.white12,
        child: Center(
          child: Text(
            levels[currentLevel]['question'] ?? 'Unknown',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GetX<PlayController>(
                            builder: (controller) => Text(
                              controller.answer.value,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ctrl.clearAnswer;
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_isRewardedAdLoaded.value) {
                      showRewardedAd();
                    } else {
                      ctrl.nextLevel;
                      debugPrint('Rewarded ad is not yet loaded.');
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 80,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(15)),
                      color: Colors.white12,
                    ),
                    child: Center(
                        child: Text(
                      "Skip",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (ctrl.checkAns(currentLevel)) {
                      print('Ok');
                      ctrl.nextLevel;
                      ctrl.clearAnswer;
                      Get.off(WinningScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(seconds: 1));
                    } else {
                      Get.defaultDialog(
                        title: 'Incorrect Answer',
                        middleText: 'Please try again!',
                        backgroundColor: Colors.white12,
                        titleStyle: TextStyle(color: Colors.white),
                        middleTextStyle: TextStyle(color: Colors.white),
                        radius: 8,
                      );
                      print('Wrong');
                    }
                  },
                  child: Container(
                    margin: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    height: 60,
                    width: 80,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(15)),
                      color: Colors.white12,
                    ),
                    child: const Center(
                      child: Text(
                        'ENTER',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1.1,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ctrl.buildAns('${index}');
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '${index}',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(() => _isLoaded.value
              ? Container(
                  alignment: Alignment.center,
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                )
              : CircularProgressIndicator()),
        ],
      ),
    );
  }
}
