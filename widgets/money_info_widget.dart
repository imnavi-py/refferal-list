import 'package:flutter/material.dart';
import '../screens/info_screen.dart';
import 'farsi_screen_widget.dart';

//! Money Info Widget
class MoneyInfoWidget extends StatefulWidget {
  final String firstText;
  // final String secondText;
  final String firstPrice;
  // final String secondPrice;

  const MoneyInfoWidget({
    Key? key,
    required this.firstText,
    // required this.secondText,
    required this.firstPrice,
    // required this.secondPrice,
  }) : super(key: key);

  @override
  State<MoneyInfoWidget> createState() => _MoneyInfoWidgetState();
}

class _MoneyInfoWidgetState extends State<MoneyInfoWidget> {
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
    return Padding(
      padding: const EdgeInsets.only(right: 2.0, top: 20.0, left: 35.0),
      child: farsiScreen(screenWidth: screenWidth, widget: widget),
    );
  }
}
