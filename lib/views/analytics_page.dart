// ignore_for_file: prefer_const_constructors

import 'package:dreamnote/db/database_provider.dart';
import 'package:dreamnote/model/dream_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AnalyticsPage extends StatefulWidget {
  final bool DarkTheme;
  const AnalyticsPage({ Key? key, required this.DarkTheme }) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
   List dreams =[];
  bool isLoading = false;
  Map<String, double> dataMap ={};

  @override
  void initState() {
    super.initState();
    refreshGraph();
    
  }

  @override
  void dispose() {
    DatabaseProvider.db.close();
    super.dispose();
  }

  Future refreshGraph() async {
    setState(() => isLoading = true);
    dreams = await DatabaseProvider.db.readAllCategories();
    dataMap=  {
    "friends": dreams[0],
    "love":dreams[1],
    "nightmare": dreams[2],
    "lucid": dreams[3],
    "family": dreams[4],
    "animals": dreams[5],
    "food": dreams[6],
    "random": dreams[7],
  };
    setState(() => isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    
   final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
      Colors.green,
      Colors.blue,
      Colors.red
  ];
    return isLoading?
    Center(child: CircularProgressIndicator())
    :
    Center(
      child: PieChart(
    dataMap: dataMap,
    animationDuration: Duration(milliseconds: 800),
    chartLegendSpacing: 32,
    chartRadius: MediaQuery.of(context).size.width / 3.2,
    colorList: colorList,
    initialAngleInDegree: 0,
    chartType: ChartType.ring,
    ringStrokeWidth: 32,
    centerText: "DREAMS",
    legendOptions: LegendOptions(
      showLegendsInRow: false,
      legendPosition: LegendPosition.right,
      showLegends: true,
      legendShape: BoxShape.circle,
      legendTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: widget.DarkTheme? Colors.black : Colors.white,
      ),
    ),
    chartValuesOptions: ChartValuesOptions(
      showChartValueBackground: true,
      showChartValues: true,
      showChartValuesInPercentage: false,
      showChartValuesOutside: false,
      decimalPlaces: 0,
    ),
    // gradientList: ---To add gradient colors---
    // emptyColorGradient: ---Empty Color gradient---
    ),
    );
  }
}