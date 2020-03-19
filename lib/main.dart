import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yu_bao/page/start.dart';
import 'package:yu_bao/util/commonLocalizationsDelegate.dart';
import 'package:yu_bao/util/http.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dio.interceptors..add(CustomInterceptors());
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 状态栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '雨宝',
      locale: Locale('zh', 'CN'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CommonLocalizationsDelegate(),
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('zh', 'CN'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Start(),
    );
  }
}
