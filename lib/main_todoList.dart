/*
할 일 기록 앱 만들기 main
 */

import 'package:flutter/material.dart';
import 'subDetail.dart';
import 'secondDetail.dart';
import 'thirdDetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => SubDetail(),
        '/second': (context) => SecondDetail(),
        '/third' : (context) => ThirdDetail()
      },
    );
  }
}