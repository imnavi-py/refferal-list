import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../models/money.dart';
import '../screens/config_off.dart';
import '../screens/home_screen.dart';

class MyListTileWidget extends StatefulWidget {
  final int index;
  const MyListTileWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<MyListTileWidget> createState() => _MyListTileWidgetState();
}

class _MyListTileWidgetState extends State<MyListTileWidget> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  Widget build(BuildContext context) {
    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    // final myFormat = NumberFormat('#,##0.######', 'en_US');

    final String cointref =
        (HomeScreen.moneys[widget.index].countref.toString());
    // print('this is cointref ${cointref}');

    // final String idref = (HomeScreen.moneys[widget.index].countref.toString());
    HomeScreen.idcheckref = (HomeScreen.moneys[widget.index].id.toString());

    setState(() {});
    // print(HomeScreen.idcheckref);
    // List<Money> usr_rank = hiveBox.values.toList();

    final int usrRanknum = HomeScreen.moneys[widget.index].countref;
    setState(() {
      // HomeScreen.usernumberRank = usrRanknum!;
    });
    if (usrRanknum >= 0 && usrRanknum <= 20) {
      // HomeScreen.checklevel = 'assets/images/${usrRanknum + 1}.png';
      HomeScreen.checkNumlvl = usrRanknum + 1;
      userlvl.chcknumlvl = HomeScreen.checkNumlvl;
      print('checknum lvl  : ${userlvl.chcknumlvl}');

      setState(() {});
    } else {
      print('no');
      HomeScreen.checklevel = 'assets/images/7.png'; // یا مقدار دلخواه دیگر
    }

    print(HomeScreen.checkNumlvl.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            // height: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      // color:
                      //     HomeScreen.moneys[index].isReceived ? KGreenColor : kRedColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(children: [
                      Center(
                          child: Container(
                        width: 70,
                        height: 70,
                        child: Image.asset('assets/images/level.png'),
                      )),
                      Center(
                          child: Text(
                        HomeScreen.changeConfig == false
                            ? userlvl.chcknumlvl.toString().toPersianDigit()
                            : int.parse(CfOff.lvlTxtfield.text) <=
                                    HomeScreen.checkNumlvl
                                ? 'VIP'
                                : userlvl.FaEn == 1
                                    ? userlvl.chcknumlvl
                                        .toString()
                                        .toPersianDigit()
                                    : userlvl.chcknumlvl.toString(),
                        style: CfOff.lvlTxtfield.text.isNotEmpty
                            ? int.parse(CfOff.lvlTxtfield.text) <=
                                    HomeScreen.checkNumlvl
                                ? const TextStyle(color: Colors.red)
                                : const TextStyle(color: Colors.white)
                            : null,
                      ))
                    ]),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      // color: Colors.red,
                      width: 100,
                      child: Text(
                        HomeScreen.moneys[widget.index].title,
                        style:
                            const TextStyle(fontSize: 15, fontFamily: 'BYekan'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      userlvl.FaEn == 1 ? cointref.toPersianDigit() : cointref,
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Color.fromARGB(255, 182, 166, 230)
                    ),
                    // color: const Color.fromARGB(255, 102, 140, 196),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.centerRight,
                      // color: const Color.fromARGB(255, 51, 84, 149),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            userlvl.TomanDollar == 1 ? 'تومان' : '\$',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blue.shade300,
                              // color: Color.fromARGB(255, 255, 160, 92),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const SweepGradient(
                                    colors: Colors.accents)),
                            alignment: Alignment.center,
                            child: Text(
                              userlvl.FaEn == 1
                                  ? '${HomeScreen.moneys[widget.index].price.seRagham().toPersianDigit()}'
                                  : '${HomeScreen.moneys[widget.index].price.seRagham()}',
                              // HomeScreen.moneys[widget.index].price,

                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.blue.shade900),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              userlvl.FaEn == 1
                  ? HomeScreen.moneys[widget.index].date.toPersianDigit()
                  : HomeScreen.moneys[widget.index].date,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(136, 96, 125, 139)),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

//! Empty Widget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          // 'assets/images/nodata.svg',
          'assets/images/No data-cuate.svg',
          height: 150,
          width: 150,
        ),
        const SizedBox(height: 10),
        userlvl.FaEn == 1
            ? const Text(' ! کاربری موجود نیست')
            : const Text('There is no user yet!'),
        const Spacer(),
      ],
    );
  }
}
