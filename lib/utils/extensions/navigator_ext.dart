import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigatorExt on BuildContext {
  Future<T?> push<T extends Object?>(Widget page, {RouteSettings? settings, bool replace = false}) async {
    Route<T> router = CupertinoPageRoute<T>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
    if (replace) {
      return await Navigator.of(this).pushAndRemoveUntil(router, (e) => false);
    } else {
      return await Navigator.of(this).push(router);
    }
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
