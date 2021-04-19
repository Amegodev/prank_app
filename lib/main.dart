import 'package:flutter/material.dart';
import 'package:prank_app/pages/about_page.dart';
import 'package:prank_app/pages/cards_page.dart';
import 'package:prank_app/pages/counter_page.dart';
import 'package:prank_app/pages/hashtags_page.dart';
import 'package:prank_app/pages/home_page.dart';
import 'package:prank_app/pages/username_page.dart';
import 'package:prank_app/pages/one_more_step_page.dart';
import 'package:prank_app/pages/privacy_policy_page.dart';
import 'package:prank_app/utils/tools.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
  "/username": (BuildContext context) => UsernamePage(),
  "/cards": (BuildContext context) => CardsPage(),
  "/counter": (BuildContext context) => CounterPage(),
  "/oneMoreStep": (BuildContext context) => OneMoreStep(),
  "/hashtags": (BuildContext context) => HashtagsPage(),
  "/privacy": (BuildContext context) => PrivacyPolicyPage(),
  "/about": (BuildContext context) => AboutPage(),
};

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
