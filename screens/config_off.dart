import 'package:android_intent_plus/android_intent.dart';
import 'package:moaarefyar/models/money.dart';
import 'package:moaarefyar/screens/info_screen.dart';
import 'package:moaarefyar/screens/main_screen.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moaarefyar/screens/home_screen.dart';
import 'package:moaarefyar/widgets/controllers/hive_services.dart';
import '../constant.dart';
import '../main.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import 'package:csv/csv.dart';
import '../widgets/toggle_switch.dart';

// ignore: must_be_immutable
class CfOff extends StatefulWidget {
  CfOff({Key? key}) : super(key: key);

  static TextEditingController lvlTxtfield = TextEditingController();
  var controller = Get.put(userlvl());
  @override
  State<CfOff> createState() => _CfOffState();
}

class _CfOffState extends State<CfOff> with TickerProviderStateMixin {
  Box<Config> lvlBox = Hive.box<Config>('configBox');
  late AnimationController controller;
  bool hasChanges = false;
  bool outContex = true;
  bool textisChanged = false;
  double screenWidth = 0;
  double screenHeight = 0;

  void commentMyket() async {
    const intent = AndroidIntent(
      action: 'action_view',
      // type: 'plain/text',
      data: 'myket://comment?id=com.nvico.moarrefyar',
    );
    await intent.launch();
  }

