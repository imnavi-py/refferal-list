import 'package:flutter/material.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';

import 'money_info_widget.dart';

class farsiScreen extends StatelessWidget {
  const farsiScreen({
    super.key,
    required this.screenWidth,
    required this.widget,
  });

  final double screenWidth;
  final MoneyInfoWidget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            flex: 1,
            child: userlvl.TomanDollar == 1
                ? const Text(
                    textAlign: TextAlign.right,
                    'تومان',
                    style: TextStyle(
                      fontFamily: 'BYekan',
                      fontSize: 16,
                    ),
                  )
                : const Text(
                    textAlign: TextAlign.right,
                    '\$',
                    style: TextStyle(fontSize: 16, fontFamily: 'BYekan'),
                  )),
        SizedBox(
          width: screenWidth * 0.01,
        ),
        Expanded(
          flex: 3,
          child: Text(
            widget.firstPrice,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16, fontFamily: 'BYekan'),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Expanded(
          flex: 3,
          child: Text(
            textAlign: TextAlign.center,
            widget.firstText,
            style: const TextStyle(fontSize: 16, fontFamily: 'BYekan'),
          ),
        ),
      ],
    );
  }
}
