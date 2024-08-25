import 'package:get/get.dart';
import '../../models/money.dart';

// ignore: camel_case_types
class daymonth extends GetxController {
  static double numday = 0;
  static double nummonth = 0;

  void increment() {
    update();
    print('is that $numday');
  }
}

// ignore: camel_case_types
class usercount extends GetxController {
  // ignore: non_constant_identifier_names
  static int box_lengh = 0;
  void increment() {
    update();
    print('is that $box_lengh');
  }
}

class userlvl extends GetxController {
  static int lvlusr = 0;
  static List<Config> lvlc = [];
  static int chcknumlvl = 0;
  static int TomanDollar = 1;
  static int FaEn = 1;

  //HomeScreen
  static int chkAdd_ubjct = 0;
  void increment() {
    update();
    // UserLevelService userLevelService = UserLevelService();
    // userLevelService.saveUserLevel();

    print('this is new usrlvl');
  }
}
