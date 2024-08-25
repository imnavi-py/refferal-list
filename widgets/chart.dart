import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
// import 'package:apst/utils/calculate.dart';
import '../utils/calculate.dart';

// ignore: must_be_immutable
class BarChartWidget extends StatefulWidget {
  // static double monthnum = InfoScreen.monthnum;
  // static double daynum = InfoScreen.daynum;

  BarChartWidget({
    Key? key,
  }) : super(key: key);
  // static double daynum = 0; // مقدار ماکزیموم روزانه
  // static double monthnum = 0;
  var controller = Get.put(daymonth());
  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  // static double daynum = daynum; // مقدار ماکزیموم روزانه
  // static double monthnum = monthnum;
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              // children: [TextSpan(text: 'asdasda'),],

              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
      show: true,
      bottomTitles: const AxisTitles(
          drawBelowEverything: true, sideTitles: SideTitles(showTitles: true)),
      leftTitles: AxisTitles(
          drawBelowEverything: true,
          axisNameWidget:
              userlvl.FaEn == 1 ? const Text('سطح') : const Text('Level'),
          sideTitles: const SideTitles(showTitles: true, reservedSize: 50),
          axisNameSize: 20),
      rightTitles: const AxisTitles(axisNameSize: 60),
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        interval: 55,
        reservedSize: 55,
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return userlvl.FaEn == 1 ? const Text('ماکزیموم') : const Text('MAX');
        },
      ))
      //   bottomTitles: SideTitles(
      //   showTitles: true,
      //   getTextStyles: (context, value) => const TextStyle(
      //     color: Color(0xff7589a2),
      //     fontWeight: FontWeight.bold,
      //     fontSize: 14,
      //   ),
      //   margin: 20,
      //   showTitles: (double value) {
      //     switch (value.toInt()) {
      //       case 0:
      //         return 'فروش ماهیانه';
      //       case 1:
      //         return 'فروش روزانه';
      //       default:
      //         return '';
      //     }
      //   },
      // ),
      //   leftTitles: SideTitles(showTitles: false),
      //   topTitles: SideTitles(showTitles: false),
      //   rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                  borderSide: const BorderSide(),
                  fromY: 0,
                  color: Colors.blue.shade900,
                  toY: Calculate.dMonth(),
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 0,
                      toY: daymonth.nummonth,
                      color: Colors.red,
                      show: true)
                  // 500000000

                  // double.parse(InfoScreen.monthnum),
                  ),
            ],
            showingTooltipIndicators: [0],
            barsSpace: 2),

        // BarChartGroupData(
        //   x: 0,
        //   barRods: [
        //     BarChartRodData(
        //         borderSide: BorderSide(),
        //         fromY: 0,
        //         color: Colors.lightBlueAccent,
        //         toY: Calculate.dToday(),
        //         backDrawRodData: BackgroundBarChartRodData(
        //             fromY: 0,
        //             toY: daymonth.numday,
        //             color: Colors.red,
        //             show: true)
        //         // Calculate.dToday(),

        //         // double.parse(InfoScreen.daynum)
        //         ),
        //   ],
        //   showingTooltipIndicators: [0],
        // ),
      ];
}
