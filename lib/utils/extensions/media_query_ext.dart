import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigatorExt on BuildContext {
  double get width {
    return MediaQuery.of(this).size.width;
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  EdgeInsets get padding {
    return MediaQuery.of(this).padding;
  }
}
