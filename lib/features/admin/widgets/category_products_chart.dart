// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:unique_simple_bar_chart/data_models.dart';
import 'package:unique_simple_bar_chart/simple_bar_chart.dart';

import 'package:ShopSphere/features/admin/models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  List<Sales>? earnings;

  CategoryProductsChart({
    Key? key,
    required this.earnings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleBarChart(
          // fullBarChartHeight: 430,

          makeItDouble: true,
          listOfHorizontalBarData: earnings!
              .map(
                (e) => HorizontalDetailsModel(
                  name: e.label,
                  color: Colors.blue,
                  size: double.parse(((e.earning) % 14999).toString()),
                ),
              )
              .toList(),

          verticalInterval: 5000,
        ),
      ),
    );
  }
}
