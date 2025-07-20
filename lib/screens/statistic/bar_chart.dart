import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
                    barGroups: List.generate(widget.period.length, (index) {
                      // Si la valeur existe pour cette période, on l'utilise, sinon 0
                      double value = index < widget.data.length ? widget.data[index] : 0;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: value, 
                            color: value > 0 ? Constants.darkBlueColor : Colors.transparent,
                            width: 16,
                          ),
                        ],
                      );
                    }),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < widget.period.length) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 4,
                                child: Text(
                                  widget.period[index],
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          interval: 1, // Affiche toutes les périodes
                          reservedSize: 40, // Espace réservé pour les labels
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
