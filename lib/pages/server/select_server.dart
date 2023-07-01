import 'dart:ui';

import 'package:dsm_app/database/tables.dart';
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
        // shadowColor: Colors.transparent,
        // surfaceTintColor: Colors.blue,
        elevation: 0,
        // scrolledUnderElevation: 100,
        notificationPredicate: (_) {
          return false;
        },
        flexibleSpace: ClipRRect(
          child: Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.5), // 设置模糊背景的颜色和透明度
              ),
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
                    child: Row(
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
                              onPressed: () {
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
                  ),
                ),
              ),
            ],
          ),
          if (accounts.isNotEmpty) ...[
            SizedBox(
              height: 20,
            ),
          ],
        ],
      ),
    );
  }
}
