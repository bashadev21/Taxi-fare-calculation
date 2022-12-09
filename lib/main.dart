import 'package:flutter/material.dart';

import 'constants.dart';
import 'vehicle_selection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Taxi',
      theme: ThemeData(
        primarySwatch: themeColor,
      ),
      home: VehiclSelectioView(),
    );
  }
}
