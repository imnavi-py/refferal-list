import 'package:flutter/material.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
import 'package:moaarefyar/widgets/my_radio_button.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../screens/new_user_screen.dart';

//! Type And Date Widget
class TypeAndDateWidget extends StatefulWidget {
  const TypeAndDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TypeAndDateWidget> createState() => _TypeAndDateWidgetState();
}

class _TypeAndDateWidgetState extends State<TypeAndDateWidget> {
  double screenWidth = 0;

  double screenHeight = 0;

//baraye yekbar farakhuni shodan
  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  String record = userlvl.FaEn == 1 ? 'ثبت شود' : 'Record';
  String dontRecord = userlvl.FaEn == 1 ? 'ثبت نشود' : "Don't Record";
  String history = userlvl.FaEn == 1 ? 'تاریخ' : 'Date';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: 10),
        SizedBox(
          height: 50,
          width: screenWidth * .5,
          child: OutlinedButton(
            onPressed: () async {
              var pickedDate = await showPersianDatePicker(
                context: context,
                initialDate: Jalali.now(),
                firstDate: Jalali(1400),
                lastDate: Jalali(1499),
              );
              if (pickedDate != null) {
                // اضافه کردن این شرط برای بررسی null بودن
                setState(() {
                  String year = pickedDate.year.toString();

                  //
                  String month = pickedDate.month.toString().length == 1
                      ? '0${pickedDate.month.toString()}'
                      : pickedDate.month.toString();

                  //
                  String day = pickedDate.day.toString().length == 1
                      ? '0${pickedDate.day.toString()}'
                      : pickedDate.day.toString();

                  //
                  createNewUser.date = '$year/$month/$day';
                  userlvl.FaEn == 1 ? year.toPersianDigit() : year;
                  userlvl.FaEn == 1 ? month.toPersianDigit() : month;
                  userlvl.FaEn == 1 ? day.toPersianDigit() : day;
                });

                history = createNewUser.date;
              }

              history = userlvl.FaEn == 1
                  ? createNewUser.date.toPersianDigit()
                  : createNewUser.date;
              // history != 'تاریخ' ? history.toPersianDate() : null;
            },
            child: Text(
              // NewTransActionsScreen.date,
              // userlvl.FaEn == 1 ? 'تاریخ' : 'Date',
              history,
              style: TextStyle(
                fontSize: 14,
                color: userlvl.chkAdd_ubjct == 0 ? Colors.black : Colors.red,
              ),
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: MyRadioButton(
              value: 1,
              groupValue: createNewUser.groupId,
              onChanged: (value) {
                setState(() {
                  createNewUser.groupId = value!;
                });
              },
              text: record,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MyRadioButton(
              value: 2,
              groupValue: createNewUser.groupId,
              onChanged: (value) {
                setState(() {
                  createNewUser.groupId = value!;
                });
              },
              text: dontRecord,
            ),
          ),
        ])
      ],
    );
  }
}
