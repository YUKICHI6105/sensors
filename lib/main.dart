import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  // ジャイロセンサーの値
  double _gyroscopeX = 0.0;
  double _gyroscopeY = 0.0;
  double _gyroscopeZ = 0.0;

  // 加速度センサーの値
  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;

  @override
  void initState() {
    super.initState();

    // ジャイロセンサーの値を取得
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeX = event.x;
        _gyroscopeY = event.y;
        _gyroscopeZ = event.z;
      });
    });

    // 加速度センサーの値を取得
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerX = event.x;
        _accelerometerY = event.y;
        _accelerometerZ = event.z;
      });
    });
  }

  @override
  void dispose() {
    // ストリームをキャンセル
    _gyroscopeSubscription.cancel();
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ジャイロセンサー'),
            Text('X: $_gyroscopeX'),
            Text('Y: $_gyroscopeY'),
            Text('Z: $_gyroscopeZ'),
            const SizedBox(height: 20),
            const Text('加速度センサー'),
            Text('X: $_accelerometerX'),
            Text('Y: $_accelerometerY'),
            Text('Z: $_accelerometerZ'),
          ],
        ),
      ),
    );
  }
}
