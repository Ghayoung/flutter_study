/*
Firebase 애널리틱스 사용하기 main
 */

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'tabsPage.dart';
import 'memoPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
/*      home: FirebaseApp(
        analytics: analytics,
        observer: observer,
      ),*/
      home: MemoPage(),
    );
  }
}

class FirebaseApp extends StatefulWidget {
  FirebaseApp({Key? key, required this.analytics, required this.observer}) : super(key:key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _FirebaseAppState createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  _FirebaseAppState(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    // 애널리틱스의 logEvent를 호출해 test_event라는 키값으로 데이터 저장
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic> {
        'string': 'hello flutter',
        'int': 100,
      },
    );
    setMessage('Analytics 보내기 성공');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('테스트'),
              onPressed: _sendAnalyticsEvent,
            ),
            Text(_message, style: const TextStyle(color: Colors.blueAccent)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.tab), onPressed: () {
        Navigator.of(context).push(MaterialPageRoute<TabsPage>(
          settings: RouteSettings(name: '/tab'), // 앱에서 자주 사용하지 않는 페이지라면 이렇게 처리할 수도 있다.
          builder: (BuildContext context) {
            return TabsPage(observer);
          }
        ));
      }),
    );
  }
}