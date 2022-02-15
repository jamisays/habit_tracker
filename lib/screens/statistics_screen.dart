import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chartData.dart';

class StatisticsScreen extends StatefulWidget {
  // const StatisticsScreen({ Key? key }) : super(key: key);
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<ChartData>? _chartData;
  TooltipBehavior? _toolTipBehavior;

  @override
  void initState() {
    // setState(() {
    //   openEventBox();
    // });
    _chartData = generateChartData();
    _toolTipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // _chartData = generateChartData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        child: SfCartesianChart(
          title: ChartTitle(text: 'Success Rate'),
          // legend: Legend(isVisible: true),
          tooltipBehavior: _toolTipBehavior,
          series: [
            ColumnSeries<ChartData, String>(
              dataSource: _chartData!,
              xValueMapper: (ChartData chart, _) =>
                  chart.date.toString().substring(8, 10),
              yValueMapper: (ChartData chart, _) => chart.successRate,
              borderRadius: BorderRadius.circular(10),
              sortingOrder: SortingOrder.descending,
              name: 'Success Rate',
            ),
            // ColumnSeries<GoodHabit, num>(
            //   dataSource: _habitData,
            //   xValueMapper: (GoodHabit habits, _) => habits.tempSpirit,
            //   yValueMapper: (GoodHabit habits, _) => habits.timesDay,
            // ),
          ],
          primaryXAxis: CategoryAxis(
            isInversed: true,
          ),
          primaryYAxis: CategoryAxis(
            minimum: 0,
            maximum: 100,
            interval: 25,
          ),
        ),
      ),
    );
  }
}
