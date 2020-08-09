import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prank_app/pages/about_page.dart';
import 'package:prank_app/pages/cards_page.dart';
import 'package:prank_app/pages/counter_page.dart';
import 'package:prank_app/pages/hashtags_page.dart';
import 'package:prank_app/pages/home_page.dart';
import 'package:prank_app/pages/privacy_policy_page.dart';
import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/tools.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
  "/cards": (BuildContext context) => CardsPage(),
  "/counter": (BuildContext context) => CounterPage(),
  "/hashtags": (BuildContext context) => HashtagsPage(),
  "/privacy": (BuildContext context) => PrivacyPolicyPage(),
  "/about": (BuildContext context) => AboutPage(),
};

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  AdsHelper.initFacebookAds();
  AdsHelper.initAdmobAds();
  Tools.getAppInfo().then((value) => runApp(MyApp()));
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