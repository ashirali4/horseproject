/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, this.animate);

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return SimpleBarChart(
      _createSampleData(),
      false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<WeightList, String>> _createSampleData() {
    final data = [
      new WeightList('2014', 5),
      new WeightList('2015', 25),
      new WeightList('2016', 100),
      new WeightList('2017', 75),
    ];

    return [
      new charts.Series<WeightList, String>(
        id: 'Weights',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WeightList sales, _) => sales.date,
        measureFn: (WeightList sales, _) => sales.weights,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class WeightList {
  final String date;
  final int weights;
  WeightList(this.date, this.weights);
}