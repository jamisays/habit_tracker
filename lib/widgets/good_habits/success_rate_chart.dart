import 'package:flutter/material.dart';
import 'package:habit_tracker/models/bad_habits/charts/done_times.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SuccessRateChart extends StatelessWidget {
  const SuccessRateChart({
    Key? key,
    required List<DoneTimes>? chartData,
    int? maxTimesDay,
  })  : _chartData = chartData,
        _maxTimesDay = maxTimesDay,
        super(key: key);

  final List<DoneTimes>? _chartData;
  final int? _maxTimesDay;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Success Rate'),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        opacity: .7,
        tooltipPosition: TooltipPosition.pointer,
        elevation: 10,
        header: 'Times Done',
        format: 'point.y Times',
      ),
      series: [
        ColumnSeries<DoneTimes, String>(
          dataSource: _chartData!,
          xValueMapper: (DoneTimes chart, _) =>
              DateFormat.E('en_US').format(chart.date).toString(),
          yValueMapper: (DoneTimes chart, _) => chart.doneTimes,
          borderRadius: BorderRadius.circular(6),
          sortingOrder: SortingOrder.descending,
          // isTrackVisible: true,
          // trackColor: Colors.grey.shade400,
          // trackPadding: 1,
          width: .4,
          enableTooltip: true,
        ),
      ],
      primaryXAxis: CategoryAxis(
        isInversed: true,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        interval: (double.parse(_maxTimesDay!.toString()) / 3).floorToDouble(),
        minimum: 0,
        maximum: double.parse(_maxTimesDay!.toString()),
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
      ),
    );
  }
}
