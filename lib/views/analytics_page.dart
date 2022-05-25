// ignore_for_file: prefer_const_constructors

import 'package:dreamnote/db/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pie_chart/pie_chart.dart';

import '../ad_helper.dart';

class AnalyticsPage extends StatefulWidget {
  final bool DarkTheme;
  const AnalyticsPage({Key? key, required this.DarkTheme}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  List dreams = [];
  bool isLoading = false;
  Map<String, double> dataMap = {};

  @override
  void initState() {
    super.initState();
    refreshGraph();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    DatabaseProvider.db.close();
    _bannerAd.dispose();
    super.dispose();
  }

  Future refreshGraph() async {
    setState(() => isLoading = true);
    dreams = await DatabaseProvider.db.readAllCategories();
    dataMap = {
      "friends": dreams[0],
      "love": dreams[1],
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
      Color(0xff94B0DA),
      Color(0xffF0BCD4),
      Color(0xffE05263),
      Color(0xffD9DCD6),
      Color(0xffBBADFF),
      Color(0xff899878),
      Color(0xffECBA82),
      Color(0xffB7B6C1),
    ];
    return Column(
      children: [
        isLoading
            ? Center(child: CircularProgressIndicator())
            : Expanded(
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 1500),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 2.8,
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
                      color: widget.DarkTheme ? Colors.black : Colors.white,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: true,
                    decimalPlaces: 0,
                  ),
                ),
              ),
        if (_isBannerAdReady)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              width: MediaQuery.of(context).size.width,
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ),
      ],
    );
  }
}
