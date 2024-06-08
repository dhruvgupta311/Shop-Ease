import 'package:ShopSphere/common/widgets/loader.dart';
import 'package:ShopSphere/features/admin/models/sales.dart';
import 'package:ShopSphere/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../widgets/category_products_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              SizedBox(
                height: 22,
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black38,
                        width: 2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey.shade100),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '\$$totalSales',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(earnings: earnings),
              )
            ],
          );
  }
}
