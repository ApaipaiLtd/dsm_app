import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:dsm_app/widgets/button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class NetworkChartData {
  int x;
  int upload;
  int download;
  NetworkChartData({this.x = 0, this.upload = 0, this.download = 0});
}

class _IndexState extends State<Index> {
  bool light = true;
  List<NetworkChartData> networkData = [];
  Random random = Random();
  @override
  void initState() {
    setState(() {
      networkData = List.generate(20, (index) {
        return NetworkChartData(x: index, upload: random.nextInt(2000), download: random.nextInt(2000));
      });
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateNetworkChart();
    });
    super.initState();
  }

  updateNetworkChart() {
    if (mounted) {
      setState(() {
        networkData
          ..removeAt(0)
          ..add(NetworkChartData(x: networkData.last.x + 1, upload: random.nextInt(2000), download: random.nextInt(2000)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black12,
      //http://pan.apaipai.top:5000/webapi/entry.cgi?api=SYNO.Core.PersonalSettings&method=wallpaper&version=1&path=%22%22&retina=true&id=3&SynoToken=ypyTfQY0Hld7I
      body: Stack(
        children: [
          ExtendedImage.network(
            "http://pan.apaipai.top:5000/webman/login_background.jpg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              color: light ? Colors.white54 : Colors.black26,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  AppBar(
                    titleSpacing: 0,
                    leadingWidth: 0,
                    // leading: Button(
                    //   onPressed: () {},
                    //   child: Icon(Icons.add),
                    // ),
                    // title: Text(
                    //   "控制台",
                    //   style: TextStyle(color: light ? Colors.black54 : Colors.white54),
                    // ),
                    title: Row(
                      children: [
                        Button(
                          fill: false,
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.change_circle_outlined,
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "admin",
                                strutStyle: StrutStyle(forceStrutHeight: true),
                              ),
                              Text(
                                "(家里的NAS)",
                                style: TextStyle(color: light ? Colors.black54 : Colors.white54),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                    actions: [
                      Button(
                        fill: false,
                        onPressed: () {},
                        child: Icon(
                          Icons.edit,
                          size: 16,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Button(
                        fill: false,
                        onPressed: () {},
                        child: Icon(
                          Icons.alarm,
                          size: 16,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                    backgroundColor: light ? Colors.white54 : Colors.black26,
                    automaticallyImplyLeading: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: light ? Colors.white54 : Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 100,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: light ? Color(0xff797a79) : Colors.white54,
                        //color: Color(0xff797a79),
                        fontSize: 12,
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/7/package_center.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "套件中心",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/7/control_panel.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "控制面板",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/7/synology_photos.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Photos",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/docker.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Docker",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/download_station.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Download",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: light ? Colors.white54 : Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "资源监控",
                              style: TextStyle(color: light ? Color(0xff797a79) : Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(
                              Icons.upgrade,
                              color: Colors.red,
                              size: 14,
                            ),
                            Text(
                              "${networkData.last.upload}",
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RotatedBox(
                              quarterTurns: 90,
                              child: Icon(
                                Icons.upgrade,
                                color: Colors.green,
                                size: 14,
                              ),
                            ),
                            Text(
                              "${networkData.last.download}",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            primaryXAxis: NumericAxis(majorGridLines: const MajorGridLines(width: 0), isVisible: false),
                            primaryYAxis: NumericAxis(axisLine: const AxisLine(width: 0), majorTickLines: const MajorTickLines(size: 0)),
                            series: <SplineSeries<NetworkChartData, num>>[
                              SplineSeries<NetworkChartData, num>(
                                dataSource: networkData,
                                xValueMapper: (NetworkChartData sales, _) => sales.x,
                                yValueMapper: (NetworkChartData sales, _) => sales.upload,
                                width: 2,
                                color: Colors.red,
                              ),
                              SplineSeries<NetworkChartData, num>(
                                dataSource: networkData,
                                width: 2,
                                xValueMapper: (NetworkChartData sales, _) => sales.x,
                                yValueMapper: (NetworkChartData sales, _) => sales.download,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: light ? Colors.white54 : Colors.black26,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CPU",
                                style: TextStyle(color: light ? Color(0xff797a79) : Colors.white54, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 50.0,
                                  animation: true,
                                  animationDuration: 1200,
                                  lineWidth: 15.0,
                                  percent: 0.4,
                                  center: Text(
                                    "40%",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xffEA4356)),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  backgroundColor: Color(0xffDEDEDE),
                                  progressColor: Color(0xffEA4356),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: light ? Colors.white54 : Colors.black26,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          margin: EdgeInsets.only(left: 10, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RAM",
                                style: TextStyle(color: light ? Color(0xff797a79) : Colors.white54, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 50.0,
                                  animation: true,
                                  animationDuration: 1200,
                                  lineWidth: 15.0,
                                  percent: 0.8,
                                  center: Text(
                                    "80%",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blue),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  backgroundColor: Color(0xffDEDEDE),
                                  progressColor: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: light ? Colors.white54 : Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.only(left: 20, right: 10),
                      child: Text("编辑"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: light ? Colors.white54 : Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 100,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: light ? Color(0xff797a79) : Colors.white54,
                        //color: Color(0xff797a79),
                        fontSize: 12,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/7/package_center.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "套件中心",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/7/control_panel.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "控制面板",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/7/synology_photos.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Photos",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/docker.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Docker",
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/applications/download_station.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Download",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
