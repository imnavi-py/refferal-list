import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

// ignore: camel_case_types
class toggleSwitch extends StatelessWidget {
  const toggleSwitch(
      {Key? key,
      required this.insideToggle,
      required this.initialLabelIndex,
      required this.toggleindex})
      : super(key: key);
  final List<String> insideToggle;
  final int initialLabelIndex;
  final Function(int) toggleindex;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 90.0,
      cornerRadius: 15.0,
      customWidths: const [60, 59],
      activeBgColors: [
        [Colors.blue.shade900],
        [Colors.blue.shade900]
      ],
      activeFgColor: Colors.white,
      // inactiveBgColor: Colors.grey,
      inactiveBgColor: Colors.white70,
      inactiveFgColor: const Color.fromARGB(255, 29, 1, 1),
      initialLabelIndex: initialLabelIndex,
      totalSwitches: 2,
      labels: insideToggle,
      radiusStyle: true,
      onToggle: (index) {
        toggleindex(index!);
      },
      // (index) {
      //   userlvl.TomanDollar = index!;
      //   print('switched to: $index');
      //   print('this is FaEn : ${userlvl.TomanDollar}');
      // },
    );
  }
}
