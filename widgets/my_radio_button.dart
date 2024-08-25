import 'package:flutter/material.dart';

import '../constant.dart';

//! My Radio Button
class MyRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String text;

  const MyRadioButton(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Radio(
            activeColor: kPurpleColor,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
