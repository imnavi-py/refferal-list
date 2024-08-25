import 'package:flutter/material.dart';

import '../constant.dart';

//! MyButton
class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  const MyButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.width,
      required this.height})
      : super(key: key);

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
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
