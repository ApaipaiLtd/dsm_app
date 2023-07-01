import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'http_util.dart';

class Util {
  //弹框提示
  static void showToast(String message,
      {Toast toastLength = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.CENTER}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 1,
    );
  }

  static DateTime? lastPopTime;
  // 退出APP确认
  static Future<bool> appWillPop() async {
    if (lastPopTime == null ||
        DateTime.now().difference(lastPopTime!) > Duration(seconds: 2)) {
      lastPopTime = DateTime.now();
      Util.showToast('再按一次退出');
    } else {
      lastPopTime = DateTime.now();
      // 退出app
      SystemNavigator.pop();
    }
    return Future.value(false);
  }
}
