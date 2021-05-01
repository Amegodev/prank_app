import 'package:flutter/material.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/pages/home_page.dart';
import 'package:prank_app/utils/tools.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Tools.initAppSettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Tools.packageInfo.appName,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'),
      routes: routes,
      home: HomePage(),
    );
  }
}
