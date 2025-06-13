// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:work_diary/core/utils/colors.dart';

// class LineChartSample2 extends StatefulWidget {
//   const LineChartSample2({super.key});

//   @override
//   State<LineChartSample2> createState() => _LineChartSample2State();
// }

// class _LineChartSample2State extends State<LineChartSample2> {
//   List<Color> gradientColors = [
//     const Color(0xFFFFFFFF),
//     const Color(0xFF7CA8FB),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.5,
//           child: DecoratedBox(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(8),
//               ),
//               color: bBlue,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 right: 10,
//                 left: 10,
//                 top: 10,
//                 bottom: 5,
//               ),
//               child: LineChart(
//                 mainData(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: bWhite,
//       fontSize: 12,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('Upcom', style: style);
//         break;
//       case 2:
//         text = const Text('Visit', style: style);
//         break;
//       case 4:
//         text = const Text('Emerg', style: style);
//         break;
//       case 6:
//         text = const Text('Atten', style: style);
//         break;
//       case 8:
//         text = const Text('Other', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: bWhite,
//       fontSize: 12,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 0:
//         text = '20%';
//         break;
//       case 2:
//         text = '40%';
//         break;
//       case 4:
//         text = '60%';
//         break;
//       case 6:
//         text = '80%';
//         break;
//       case 8:
//         text = '100%';
//         break;
//       default:
//         return Container();
//     }

//     return Text(text, style: style, textAlign: TextAlign.left);
//   }

//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: bWhite.withOpacity(0.3),
//             strokeWidth: 1,
//           );
//         },
//         // getDrawingVerticalLine: (value) {
//         //   return FlLine(
//         //     color: const Color(0xff37434d),
//         //     strokeWidth: 1,
//         //   );
//         // },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 40,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//         border: Border.all(color: Colors.amber),
//       ),
//       minX: 0,
//       maxX: 9,
//       minY: 0,
//       maxY: 9,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 3),
//             FlSpot(2.6, 2),
//             FlSpot(4.9, 5),
//             FlSpot(7, 4),
//             FlSpot(8, 4),
//             FlSpot(9, 5),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: gradientColors,
//           ),
//           barWidth: 1,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: true,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.1))
//                   .toList(),
//             ),
//           ),
//         ),
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 1.5),
//             FlSpot(2.6, 2),
//             FlSpot(4.9, 3),
//             FlSpot(6.8, 3.1),
//             FlSpot(9, 8),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: gradientColors,
//           ),
//           barWidth: 3,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.05))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
