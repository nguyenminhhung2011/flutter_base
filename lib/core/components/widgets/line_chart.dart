import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';

class LineChartCustom extends StatelessWidget {
  final double maxData;
  final DateTime timeStart;
  final DateTime timeEnd;
  final List<double> data;
  final double limitData;
  const LineChartCustom({
    super.key,
    required this.isShowingMainData,
    required this.maxData,
    required this.timeStart,
    required this.timeEnd,
    required this.data,
    required this.limitData,
  });

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 10.0),
      child: LineChart(sampleData2),
    );
  }

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: data.length.toDouble() - 1,
        maxY: 2,
        minY: 0,
      );

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: true,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '${(maxData / 2).round()}m';
        break;
      case 2:
        text = '${maxData}m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat',
      fontSize: 12,
    );
    Widget text;
    int index = value.toInt();
    if (index == 0) {
      text = Text(getYmdFormat(timeStart), style: style);
    } else if (index == data.length - 1) {
      text = Text(getYmdFormat(timeEnd), style: style);
    } else {
      text = const SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: false,
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey[600]!),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: '#07AEAF'.toColor().withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        curveSmoothness: 0,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              '#07AEAF'.toColor().withOpacity(0.5),
              '#07AEAF'.toColor().withOpacity(0.2),
            ],
          ),
        ),
        spots: [
          ...data.mapIndexed(
            (index, e) => FlSpot(index.toDouble(), (e * 2) / maxData),
          )
        ],
      );

  LineChartBarData get lineChartBarData2_3 {
    final limit = (limitData * 2) / maxData;
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      color: Colors.red,
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: [
        FlSpot(0, limit),
        FlSpot(data.length.toDouble(), limit),
      ],
    );
  }
}
