import 'package:get/get.dart';
import 'package:math_puzzal/View/Stroage/List_Stroage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayController extends GetxController with ListStroage {
  final _hint = 'Your Answer';
  RxString answer = 'Your Answer'.obs;
  static int _currentLevel = 0;

  @override
  void onInit() {
    super.onInit();
    _getcurrentlevel();
  }

  int get currentLevel => _currentLevel;

  get clearAnswer => answer.value = _hint;

  get nextLevel => _currentLevel++;

  void buildAns(String s) {
    if (answer.value == _hint) {
      answer.value = s;
    } else {
      answer.value = answer + s;
    }
  }

  bool checkAns(int cur) {
    return levels[cur]['answer'] == answer.value;

  }

  SharedPreferences? sp;
  Future<void> _getcurrentlevel() async {
    sp=await SharedPreferences.getInstance();
    _currentLevel=sp!.getInt('level')??0;
  }





}