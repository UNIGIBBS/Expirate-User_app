import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'graph_info.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.graphInformation,
    required this.maxValue,
  }) : super(key: key);

  final List<GraphInfo> graphInformation;
  final double maxValue;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SfCircularChart(
      palette: <Color>[Colors.greenAccent, Colors.redAccent, Colors.lightBlueAccent],
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        textStyle: TextStyle(fontWeight: FontWeight.w500),
      ),
      series: <CircularSeries> [
        RadialBarSeries<GraphInfo, String>(
          dataSource: graphInformation,
          xValueMapper: (GraphInfo data, _) => data.type,
          yValueMapper: (GraphInfo data, _) => data.amount,
          maximumValue: maxValue,
          radius: "${width/4}",
          cornerStyle: CornerStyle.bothCurve,
          gap: "15",
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                  fontWeight: FontWeight.w500
              )
          ),
        )
      ],
    );
  }
}
