import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/features/app/domain/entities/chart_response.dart';

class BarChartB extends StatefulWidget {
  const BarChartB(
      {super.key, required this.chart, this.theme = ChartTheme.blue});
  final ChartResponse chart;
  final ChartTheme theme;

  @override
  State<BarChartB> createState() => _BarChartBState();
}

class _BarChartBState extends State<BarChartB> {
  late List<ChartData> data = [];
  late TooltipBehavior _tooltip;
  Color fontColor = const Color(0XFFC9DCFF);
  Color bgColor = bBlue;
  Color axisColor = const Color(0XFF5076ED);

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    if (widget.theme == ChartTheme.white) {
      bgColor = bWhite;
      fontColor = const Color(0XFF909090);
      axisColor = const Color(0XFFF2F2F2);
    }
    data.clear();
    for (int i = 0; i < widget.chart.charts!.data!.length; i++) {
      data.add(ChartData(
          widget.chart.charts!.data![i].week!,
          widget.chart.charts!.data![i].total!.toDouble(),
          widget.chart.charts!.data![i].completed!.toDouble()));
    }
    super.initState();
  }

  BorderRadius radius = const BorderRadius.only(
    topRight: Radius.circular(10),
    topLeft: Radius.circular(10),
  );
  LinearGradient totalBarBg = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0XFF44D1EE), Color(0XFF50C3FE)],
  );
  LinearGradient completeBarBg = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0XFFD1E1FE), Color(0XFF93B8FF)],
  );

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderColor: Colors.transparent,
      primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(color: fontColor),
          majorGridLines:
              const MajorGridLines(color: Colors.transparent, width: 1),
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          axisLine: AxisLine(width: 2, color: axisColor)),

      primaryYAxis: NumericAxis(
          labelStyle: TextStyle(color: fontColor),
          minimum: 0,
          maximum: widget.chart.charts!.maxvalue!.toDouble() +
              widget.chart.charts!.interval!.toDouble() / 2,
          interval: widget.chart.charts!.interval!.toDouble(),
          majorGridLines: MajorGridLines(color: axisColor, width: 1),
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          axisLine: AxisLine(width: 2, color: axisColor)),
      tooltipBehavior: _tooltip,
      legend: Legend(
        iconWidth: 7,
        iconHeight: 7,
        padding: 3,
        isVisible: true,
        position: LegendPosition.top,
        textStyle: TextStyle(color: fontColor),
      ),
      // enableSideBySideSeriesPlacement: false,
      // series: <ChartSeries<ChartData, String>>[
      //   ColumnSeries<ChartData, String>(
      //     width: 0.5,
      //     borderRadius: radius,
      //     dataSource: data,
      //     xValueMapper: (ChartData data, _) => data.x,
      //     yValueMapper: (ChartData data, _) => data.y,
      //     name: widget.chart.charts!.label!.total,
      //     gradient: totalBarBg,
      //   ),
      //   ColumnSeries<ChartData, String>(
      //     width: 0.5,
      //     borderRadius: radius,
      //     dataSource: data,
      //     xValueMapper: (ChartData data, _) => data.x,
      //     yValueMapper: (ChartData data, _) => data.y1,
      //     name: widget.chart.charts!.label!.completed,
      //     gradient: completeBarBg,
      //   ),
      // ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);

  final String x;
  final double y;
  final double y1;
}

enum ChartTheme { white, blue }
