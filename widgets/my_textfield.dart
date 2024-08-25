import 'package:flutter/material.dart';

import '../constant.dart';

//! My TextField
class MyTextField extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;
  final bool enablefield;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.enablefield = true,
    this.type = TextInputType.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enablefield,
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.black38,
      decoration: InputDecoration(
        hoverColor: Colors.amber,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.all(15),

        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPurpleColor),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kPurpleColor),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        floatingLabelStyle: const TextStyle(fontFamily: 'Irs'),
        // labelStyle: ,
        floatingLabelAlignment: FloatingLabelAlignment.center,
      ),

      // InputDecoration(
      //   border: UnderlineInputBorder(
      //     borderSide: BorderSide(color: Colors.grey.shade300),
      //   ),
      //   enabledBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(color: Colors.grey.shade300),
      //   ),
      //   focusedBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(color: Colors.grey.shade300),
      //   ),
      //   hintText: hintText,
      //   hintStyle: const TextStyle(fontSize: 14),
      // ),
    );
  }
}
