import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> sensors = [];

  @override
  void initState() {
    super.initState();
    getAvailableSensors();
  }

  void getAvailableSensors() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      const platform = MethodChannel('com.example.safe_distance/sensors');
      List<dynamic> result = await platform.invokeMethod('getSensors');
      sensors = List<String>.from(result);
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to get available sensors: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Available Sensors'),
        ),
        body: ListView.builder(
          itemCount: sensors.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(sensors[index]),
            );
          },
        ),
      ),
    );
  }
}
