import 'package:flutter/material.dart';

import './screens/home.dart';
import './screens/create-qr.dart';
import './screens/scan-qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      title: 'MyQR',
      home: const Home(),
      color: Colors.red,
      routes: {
        'create': (context) => const CreateQR(),
        'scan': (context) => const ScanQR(),
      },
    );
  }
}