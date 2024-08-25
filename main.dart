import 'package:introduction_slider/introduction_slider.dart';
import 'package:moaarefyar/screens/config_off.dart';
import 'package:moaarefyar/utils/calculate.dart';
import 'package:moaarefyar/widgets/controllers/hive_services.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/money.dart';
import 'screens/home_screen.dart';
import 'screens/main_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('moneyBox');

  Hive.registerAdapter(ConfigAdapter());
  await Hive.openBox<Config>('configBox');

  Hive.registerAdapter(FTDEAdapter());
  await loadFTDE();

  Hive.registerAdapter(CandleDAdapter());
  // await Hive.openBox<CandleD>('candleBox');
  var candleBox = await Hive.openBox<CandleD>('candleBox');

  if (candleBox.isNotEmpty) {
    final candleD = candleBox.values.first;
    daymonth.numday = candleD.numD;
    daymonth.nummonth = candleD.monthD;
    print('Loaded numDay: ${daymonth.numday}, numMonth: ${daymonth.nummonth}');
  } else {
    print('candlBox is empty');
  }

  // ایجاد یک شیء از کلاس AppModel
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  // final appDocumentDir = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  runApp(const MyApp());
  MyApp.getLvL();
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static void getData() {
    HomeScreen.moneys.clear();
    Box<Money> hiveBox = Hive.box<Money>('moneyBox');
    for (var value in hiveBox.values) {
      HomeScreen.moneys.add(value);
    }

    // HomeScreen.moneys.clear();
    // Box<Config> hiveBoxlvl = Hive.box<Config>('configBox');
    // for (var value in hiveBoxlvl.values) {
    //   // CfOff.lvlCf.add(value);
    // }

    // List values = hiveBox.values.toList();
    // print(values);
  }

  static void getLvL() {
    //
    Box<Config> lvlBox = Hive.box<Config>('configBox');
    // for (var lvalue in lvlBox.values) {
    //   HomeScreen.lvlc.add(lvalue);
    // }
    // CfOff.lvlTxtfield.text = 10.toString();
    print(CfOff.lvlTxtfield.text);
    for (var lvalue in lvlBox.values) {
      // HomeScreen.lvlc.add(lvalue);
      print('for bala : ${lvalue.lvl}');
      // setState(() {});
      CfOff.lvlTxtfield.text = lvalue.lvl.toString();
      userlvl.lvlusr = lvalue.lvl;
    }

    // if (HomeScreen.lvlc == null) {
    //   // Config setlvl = Config(lvl: 10);
    //   // lvlBox.add(setlvl);
    //   // for (var lvalue in lvlBox.values) {
    //   //   HomeScreen.lvlc.add(lvalue);
    //   // }
    // } else {
    //   print("lvlBox is not empty");
    //   // print(); refferal
    // }
    if (lvlBox.isNotEmpty) {
      HomeScreen.changeConfig = true;

      print(' lvlbox is not empty');
    } else {
      print('lvlbox is empty');
      CfOff.lvlTxtfield.text == '' ? CfOff.lvlTxtfield.text = '10' : null;
      // userlvl.lvlusr = int.parse('10');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'BYekan'),
      debugShowCheckedModeBanner: false,
      title: 'معرفیار',
      home: AnimatedSplashScreen(
        duration: 500,
        backgroundColor: Colors.white,
        animationDuration: const Duration(seconds: 3),
        centered: true,
        splashTransition: SplashTransition.scaleTransition,
        curve: Curves.ease,
        splash: Image.asset(
          'assets/images/MoarefYarLogo.png',
          // width: 300,
          // height: 120,
          width: 300,
          height: 300,
          scale: 2,
          // fit: BoxFit.,
          // filterQuality: FilterQuality.high,
        ),
        nextScreen: hiveBox.isNotEmpty
            ? const MainScreen()
            : IntroductionSlider(
                items: [
                  IntroductionSliderItem(
                    logo: Image.asset('assets/images/intro1.png'),
                    title: const Text("1"),
                    backgroundColor: Colors.blueAccent,
                  ),
                  IntroductionSliderItem(
                      logo: Image.asset('assets/images/intro2.png'),
                      title: const Text("2"),
                      backgroundColor: Colors.blueAccent),
                  IntroductionSliderItem(
                    logo: Image.asset('assets/images/intro3.png'),
                    title: const Text("3"),
                    backgroundColor: Colors.blueAccent,
                  ),
                ],
                done: const Done(
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  home: MainScreen(),
                ),
                next: const Next(
                    child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )),
                back: const Back(
                    child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
                dotIndicator: const DotIndicator(selectedColor: Colors.white),
              ),
      ),
    );
  }
}
