import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spent_mananagement_mobile/constants/constant.dart';

class BarChartSample extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<double> data;
  final List<String> period;

  const BarChartSample({super.key, required this.title, required this.isLoading, required this.data, required this.period});
  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading, // Utilisez la propriété isLoading pour contrôler l'affichage
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(color: Colors.black, fontSize: 16)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 38),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 90000,
                    barGroups: widget.data.map((d) {
                      int index = widget.data.indexOf(d);
                      double value = d;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(toY: value, color: Constants.darkBlueColor, width: 16),
                        ],
                      );
                    }).toList(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            var style = const TextStyle(fontSize: 10);
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(widget.period[value.toInt() % 12], style: style),
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ), 
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ); 
  }
}
