import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
import '../constant.dart';
import '../main.dart';
import '../models/money.dart';
import 'package:flutter/services.dart';
import '../widgets/my_textfield.dart';
import '../widgets/mybutton.dart';
import '../widgets/type_date_widget.dart';

class createNewUser extends StatefulWidget {
  const createNewUser({Key? key}) : super(key: key);
  static List<Money> moneys = [];
  static int groupId = 0;
  static bool showfield = false;

  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController reffController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController numberController = TextEditingController();
  static TextEditingController serviceController = TextEditingController();
  static bool isEditing = false;
  // static int id = 0;
  static int createdid = 0;
  static String newid = '';
  static String user = '';
  static String date = 'تاریخ';
  // static String date = userlvl.FaEn == 1 ? 'تاریخ' : 'Date';
  // static TextEditingController fr = createNewUser.reffController;
  static int newrfrl = 0;
  static String sen = 'None';
  static int sennum = 0;
  static String sendate = '1402/01/01';
  static int refEdit = 0;

  @override
  // ignore: library_private_types_in_public_api
  _createNewUserState createState() => _createNewUserState();
}

class _createNewUserState extends State<createNewUser> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }

  String addTitle = userlvl.FaEn == 1 ? 'ثبت کاربر جدید' : 'Add New User';
  String editTitle = userlvl.FaEn == 1 ? 'ویرایش کاربر' : 'Edit User';
  String usrname = userlvl.FaEn == 1 ? 'نام مشتری' : 'Name';
  String refralCode = userlvl.FaEn == 1 ? 'کد دعوت' : 'Referall code';
  String payFromcust = userlvl.FaEn == 1 ? 'مبلغ' : 'Amount paid';
  String serviceName = userlvl.FaEn == 1 ? 'سرویس' : 'Service Name';
  String usremail = userlvl.FaEn == 1 ? 'ایمیل' : 'Email';
  String tellphone = userlvl.FaEn == 1 ? 'شماره' : 'CellNumber';
  String copyCode = userlvl.FaEn == 1 ? 'کپی کد' : 'Copy';
  String usrref = userlvl.FaEn == 1 ? 'ساخت کد معرف' : 'Create refer code';
  String usrInfo = userlvl.FaEn == 1 ? 'با مشخصات' : 'with informaion';
  String wusrInfo = userlvl.FaEn == 1 ? 'بدون مشخصات' : 'without informaion';
  String addUsr = userlvl.FaEn == 1 ? 'اضافه کردن' : 'Add User';
  String editUsr = userlvl.FaEn == 1 ? 'ویرایش کردن' : 'Edit';
  // String recordHistory = userlvl.FaEn == 1 ? 'تاریخ' : 'Date';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  createNewUser.isEditing ? editTitle : addTitle,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BYekan'),
                ),
                Icon(createNewUser.isEditing
                    ? Icons.edit
                    : Icons.new_label_sharp),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: usrname,
                  controller: createNewUser.descriptionController,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextField(
                  enablefield: createNewUser.isEditing ? false : true,
                  hintText: refralCode,
                  type: TextInputType.number,
                  controller: createNewUser.reffController,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextField(
                  hintText: payFromcust,
                  type: TextInputType.number,
                  controller: createNewUser.priceController,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  onPressed: () {
                    if (createNewUser.showfield == false) {
                      createNewUser.showfield = true;
                      setState(() {});
                    } else {
                      createNewUser.showfield = false;
                      setState(() {});
                    }
                  },
                  text: createNewUser.showfield ? wusrInfo : usrInfo,
                  width: 175,
                  height: 30,
                ),
                Visibility(
                  visible: createNewUser.showfield,
                  child: MyTextField(
                    hintText: serviceName,
                    controller: createNewUser.serviceController,
                  ),
                ),
                Visibility(
                  visible: createNewUser.showfield,
                  child: MyTextField(
                    hintText: usremail,
                    controller: createNewUser.emailController,
                  ),
                ),
                Visibility(
                  visible: createNewUser.showfield,
                  child: MyTextField(
                    hintText: tellphone,
                    type: TextInputType.number,
                    controller: createNewUser.numberController,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(ClipboardData(
                                      text: "${createNewUser.createdid}"))
                                  .then((_) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  userlvl.FaEn == 1
                                      ? 'کد دعوت در کلیپ برد کپی شد'
                                      : 'The invitation code was copied to the clipboard',
                                  textAlign: userlvl.FaEn == 1
                                      ? TextAlign.right
                                      : TextAlign.left,
                                )));
                              });

                              // copied successfully
                            },
                            child: Text(
                              createNewUser.createdid.toString(),
                            ))),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                        child: MyButton(
                      onPressed: () async {
                        if (createNewUser.isEditing) {
                          await Clipboard.setData(ClipboardData(
                                  text: "${createNewUser.createdid}"))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              userlvl.FaEn == 1
                                  ? 'کد رفرال در کلیپ برد کپی شد'
                                  : 'The invitation code was copied to the clipboard',
                              textAlign: userlvl.FaEn == 1
                                  ? TextAlign.right
                                  : TextAlign.left,
                            )));
                          });

                          // copied successfully
                        } else {
                          setState(() {
                            createNewUser.createdid =
                                Random().nextInt(99999999);
                          });
                        }
                      },
                      text: createNewUser.isEditing ? copyCode : usrref,
                      height: 30,
                      width: 170,
                    ))
                  ],
                ),
                const SizedBox(height: 20),
                const TypeAndDateWidget(),
                const SizedBox(height: 20),
                MyButton(
                  text: createNewUser.isEditing ? editUsr : addUsr,
                  onPressed: () {
                    //

                    //

                    //
                    if (createNewUser.isEditing) {
                      Money item = Money(
                        id: createNewUser.createdid,
                        title: createNewUser.descriptionController.text.isEmpty
                            ? createNewUser.sen
                            : createNewUser.descriptionController.text,
                        price: createNewUser.priceController.text.isEmpty
                            ? createNewUser.sennum.toString()
                            : createNewUser.priceController.text,
                        date: createNewUser.date == 'تاریخ' ||
                                createNewUser.date == 'Date'
                            ? createNewUser.sendate
                            : createNewUser.date,
                        isReceived: createNewUser.groupId == 1 ? true : false,
                        countref: createNewUser.refEdit,
                        email: createNewUser.emailController.text.isEmpty
                            ? createNewUser.sen
                            : createNewUser.emailController.text,
                        tell: createNewUser.numberController.text.isEmpty
                            ? createNewUser.sen
                            : createNewUser.numberController.text,
                        service: createNewUser.serviceController.text.isEmpty
                            ? createNewUser.sen
                            : createNewUser.serviceController.text,
                        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      );
                      createNewUser.showfield ? false : false;
                      setState(() {});
                      int index = 0;
                      MyApp.getData();
                      for (int i = 0; i < hiveBox.values.length; i++) {
                        if (hiveBox.values.elementAt(i).id ==
                            createNewUser.createdid) {
                          index = i;
                        }
                      }

                      hiveBox.putAt(index, item);
                      Navigator.pop(context);
                    }
                    //condition
                    else {
                      if (createNewUser.descriptionController.text == '' ||
                          createNewUser.date == 'تاریخ' ||
                          createNewUser.date == 'Date') {
                        Get.defaultDialog(
                            title: userlvl.FaEn == 1 ? 'خطا' : 'Error',
                            titleStyle: TextStyle(fontFamily: 'BYekan'),
                            middleText: userlvl.FaEn == 1
                                ? 'فیلد ها را پر کنید'
                                : 'Fill in the fields',
                            middleTextStyle: TextStyle(fontFamily: 'BYekan'));
                      } else {
                        Money item = Money(
                          id: createNewUser.createdid,
                          title:
                              createNewUser.descriptionController.text.isEmpty
                                  ? createNewUser.sen
                                  : createNewUser.descriptionController.text,
                          price: createNewUser.priceController.text.isEmpty
                              ? createNewUser.sennum.toString()
                              : createNewUser.priceController.text,
                          date: createNewUser.date == 'تاریخ' ||
                                  createNewUser.date == 'Date'
                              ? createNewUser.sendate
                              : createNewUser.date,
                          isReceived: createNewUser.groupId == 1 ? true : false,
                          countref: 0,
                          email: createNewUser.emailController.text.isEmpty
                              ? createNewUser.sen
                              : createNewUser.emailController.text,
                          tell: createNewUser.numberController.text.isEmpty
                              ? createNewUser.sen
                              : createNewUser.numberController.text,
                          service: createNewUser.serviceController.text.isEmpty
                              ? createNewUser.sen
                              : createNewUser.serviceController.text,
                          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        );
                        // ignore: non_constant_identifier_names
                        final int check_id = createNewUser.createdid;
                        print('im a $check_id');
                        List<Money> list_ID = hiveBox.values
                            .where((value) => value.id == check_id)
                            .toList();

                        if (list_ID.isNotEmpty) {
                          final userExist = list_ID[0].title;
                          Get.defaultDialog(
                            title: userlvl.FaEn == 1 ? '!خطا' : 'Error!',
                            titleStyle: const TextStyle(
                                fontFamily: 'BYekan',
                                fontWeight: FontWeight.bold),
                            middleText: userlvl.FaEn == 1
                                ? '!این کد آیدی رفرال موجود است \nمربوط به کاربر\n$userExist\nمی باشد'
                                : 'This invitation code \nis available and \nis for $userExist',
                            middleTextStyle: const TextStyle(
                                fontFamily: 'BYekan',
                                fontWeight: FontWeight.bold),
                            textConfirm:
                                userlvl.FaEn == 1 ? 'فهمیدم' : 'I understood',
                            confirmTextColor: Colors.white,
                            buttonColor: kPurpleColor,
                            barrierDismissible: false,
                            onConfirm: () {
                              Get.back();
                            },
                          );
                        } else {
                          ///////////// Green State ////////////
                          //user can be register now
                          //check user refferal textfield first if exist put(at) user & add user refferal

                          if (createNewUser.reffController.text.isNotEmpty) {
                            final int gg =
                                int.parse(createNewUser.reffController.text);
                            print('im a $gg');
                            List<Money> result = hiveBox.values
                                .where((value) => value.id == gg)
                                .toList();
                            if (result.isNotEmpty) {
                              // print(result[0].title);
                              // print(result[0].price);
                              // print(result[0].date);
                              // print(result[0].isReceived);
                              // print(result[0].countref);
                              // print(result[0].id);

                              createNewUser.user = result[0].title;
                              int index = 0;
                              MyApp.getData();
                              for (int i = 0; i < hiveBox.values.length; i++) {
                                if (hiveBox.values.elementAt(i).id == gg) {
                                  index = i;

                                  // createNewUser.newrfrl += 1;
                                  print(createNewUser.newrfrl);
                                  Money newreff = Money(
                                      isReceived: result[0].isReceived,
                                      countref: result[0].countref += 1,
                                      date: result[0].date,
                                      id: result[0].id,
                                      price: result[0].price,
                                      title: result[0].title,
                                      email: result[0].email,
                                      tell: result[0].tell,
                                      service: result[0].service);
                                  //  add new user & update old user refferal unit
                                  hiveBox.putAt(index, newreff);
                                  hiveBox.add(item);

                                  setState(() {
                                    // hiveBox.add(item);
                                  });
                                }
                              }

                              Get.defaultDialog(
                                title:
                                    userlvl.FaEn == 1 ? 'موفقیت' : 'Success!',
                                titleStyle: const TextStyle(
                                    fontFamily: 'BYekan',
                                    fontWeight: FontWeight.bold),
                                middleText: userlvl.FaEn == 1
                                    ? 'کاربر با کد رفرال کاربر \n${createNewUser.user}\n با موفقیت ثبت شد'
                                    : 'New user \n successfully added with \n ${createNewUser.user} invite code',
                                middleTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textConfirm: userlvl.FaEn == 1 ? 'حله' : 'Ok',
                                confirmTextColor: Colors.white,
                                buttonColor: kPurpleColor,
                                barrierDismissible: false,
                                onConfirm: () {
                                  createNewUser.reffController.clear();
                                  Get.back();
                                  Navigator.pop(context);
                                },
                              );
                            }
                            // error if refferal code cand be found at database
                            else {
                              print('Is Now ok!');
                              Get.defaultDialog(
                                title: 'خطا!',
                                titleStyle: const TextStyle(
                                    fontFamily: 'BYekan',
                                    fontWeight: FontWeight.bold),
                                middleText: 'کد رفرال وارد شده اشتباه است !',
                                middleTextStyle: const TextStyle(
                                    fontFamily: 'BYekan',
                                    fontWeight: FontWeight.bold),
                                confirmTextColor: Colors.white,
                                buttonColor: kPurpleColor,
                                textConfirm: 'فهمیدم',
                                barrierDismissible: false,
                                onConfirm: () {
                                  createNewUser.reffController.clear();
                                  Get.back();
                                },
                              );

                              //
                            }
                            //////
                          } else {
                            // add user with valid id & without refferal
                            hiveBox.add(item);
                            createNewUser.reffController.clear();
                            createNewUser.newrfrl = 0;
                            setState(() {});
                            Navigator.pop(context);
                          }
                        }
                      }
                    }
                  },
                  height: 50,
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