  void openMyket() async {
    const intent = AndroidIntent(
      action: 'action_view',
      // type: 'plain/text',
      data: 'myket://details?id=com.nvico.moarrefyar',
    );
    await intent.launch();
  }

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  initState() {
    super.initState();
    MyApp.getData();
    MyApp.getLvL();
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    controller.duration = const Duration(seconds: 1);
    // Animation duration for retracting the BottomSheet
    controller.reverseDuration = const Duration(seconds: 1);
    // Set animation curve duration for the BottomSheet
    controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

//
  Future<bool> _onBackPressed() async {
    if (hasChanges) {
      // نمایش دیالوگ و دریافت پاسخ کاربر
      final shouldLeave = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            textAlign: TextAlign.center,
            userlvl.FaEn == 1 ? 'تغییرات ذخیره نشده' : 'Unsaved changes',
            style: const TextStyle(fontFamily: 'BYekan', fontSize: 20),
          ),
          content: Text(
            textAlign: userlvl.FaEn == 1 ? TextAlign.right : TextAlign.left,
            userlvl.FaEn == 1 ? 'آیا تغییرات ذخیره شوند؟' : 'Save changes?',
            style: const TextStyle(
                fontFamily: 'BYekan',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                ).then((value) {
                  // این بخش پس از بازگشت از NewTransActionsScreen اجرا می‌شود
                  MyApp
                      .getData(); // فرض می‌کنیم این متد برای بارگذاری داده‌ها است
                  MyApp.getLvL();
                  setState(() {
                    // این دستور باعث رفرش صفحه می‌شود
                  });
                });

                acceptChanges();
              },
              child: Text(
                userlvl.FaEn == 1 ? 'بله' : 'Yes',
                style: const TextStyle(
                    fontFamily: 'BYekan',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },

              // => Navigator.of(context).pop(false),
              child: Text(
                userlvl.FaEn == 1 ? 'خیر' : 'No',
                style: const TextStyle(
                    fontFamily: 'BYekan',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
      return shouldLeave ?? false;
    } else if (outContex) {
      outContex = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      ).then((value) {
        // این بخش پس از بازگشت از NewTransActionsScreen اجرا می‌شود
        MyApp.getData(); // فرض می‌کنیم این متد برای بارگذاری داده‌ها است
        MyApp.getLvL();
        setState(() {
          // این دستور باعث رفرش صفحه می‌شود
        });
      });
    }
    return true;
  } //

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.white,
          // Colors.grey.shade300,
          appBar: AppBar(
            title: Text(
              userlvl.FaEn == 1 ? 'تنظیمات' : 'Settings',
              style: const TextStyle(
                  fontFamily: 'BYekan',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
                onPressed: () async {
                  if (await _onBackPressed()) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image.asset(
                                        'assets/images/language.png')),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    // color: Colors.amber,
                                    width: 120,
                                    child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: toggleSwitch(
                                          toggleindex: (index) {
                                            userlvl.FaEn = index;
                                            // index = indx;
                                            hasChanges = true;
                                            print(index);
                                            setState(() {});
                                          },
                                          initialLabelIndex: userlvl.FaEn,
                                          insideToggle: const ['En', 'Fa'],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                    // color: Colors.amber,
                                    width: 100,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        userlvl.FaEn == 1 ? 'زبان' : 'Language',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            fontFamily: 'BYekan',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    'assets/images/cost.png',
                                    width: 40,
                                    height: 40,
                                    scale: 5.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    // color: Colors.amber,
                                    width: 120,
                                    child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: toggleSwitch(
                                          toggleindex: (index) {
                                            userlvl.TomanDollar = index;
                                            hasChanges = true;
                                            print(index);
                                          },
                                          initialLabelIndex:
                                              userlvl.TomanDollar,
                                          insideToggle: const ['دلار', 'تومان'],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                    width: 100,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        userlvl.FaEn == 1
                                            ? 'واحد پول'
                                            : 'Cost Unit',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            fontFamily: 'BYekan',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 60,
                                    height: 60,
                                    child:
                                        Image.asset('assets/images/level.png')),
                                SizedBox(
                                    width: 80,
                                    child: fieldonEdit(
                                      onChanged: (value) {
                                        hasChanges = true;
                                        textisChanged = true;
                                      },
                                    )),
                                SizedBox(
                                    width: 100,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        userlvl.FaEn == 1
                                            ? 'حداکثر سطح'
                                            : 'MaxLevel',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                            fontFamily: 'BYekan',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kPurpleColor)),
                            onPressed: () {
                              acceptChanges();
                            },
                            child: Text(
                              userlvl.FaEn == 1 ? 'اعمال' : 'Apply',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'BYekan',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          height: 50,
                          width: 160,
                          text: userlvl.FaEn == 1
                              ? 'تنظیمات پیش فرض'
                              : 'Reset Settings',
                          onPressed: () {
                            setState(() {
                              lvlBox.clear();
                              HomeScreen.lvlc.clear();
                              userlvl.lvlc.clear();
                              // print('1');
                              MyApp.getLvL();
                              Config setlvl = Config(lvl: 10);
                              lvlBox.add(setlvl);
                              for (var lvalue in lvlBox.values) {
                                // HomeScreen.lvlc.add(lvalue);
                                userlvl.lvlc.add(lvalue);
                              }
                              setState(() {});
                              userlvl.lvlusr = 10;
                              CfOff.lvlTxtfield.text =
                                  userlvl.lvlc[0].lvl.toString();
                              // print('2');
                              HomeScreen.changeConfig = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),

                      /////////////////////////// DATA MANAGMENT ////////////////////////////

                      Expanded(
                        child: MyButton(
                          onPressed: () {
                            // showModal(context);
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(
                                      Icons.backup,
                                      color: Colors.blue,
                                    ),
                                    title: Text(
                                      userlvl.FaEn == 1
                                          ? 'پشتیبان گیری'
                                          : 'Backup',
                                      style: const TextStyle(
                                          fontFamily: 'BYekan',
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    onTap: () {
                                      // Get.changeTheme(ThemeData.light());
                                      fetch();
                                      Get.back();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.restore_sharp,
                                      color: Colors.green,
                                    ),
                                    title: Text(
                                      userlvl.FaEn == 1 ? 'بازیابی' : 'Restore',
                                      style: const TextStyle(
                                        fontFamily: 'BYekan',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onTap: () {
                                      _restoreDataFromCSV(context);
                                      Get.back();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.blue,
                                    ),
                                    title: Text(
                                      userlvl.FaEn == 1
                                          ? 'پاک کردن داده ها'
                                          : 'Delete everything',
                                      style: const TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontFamily: 'BYekan'),
                                      textAlign: TextAlign.center,
                                    ),
                                    onTap: () {
                                      // Get.changeTheme(ThemeData.light());
                                      HomeScreen.moneys.clear();
                                      _ResetDataBase();

                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ));
                          },
                          text: userlvl.FaEn == 1
                              ? 'مدیریت داده'
                              : 'Data Management',
                          height: 50,
                          width: 160,
                        ),
                      ),
                      //////////////////////////// DATA MANAGMENT ///////////////////////////
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(kPurpleColor)),
                              onPressed: () {
                                commentMyket();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userlvl.FaEn == 1
                                        ? 'انتقاد و پیشنهاد'
                                        : 'commenting',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'BYekan'),
                                  ),
                                  const Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ))),
                      Expanded(
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(kPurpleColor)),
                              onPressed: () {
                                openMyket();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userlvl.FaEn == 1
                                        ? 'معرفیار در مایکت'
                                        : 'Open on Myket',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'BYekan'),
                                  ),
                                  const Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              )))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

// Accept Changes
  void acceptChanges() {
    if (CfOff.lvlTxtfield.text != '') {
      var txtinput = int.parse(CfOff.lvlTxtfield.text);
      print('Writing ...');
      print(txtinput);
      HomeScreen.changeConfig = true;

      // print(txtinput);
      // MyApp.getData();

      // lvlBox.clear();
      MyApp.getLvL();
      lvlBox.clear();
      Config setlvl = Config(lvl: txtinput);
      lvlBox.add(setlvl);
      setState(() {});
      print("in shod ${txtinput}");
      // HomeScreen.lvlc.length;
      // HomeScreen.lvlc.clear();
      userlvl.lvlc.length;
      userlvl.lvlc.clear();
      print('lentgh : ${userlvl.lvlc.length}');
      for (var lvalue in lvlBox.values) {
        userlvl.lvlc.add(lvalue);
        print('dakhel lvlc : ${userlvl.lvlc[0].lvl}');
      }
      setState(() {});
      print('lentgh : ${userlvl.lvlc.length}');

      setState(() {
        CfOff.lvlTxtfield.text = txtinput.toString();
        userlvl.lvlusr = int.parse(CfOff.lvlTxtfield.text);
      });
      saveFTDE();
      // MyApp.getData();
    } else {
      print('field is empty');
    }
    hasChanges = false;
  }

  ///////////////////////////////////// DATA MANAGEMENT ////////////////////////////////////////
  //BackUP Data
  void fetch() async {
    final PermissionStatus status =
        await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      Hive.init(null);
      final box = await Hive.openBox<Money>('moneyBox');
      final dataList = box.values.toList();
      final csvData = dataList.map((item) {
        return [
          item.id,
          item.title,
          item.price,
          item.date,
          item.isReceived,
          item.countref,
          item.email,
          item.tell,
          item.service,
        ];
      }).toList();
      final csv = const ListToCsvConverter().convert(csvData);

      final directory = Directory('/storage/emulated/0/moarefyar');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      String filePath = p.join(directory.path, 'backup.csv');

      int fileNumber = 1;
      while (await File(filePath).exists()) {
        final fileName = p.basename(filePath);
        final extension = p.extension(fileName);
        final fileNameWithoutExtension = p.basenameWithoutExtension(fileName);
        filePath = p.join(directory.path, 'backup$fileNumber$extension');
        fileNumber++;
      }

      final csvFile = File(filePath);
      await csvFile.writeAsString(csv);

      print('Data saved to CSV file: $filePath');
      Get.snackbar('', '',
          messageText: Text(
            userlvl.FaEn == 1
                ? ' اطلاعات شما با موفقیت پشتیبان گیری شد \n $filePath '
                : 'Your data has been successfully backed up\n $filePath',
            style: const TextStyle(
                fontFamily: 'Irs', color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 5),
          forwardAnimationCurve: Curves.bounceInOut,
          reverseAnimationCurve: Curves.easeInOutSine,
          backgroundColor: kPurpleColor);

      // Close Hive
      // await Hive.close();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      print('WRITE_EXTERNAL_STORAGE permission denied');
    }
  }

  //Restore Data

  Future<void> _restoreDataFromCSV(BuildContext context) async {
    final PermissionStatus status12 =
        await Permission.manageExternalStorage.request();
    final PermissionStatus status = await Permission.photos.request();
    final PermissionStatus status_audio = await Permission.audio.request();
    final PermissionStatus status_video = await Permission.videos.request();
    if (status.isGranted && status_audio.isGranted && status_video.isGranted ||
        status12.isGranted) {
      try {
        final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['csv'],
            withData: true,
            withReadStream: true,
            allowMultiple: true,
            initialDirectory:
                '/storage/emulated/0/Android/data/com.nvico.moarrefyar/');

        print(result);

        if (result != null && result.files.isNotEmpty) {
          final String filePath =
              // '/storage/emulated/0/Android/data/com.nvico.moarrefyar/files/backup.csv';
              result.files.single.path!;
          print(filePath);

          // Read the CSV file
          final csvFile = File(filePath);
          final csvString = await csvFile.readAsString();

          // Convert CSV to data list
          final csvData = const CsvToListConverter().convert(csvString);
          print('/////////////////////////////////////////////////////////');
          print(csvData);

          // Open the Hive box
          final box = await Hive.openBox<Money>('moneyBox');

          // Clear existing data in the box
          await box.clear();

          // Add data to the box
          for (final rowData in csvData) {
            final money = Money(
              id: int.parse('${rowData[0]}'),
              title: '${rowData[1]}',
              price: '${rowData[2]}',
              date: '${rowData[3]}',
              // ignore: sdk_version_since
              isReceived: bool.parse(rowData[4]),
              countref: int.parse('${rowData[5]}'),
              email: rowData.length > 6 ? '${rowData[6]}' : 'None',
              tell: rowData.length > 7 ? '${rowData[7]}' : 'None',
              service: rowData.length > 8 ? '${rowData[8]}' : 'None',
            );

            await box.add(money);
          }

          print('Data restored from CSV file: $filePath');
          InfoScreen.restoresuc = 'Data restored from CSV file: $filePath';
          setState(() {});
          Get.snackbar('', '',
              messageText: Text(
                userlvl.FaEn == 1
                    ? ' اطلاعات شما با موفقیت بازیابی شد  '
                    : 'Your information has been successfully retrieved',
                style: const TextStyle(
                    fontFamily: 'Irs', color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              colorText: Colors.white,
              animationDuration: const Duration(seconds: 1),
              duration: const Duration(seconds: 5),
              forwardAnimationCurve: Curves.bounceInOut,
              reverseAnimationCurve: Curves.easeInOutSine,
              backgroundColor: kPurpleColor);

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Data restored from CSV file: $filePath'),
          //   ),
          // );
        }
      } catch (e) {
        print('Error restoring data from CSV: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error restoring data from CSV'),
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      print('WRITE_EXTERNAL_STORAGE permission denied');
    }
  }

  void _ResetDataBase() async {
    Box<Money> hiveBox = Hive.box<Money>('moneyBox');
    await hiveBox.clear();
    HomeScreen.moneys.clear();
    Get.snackbar('', '',
        messageText: Text(
          userlvl.FaEn == 1
              ? 'داده ها با موفقیت حذف شدند'
              : 'Data deleted successfully',
          style: const TextStyle(
              fontFamily: 'Irs', color: Colors.white, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        colorText: Colors.white,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 5),
        forwardAnimationCurve: Curves.bounceInOut,
        reverseAnimationCurve: Curves.easeInOutSine,
        backgroundColor: kPurpleColor);
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////
}

class fieldonEdit extends StatefulWidget {
  const fieldonEdit({
    super.key,
    required this.onChanged,
  });
  final ValueChanged<String?> onChanged;

  @override
  State<fieldonEdit> createState() => _fieldonEditState();
}

class _fieldonEditState extends State<fieldonEdit> {
  // Box<Config> hiveBoxlvl = Hive.box<Config>('configBox');
  @override
  void initState() {
    // MyApp.getData();
    MyApp.getLvL();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("in meghdar ${HomeScreen.lvlc.length}");
    if (HomeScreen.lvlc.isNotEmpty) {
      print(HomeScreen.lvlc[0].lvl);
    }
    // HomeScreen.lvlc.isNotEmpty
    //     ? CfOff.lvlTxtfield.text = HomeScreen.lvlc[0].lvl.toString()
    //     : CfOff.lvlTxtfield.text = '';
    setState(() {});
    // hiveBoxlvl.isEmpty ? lvls = '0' : lvls = hiveBoxlvl.get(0)!.lvl.toString();

    // print(lvl);
    // CfOff.lvlTxtfield.text = lvl.toString();
    return TextField(
      onChanged: widget.onChanged,
      controller: CfOff.lvlTxtfield,
      cursorColor: Colors.amber,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
        hintStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}
