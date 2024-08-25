import 'package:moaarefyar/widgets/daychart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moaarefyar/models/money.dart';
import 'package:moaarefyar/utils/calculate.dart';
import 'package:moaarefyar/widgets/chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../constant.dart';
import 'package:intl/intl.dart';
import '../widgets/money_info_widget.dart';

// ignore: must_be_immutable
class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);
  static String restoresuc = '';
  static TextEditingController dayint = TextEditingController();
  static TextEditingController monthint = TextEditingController();
  static double daynum = 0;
  static double monthnum = 0;
  var controller = Get.put(daymonth());
  static RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  static String Function(Match) mathFunc = (Match match) => '${match[1]},';
  static String resultday =
      Calculate.dToday().toString().replaceAllMapped(reg, mathFunc);
  static String resultmonth =
      Calculate.dMonth().toString().replaceAllMapped(reg, mathFunc);
  static String resultyear =
      Calculate.dYear().toString().replaceAllMapped(reg, mathFunc);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    print(InfoScreen.resultday);
    print(myFormat.format(double.parse(Calculate.dToday().toString())));
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: userlvl.FaEn == 1
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, top: 15.0, left: 15.0),
                  // : EdgeInsets.only(right: 5.0, top: 15.0, left: 0.0),
                  child: Text(
                    userlvl.FaEn == 1 ? '  مدیریت فروش ' : 'Sales Management',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BYekan'),
                  ),
                ),
                MoneyInfoWidget(
                    firstText:
                        userlvl.FaEn == 1 ? ' : فروش امروز' : 'Sale today',
                    firstPrice: userlvl.FaEn == 1
                        ? myFormat
                            .format(double.parse(Calculate.dToday().toString()))
                            .toPersianDigit()
                        : myFormat
                            .format(double.parse(Calculate.dToday().toString()))

                    // secondText: ' : پرداختی امروز',
                    // secondPrice: Calculate.pToday().toString(),
                    ),
                Divider(
                  indent: screenWidth * 0.05,
                  endIndent: screenWidth * 0.05,
                ),
                MoneyInfoWidget(
                    firstText: userlvl.FaEn == 1
                        ? ' : فروش این ماه'
                        : 'This months sale',
                    firstPrice: userlvl.FaEn == 1
                        ? myFormat
                            .format(double.parse(Calculate.dMonth().toString()))
                            .toPersianDigit()
                        : myFormat
                            .format(double.parse(Calculate.dMonth().toString()))

                    // secondText: ' : پرداختی این ماه',
                    // secondPrice: Calculate.pMonth().toString(),
                    ),
                Divider(
                  indent: screenWidth * 0.05,
                  endIndent: screenWidth * 0.05,
                ),
                MoneyInfoWidget(
                    firstText:
                        userlvl.FaEn == 1 ? ' : فروش امسال' : 'This years sale',
                    firstPrice: userlvl.FaEn == 1
                        ? myFormat
                            .format(double.parse(Calculate.dYear().toString()))
                            .toPersianDigit()
                        : myFormat
                            .format(double.parse(Calculate.dYear().toString()))
                    // secondText: ' : پرداختی امسال',
                    // secondPrice: Calculate.pYear().toString(),
                    ),
                Divider(
                  indent: screenWidth * 0.05,
                  endIndent: screenWidth * 0.05,
                ),
                SizedBox(height: screenHeight * 0.01),
                Calculate.dMonth() == 0
                    ? Container()
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              // width: screenWidth / 2,
                              padding: const EdgeInsets.all(20.0),
                              height: 300,
                              child: BarChartWidget(),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // width: screenWidth / 2,
                              padding: const EdgeInsets.all(20.0),
                              height: 300,
                              child: BarChartdayWidget(),
                            ),
                          ),
                        ],
                      ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                          controller: InfoScreen.monthint,
                          hintText: userlvl.FaEn == 1
                              ? 'تعیین ماکزیموم ماهیانه'
                              : 'Max monthly amount',
                          type: TextInputType.number),
                    ),
                    Expanded(
                      child: MyTextField(
                        controller: InfoScreen.dayint,
                        hintText: userlvl.FaEn == 1
                            ? 'تعیین ماکزیموم روزانه'
                            : 'Max daily amount',
                        type: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        text: userlvl.FaEn == 1 ? 'اعمال شود' : 'Set',
                        onPressed: () {
                          setState(() {
                            InfoScreen.dayint.text.isNotEmpty
                                ? daymonth.numday =
                                    double.parse(InfoScreen.dayint.text)
                                : InfoScreen.daynum = 0;
                            InfoScreen.dayint.clear();
                            print('ersal shod');
                            print(daymonth.numday);
                            setState(() {});
                            InfoScreen.monthint.text.isNotEmpty
                                ? daymonth.nummonth =
                                    double.parse(InfoScreen.monthint.text)
                                : InfoScreen.monthnum = 0;
                            InfoScreen.monthint.clear();
                            setState(() {});
                          });
                          saveDayMonthData();
                        },
                        width: 160,
                        height: 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveDayMonthData() async {
    final box = await Hive.openBox<CandleD>('candleBox');
    box.clear();
    final candleD = CandleD(numD: daymonth.numday, monthD: daymonth.nummonth);
    await box.add(candleD);
    print('Data saved: numD: ${daymonth.numday}, monthD: ${daymonth.nummonth}');
  }
}

//! My TextField
class MyTextField extends StatefulWidget {
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.type,
        cursorColor: Colors.black38,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

//! MyButton
// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  MyButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.width,
      required this.height})
      : super(key: key);
  var controller = Get.put(daymonth());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: kPurpleColor,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'BYekan',
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
