// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:moaarefyar/screens/config_off.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moaarefyar/constant.dart';
import 'package:moaarefyar/main.dart';
import 'package:moaarefyar/models/money.dart';
import 'package:moaarefyar/screens/new_user_screen.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../utils/tile_list.dart';
import '../widgets/controllers/daymonthcandle.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  static String idcheckref = "";

  static List<Money> moneys = [];
  static List<Config> lvlc = [];
  // static List hi = [];

  static String checklevel = '';
  static int checkNumlvl = 0;
  static int test = 0;
  static int usernumberRank = 0;
  static bool changeConfig = false;

  var controller = Get.put(userlvl());

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  final TextEditingController searchController = TextEditingController();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
  Box<Config> lvlBox = Hive.box<Config>('configBox');

  // Box<Config> lvlBox = Hive.box<Config>('configBox');
  @override
  void initState() {
    MyApp.getData();
    MyApp.getLvL();
    HomeScreen.lvlc.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(HomeScreen.lvlc.length);

    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    // var controller = Get.put(daymonth());
    usercount.box_lengh = HomeScreen.moneys.length;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // backgroundColor: Color.fromARGB(255, 165, 190, 207),
      floatingActionButton: fabWidget(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            headerWidget(),

            HomeScreen.moneys.isEmpty
                ? Container()
                : Container(
                    // color: Color.fromARGB(255, 255, 160, 92),
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              userlvl.FaEn == 1 ? 'سطح' : 'Level',
                              textAlign: TextAlign.right,
                              style: titleBarTopHome,
                            )),
                        Expanded(
                            flex: 5,
                            child: Container(
                              // color: Colors.red,
                              child: Text(
                                userlvl.FaEn == 1 ? 'نام کاربر ' : 'User Name',
                                textAlign: TextAlign.center,
                                style: titleBarTopHome,
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              userlvl.FaEn == 1 ? 'دعوت' : 'Invite',
                              textAlign: TextAlign.right,
                              style: titleBarTopHome,
                            )),
                        Expanded(
                            flex: 7,
                            child: Container(
                              // color: Colors.orange,
                              child: Text(
                                userlvl.FaEn == 1 ? 'قیمت' : 'price',
                                textAlign: TextAlign.center,
                                style: titleBarTopHome,
                              ),
                            )),
                      ],
                    ),
                  ),
            //const Expanded(child: EmptyWidget()),
            Expanded(
              child: HomeScreen.moneys.isEmpty
                  ? const EmptyWidget()
                  : ListView.builder(
                      itemCount: HomeScreen.moneys.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            //* Edit
                            onTap: () {
                              print(HomeScreen.moneys[index].price);
                              //
                              createNewUser.date =
                                  HomeScreen.moneys[index].date;
                              //
                              createNewUser.descriptionController.text =
                                  HomeScreen.moneys[index].title;
                              //
                              createNewUser.priceController.text =
                                  HomeScreen.moneys[index].price;
                              //
                              createNewUser.groupId =
                                  HomeScreen.moneys[index].isReceived ? 1 : 2;
                              //
                              createNewUser.isEditing = true;
                              //
                              createNewUser.createdid =
                                  HomeScreen.moneys[index].id;
                              createNewUser.newrfrl =
                                  HomeScreen.moneys[index].countref;
                              createNewUser.emailController.text =
                                  HomeScreen.moneys[index].email;
                              createNewUser.numberController.text =
                                  HomeScreen.moneys[index].tell;
                              createNewUser.refEdit =
                                  HomeScreen.moneys[index].countref;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const createNewUser(),
                                ),
                              ).then((value) {
                                MyApp.getData();
                                setState(() {});
                              });
                            },
                            //! Delete
                            onLongPress: () {
                              Get.defaultDialog(
                                title: 'هشدار!',
                                titleStyle: const TextStyle(
                                    fontFamily: 'BYekan',
                                    fontWeight: FontWeight.bold),
                                middleText: 'آیا از حذف این آیتم مطمئن هستید؟',
                                middleTextStyle: const TextStyle(
                                    fontFamily: 'BYekan',
                                    fontWeight: FontWeight.bold),
                                textCancel: 'خیر',
                                cancelTextColor: Colors.black,
                                onCancel: () {
                                  Get.back();
                                },
                                textConfirm: 'بله',
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  hiveBox.deleteAt(index);
                                  MyApp.getData();
                                  setState(() {});
                                  Get.back();
                                },
                                buttonColor: kPurpleColor,
                              );
                            },
                            child: MyListTileWidget(index: index));
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  //! FAB Widget
  Widget fabWidget() {
    return FloatingActionButton(
      // backgroundColor: kPurpleColor,
      // backgroundColor: Colors.red,
      backgroundColor: Colors.blue.shade900,
      splashColor: Colors.amber,
      focusColor: Colors.amber,
      hoverColor: Colors.red,
      foregroundColor: Colors.white,

      elevation: 0,
      onPressed: () {
        createNewUser.date = 'تاریخ';
        createNewUser.descriptionController.text = '';
        createNewUser.priceController.text = '';
        createNewUser.groupId = 0;
        createNewUser.isEditing = false;
        createNewUser.emailController.text = '';
        createNewUser.numberController.text = '';
        createNewUser.serviceController.text = '';
        createNewUser.showfield = false;
        setState(() {
          createNewUser.createdid = Random().nextInt(99999999);
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const createNewUser(),
          ),
        ).then((value) {
          MyApp.getData();
          setState(() {});
        });
      },
      child: const Icon(Icons.add),
    );
  }

  //! Header Widget
  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: SearchBarAnimation(
                      isOriginalAnimation: false,
                      textEditingController: searchController,
                      buttonWidget: Icon(
                        Icons.search,
                        color: Colors.blue.shade300,
                      ),
                      secondaryButtonWidget: const Icon(Icons.close),
                      trailingWidget: const Icon(Icons.search_rounded),
                      hintText:
                          userlvl.FaEn == 1 ? '...جستجو کنید ' : 'Search ...',
                      buttonElevation: 0,
                      onCollapseComplete: () {
                        MyApp.getData();
                        searchController.text = '';
                        setState(() {});
                      },
                      buttonShadowColour: Colors.black26,
                      buttonBorderColour: Colors.black26,
                      onFieldSubmitted: (String text) {
                        // List<Money> result2 = hiveBox.values.toList();
                        int desiredId = int.tryParse(text) ?? -1;
                        List<Money> result = hiveBox.values
                            .where((value) =>
                                value.title.contains(text) ||
                                value.id == desiredId)
                            .toList();
                        HomeScreen.moneys.clear();
                        setState(() {
                          for (var value in result) {
                            HomeScreen.moneys.add(value);
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          print(
                              'ineeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ${userlvl.chcknumlvl}');
                          MyApp.getLvL();
                          if (HomeScreen.lvlc.isNotEmpty) {
                            print('lvalue khali nist');

                            // for (var lvalue in lvlBox.values) {
                            //   final textboxview = lvalue;
                            //   print('in textboxview ast : ${textboxview.lvl}');
                            //   CfOff.lvlTxtfield.text =
                            //       textboxview.lvl.toString();
                            // }
                            HomeScreen.lvlc.isNotEmpty
                                ? CfOff.lvlTxtfield.text =
                                    HomeScreen.lvlc[0].lvl.toString()
                                : CfOff.lvlTxtfield.text = '';

                            setState(() {});
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CfOff(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Color(0xFF0D47A1),
                        )),
                    Container(
                      width: 40,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          // const Color.fromRGBO(100, 181, 246, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        textAlign: TextAlign.center,
                        userlvl.FaEn == 1
                            ? usercount.box_lengh.toString().toPersianDigit()
                            : usercount.box_lengh.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                        userlvl.FaEn == 1 ? ' کاربران' : 'Users',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'BYekan'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
