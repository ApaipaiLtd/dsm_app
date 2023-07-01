import 'dart:convert';
import 'dart:ui';

import 'package:drift/drift.dart' as drift;
import 'package:dsm_app/apis/api.dart';
import 'package:dsm_app/apis/dsm_api/dsm_resopnse.dart';
import 'package:dsm_app/database/table_extention.dart';
import 'package:dsm_app/database/tables.dart';
import 'package:dsm_app/models/SYNO/API/auth_model.dart';
import 'package:dsm_app/models/SYNO/SDS/Session/session_data_model.dart';
import 'package:dsm_app/pages/dashboard/dashboard.dart';
import 'package:dsm_app/pages/server/select_server.dart';
import 'package:dsm_app/utils/db_utils.dart';
import 'package:dsm_app/utils/extensions/datetime_ext.dart';
import 'package:dsm_app/utils/extensions/media_query_ext.dart';
import 'package:dsm_app/utils/extensions/navigator_ext.dart';
import 'package:dsm_app/utils/util.dart';
import 'package:dsm_app/widgets/button.dart';
import 'package:dsm_app/widgets/custom_dialog/custom_dialog.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login(this.server, {super.key});
  final Server server;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpCodeController = TextEditingController();
  String account = '';
  String password = '';
  String otpCode = '';
  bool rememberDevice = true;
  bool loading = false;
  bool showPassword = false;
  bool isDefault = false;

  SessionDataModel? sessionDataModel;

  @override
  void initState() {
    getSessionData();
    super.initState();
  }

  getSessionData() async {
    var res = await Api.dsm.get("/webapi/query.cgi", parameters: {
      "api": "SYNO.Core.Desktop.SessionData",
      "version": 1,
      "method": "getjs",
      "SynoToken": "",
    });
    final regex = RegExp(r'SYNO\.SDS\.Session\s*=\s*([\s\S]*?);');

    try {
      final match = regex.firstMatch(res);
      final sessionDataString = match?.group(1);
      setState(() {
        sessionDataModel = SessionDataModel.fromJson(jsonDecode(sessionDataString!));
      });
      // 将hostname和backgroundImage存入Servers
      DbUtils.db.updateServer(widget.server.copyWith(
          backgroundImage: drift.Value("${widget.server.url}/${(sessionDataModel?.loginBackgroundEnable ?? false) ? "webman/login_background${sessionDataModel?.loginBackgroundExt}" : "webman/resources/images/2x/default_login_background/dsm7_01.jpg?v=1685410415"}"),
          hostname: drift.Value(sessionDataModel?.hostname)));
    } catch (e) {}
  }

  login() async {
    //测试加密解密
    // final key = encrypt.Key.fromUtf8(
    //     "D6D3A66F381A8DE82F7CD0801EF4AD6D1D641FAAAD09C5040B53613F68261E59E1C3C87063A07F11EC95A649987A69167D3D6A48F8D7E9E4756783C0B8ABB9EBCEF8FDE0DCF9B063E7D6FE86F012D41630EE7B0F80B7D5239DAD0797F514BC285F28CE47CCB477760AE90B2C7738F8EE17F540A0B6D161B4ED5CD0A015D057652F44D154AE81A8920A51215908F3C803A04D371A88E9C62B7D4629D3EB33E29282F52FE206F4C28EDDB85A1015009B415C7299340044271FA85526C1CFF84369B9DA642AA3C0DCD23A63DFC0502F724D25A9506F8C989FD88FDE7600C83C0C7D0EC145D024AAFB8B9381F80893B2211365233D2658D3B406A47EFEEF1818FDE313F7CBE30C3333130A46DBD377EECA6E0593D3A9FDC1F4D14A4DFADBDAF14A3F0FA5E1D5789E6D30C0EDAE90EE3D94CA892BD52312B742A55026A54F3825D060FBE32372010F17FB1E42E7809930BBE8E0C43E4F1611D9AB32021DD4F0AFEB0721D374BE9FB623AB253EBB92DF5990CC8D909614F7B2BD01A03DB5E7B534586C4AE5AA2806B14E0F4749593FCB6C7AEC3BCFEA78DD32687342CE13DB3835E5F78EB36572E4F3269079F529483C4D43EA209BF2124ACB5477112F46BBE26C572564B6EFDC524BC3678F826FDEB9494EB99F8168B0A4D77D454E635BF194688E0BA3FD2A32BFDC53BDFC497CC0F40331FE1A9F86EC4658BD979DE6619ECD77616B");
    // final encrypter = encrypt.Encrypter(encrypt.AES(key));
    // String aes = "U2FsdGVkX19Crg9a07oLjZZa6uRU42MO4zEvQIOQmbTGi3g68AKGKFHvbfsqElyvZh2srQzLRVW5+xuasO1R097XKYVCxSHKlbmANo8WWKm73q/gAgdFS0r+XpqyPZaanQSmZgwVTvrgRw1rxzPJMkAmWI0tRa5P5scwn8oionDIsN23wvQ2lpKVV0hUOMpCAbC364+BlHmke2xHqiIZYA==";
    // String rsa = "";
    // encrypt.Encrypted encrypted = encrypt.Encrypted.fromUtf8(aes);
    // final decrypted = encrypter.decrypt(encrypted, iv: encrypt.IV.fromUtf8("__cIpHeRtOkEn"));
    // print(decrypted);
    // return;
    setState(() {
      loading = true;
    });
    try {
      Map<String, dynamic> data = {
        "account": account,
        "passwd": password,
        "logintype": 'local',
        "otp_code": otpCode,
        "session": "webui",
        "tabid": 54053,
        "enable_device_token": rememberDevice ? "yes" : "no",
        "enable_sync_token": "yes",
        // "ik_message": "LC6e3eUUEscf8ghrnxr1jadv37rCdAcur9LcgRUtGEXhqdd98sADwZMZtEmeTeACKbS5d-RkzpkezlSX3rBVk1KftOfsmt7Ap1t1oWpIevL47Vg9vX-37hCUHvQo2nNI",
      };
      DsmResponse res = await Api.dsm.entry<AuthModel>("SYNO.API.Auth", "login", post: true, data: data, parser: (json) {
        return AuthModel.fromJson(json);
      });
      if (res.success ?? false) {
        AuthModel authModel = res.data;
        Account acc = await DbUtils.db.into(DbUtils.db.accounts).insertReturning(
              AccountsCompanion.insert(
                account: account,
                serverId: widget.server.id,
                password: password,
                remark: "",
                createTime: DateTime.now().secondsSinceEpoch,
                lastLoginTime: DateTime.now().secondsSinceEpoch,
                isDefault: isDefault,
                deviceId: authModel.deviceId!,
                ikMessage: authModel.ikMessage!,
                sid: authModel.sid!,
                synoToken: authModel.synotoken!,
              ),
            );
        context.push(Dashboard(), replace: true);
      } else if (res.error?['code'] == 400) {
        Util.showToast("用户名/密码有误");
      } else if (res.error?['code'] == 403) {
        showOptCodeDialog("xx");
      } else if (res.error?['code'] == 404) {
        showOptCodeDialog("xx");
        Util.showToast("错误的验证代码。请再试一次。");
      } else if (res.error?['code'] == 414) {
        // 需要二次验证
        showOptCodeDialog("为确认这是您本人登录，系统已将验证码发送到${res.error?['errors']['email']}，请查看您的邮箱，并在5分钟内输入验证码");
      }
      // var res = await Api.dsm.post('/webapi/entry.cgi', parameters: {"api": "SYNO.API.Auth"}, data: data);
      // print(res);
      // var shares = await Api.dsm.post('/webapi/entry.cgi', data: {"api": "SYNO.Core.Desktop.Initdata", "version": 1, "method": "get"});
      // print(shares);
      // context.push(Index());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  showOptCodeDialog(String message) {
    otpCode = '';
    _otpCodeController.clear();
    showCustomDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("验证您的身份"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (v) => setState(() {
                    otpCode = v;
                  }),
                  controller: _otpCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "输入验证码",
                    // suffixIconColor: Colors.red,
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Button(
                      child: Text("取消"),
                      onPressed: () {
                        context.pop();
                      },
                      fill: false,
                      borderColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Button(
                      child: Text("登录"),
                      onPressed: () {
                        login();
                        context.pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
    // showCustomDialog(context: context, builder: (context){
    //   return AlertDialog(
    //     title: Text("验证您的身份"),
    //     content: Text("$message"),
    //     actions: [
    //
    //     ],
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              height: context.height,
            ),
            ExtendedImage.network(
              "${widget.server.url}/${(sessionDataModel?.loginBackgroundEnable ?? false) ? "webman/login_background${sessionDataModel?.loginBackgroundExt}" : "webman/resources/images/2x/default_login_background/dsm7_01.jpg?v=1685410415"}",
              cache: false,
              height: context.width / 16 * 9,
              width: context.width,
              fit: BoxFit.cover,
            ),
            if ((sessionDataModel?.loginLogoEnable ?? false) && (sessionDataModel?.loginLogoExt != null))
              Positioned(
                left: 20,
                top: context.padding.top - 10,
                child: ExtendedImage.network(
                  "${widget.server.url}/webman/login_logo${sessionDataModel?.loginLogoExt}",
                  cache: false,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            if (sessionDataModel?.loginWelcomeTitle != null || sessionDataModel?.loginFooterMsg != null && sessionDataModel?.loginFooterEnableHtml == false)
              Positioned(
                  left: 20,
                  top: context.width / 16 * 9 / 2 - 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (sessionDataModel?.loginWelcomeTitle != null)
                        Text(
                          "${sessionDataModel?.loginWelcomeTitle}",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                        ),
                      if (sessionDataModel?.loginFooterMsg != null && sessionDataModel?.loginFooterEnableHtml == false)
                        Text(
                          "${sessionDataModel?.loginFooterMsg}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                        ),
                    ],
                  )),
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (ModalRoute.of(context)?.canPop ?? false) {
                          context.pop();
                        } else {
                          context.push(SelectServer(), replace: true);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text("选择服务器"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      sessionDataModel?.hostname ?? '账号登录',
                      style: Theme.of(context).textTheme.headlineMedium,
                      strutStyle: StrutStyle(
                        forceStrutHeight: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.server.url}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (v) => setState(() {
                        account = v;
                      }),
                      controller: _accountController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        hintText: "账号",
                        iconColor: Colors.red,
                        suffixIcon: account.isNotEmpty
                            ? GestureDetector(
                                child: Icon(Icons.highlight_remove),
                                onTap: () {
                                  setState(() {
                                    account = '';
                                    _accountController.clear();
                                  });
                                },
                              )
                            : null,
                        // suffixIconColor: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
                      onChanged: (v) => setState(() {
                        password = v;
                      }),
                      obscureText: !showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "密码",
                        iconColor: Colors.red,
                        suffixIcon: password.isNotEmpty
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    child: Icon(Icons.password),
                                    onTap: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.highlight_remove),
                                    onTap: () {
                                      _passwordController.clear();
                                      setState(() {
                                        password = '';
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              )
                            : null,
                        // suffixIconColor: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Button(
                          child: Text(
                            "设为默认",
                            strutStyle: StrutStyle(
                              forceStrutHeight: true,
                            ),
                          ),
                          color: isDefault ? Colors.green : null,
                          fill: isDefault,
                          borderColor: isDefault ? Colors.green : Colors.black,
                          icon: Icon(
                            Icons.check,
                            color: isDefault ? Colors.white : Colors.black,
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() {
                              isDefault = !isDefault;
                            });
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Button(
                            child: Text("登录"),
                            loading: loading,
                            onPressed: login,
                          ),
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
    );
  }
}
