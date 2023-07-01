import 'dart:io';

import 'package:dsm_app/pages/splash/splash.dart';
import 'package:dsm_app/themes/light_theme.dart';
import 'package:dsm_app/widgets/keyboard_dismisser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const DsmApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }
}

class DsmApp extends StatelessWidget {
  const DsmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MaterialApp(
        title: '群晖助手',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        supportedLocales: const [
          Locale('zh', 'CN'),
        ],
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const Splash(),
      ),
    );
  }
}
