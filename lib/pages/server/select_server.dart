import 'dart:math';
import 'dart:ui';

import 'package:dsm_app/apis/api.dart';
import 'package:dsm_app/apis/dsm_api/dsm_api.dart';
import 'package:dsm_app/database/table_extention.dart';
import 'package:dsm_app/database/tables.dart';
import 'package:dsm_app/models/api_model.dart';
import 'package:dsm_app/pages/index/index.dart';
import 'package:dsm_app/pages/login/login.dart';
import 'package:dsm_app/pages/server/add_server.dart';
import 'package:dsm_app/utils/db_utils.dart';
import 'package:dsm_app/utils/extensions/media_query_ext.dart';
import 'package:dsm_app/utils/extensions/navigator_ext.dart';
import 'package:dsm_app/widgets/button.dart';
import 'package:dsm_app/widgets/custom_dialog/custom_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SelectServer extends StatefulWidget {
  const SelectServer({super.key});

  @override
  State<SelectServer> createState() => _SelectServerState();
}

class _SelectServerState extends State<SelectServer> {
  List<Server> servers = [];
  List<Account> accounts = [];
  bool hide = false;
  @override
  void initState() {
    queryServers();
    super.initState();
  }

  queryServers() async {
    // servers = await DbUtils.db.select(DbUtils.db.servers).get();
    DbUtils.db.select(DbUtils.db.servers).watch().listen((event) {
      setState(() {
        servers = event;
      });
    });
    accounts = await DbUtils.db.select(DbUtils.db.accounts).get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        notificationPredicate: (_) {
          return false;
        },
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.5), // 设置模糊背景的颜色和透明度
            ),
          ),
        ),
        title: Text("选择服务器/账号"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                hide = !hide;
              });
            },
            icon: Icon(Icons.remove_red_eye),
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(20, context.padding.top + 70, 20, 20),
        itemBuilder: (context, i) {
          return _buildServerItem(servers[i]);
        },
        separatorBuilder: (context, i) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: servers.length,
      ),
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Button(
            icon: Icon(Icons.add),
            onPressed: () {
              context.push(AddServer());
            },
            child: Text("添加新服务器"),
          ),
        )
      ],
    );
  }

  Widget _buildServerItem(Server server) {
    double width = context.width - 40;
    double height = (context.width - 40) / 16 * 9;
    List<Account> serverAccounts = accounts.where((account) => account.serverId == server.id).toList();
    return Container(
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(0, 2), blurRadius: 10, spreadRadius: -2),
          // BoxShadow(color: Colors.black.withOpacity(0.12), offset: Offset(0, 1), blurRadius: 10),
          // BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(0, 3), blurRadius: 2, spreadRadius: -2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ExtendedImage.network(
                server.backgroundImage!,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: width,
                    height: height,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (server.hostname != null) ...[
                                    Text(
                                      server.hostname!,
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                  Row(
                                    children: [
                                      Icon(
                                        server.ssl ? Icons.lock_outline : Icons.lock_open,
                                        color: server.ssl ? Colors.green : Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        hide
                                            ? '**********'
                                            : server.qcid.isNotEmpty
                                                ? server.qcid
                                                : "${server.domain}:${server.port}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.push(AddServer(
                                      server: server,
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Api.dsm = DsmApi(baseUrl: server.url);
                                    ApiModel.apiInfo = await ApiModel.info();
                                    context.push(Login(server));
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showCustomDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("提示"),
                                          content: Text("确定删除此服务器？"),
                                          actionsOverflowDirection: VerticalDirection.up,
                                          actions: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Button(
                                                    color: Colors.red,
                                                    child: Text("删除"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Button(
                                                    child: Text("取消"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.circular(100.0),
                                      border: Border.all(width: 4, color: Color(0xFF2633C5).withOpacity(0.2)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomPaint(
                                    painter: CurvePainter(
                                      colors: [
                                        Color(0xFF8A98E8),
                                        Color(0xFF8A98E8),
                                        Color(0xFF2633C5),
                                      ],
                                      angle: 300,
                                    ),
                                    child: SizedBox(
                                      width: 108,
                                      height: 108,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '50%',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 24,
                                              letterSpacing: 0.0,
                                              color: Color(0xFF2633C5),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'CPU',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF8A98E8),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ...serverAccounts.map((account) => _buildAccountItem(account, server)).toList(),
        ],
      ),
    );
  }

  Widget _buildAccountItem(Account account, Server server) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        Api.dsm = DsmApi(baseUrl: server.url);
        ApiModel.apiInfo = await ApiModel.info();
        context.push(Index());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(account.account),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shadowPaintCenter = Offset(size.width / 2, size.height / 2);
    final shadowPaintRadius = min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.3);
    shadowPaint.strokeWidth = 16;
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.2);
    shadowPaint.strokeWidth = 20;
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.1);
    shadowPaint.strokeWidth = 22;
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = SweepGradient(
      startAngle: degreeToRadius(268),
      endAngle: degreeToRadius(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, paint);

    const gradient1 = SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = Paint();
    cPaint
      ..shader = gradient1.createShader(rect)
      ..color = Colors.white
      ..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadius(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(const Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadius(double degree) {
    var radius = (pi / 180) * degree;
    return radius;
  }
}
