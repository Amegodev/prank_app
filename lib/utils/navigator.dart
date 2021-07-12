import 'package:flutter/material.dart';
import 'package:prank_app/pages/about_page.dart';
import 'package:prank_app/pages/cards_page.dart';
import 'package:prank_app/pages/content_pager.dart';
import 'package:prank_app/pages/counter_page.dart';
import 'package:prank_app/pages/counter_hashtags_page.dart';
import 'package:prank_app/pages/home_page.dart';
import 'package:prank_app/pages/more_apps.dart';
import 'package:prank_app/pages/username_page.dart';
import 'package:prank_app/pages/counter_almost_done.dart';
import 'package:prank_app/pages/privacy_policy_page.dart';

class MyNavigator {
  static void goHome(BuildContext context) {
//    Navigator.pushReplacementNamed(context, "/home");
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
  }

  static void start(BuildContext context) {
    Navigator.pushNamed(context, '/start');
  }

  static void goUserNamePage(BuildContext context) {
    Navigator.pushNamed(context, "/username");
  }

  static void goCards(BuildContext context, String username) {
    Navigator.pushNamed(context, '/cards', arguments: {"username": username});
  }

  static void goCounter(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/counter', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void goOneMoreStep(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/oneMoreStep', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void goHashtags(BuildContext context, String username, String totalPoints) {
    Navigator.pushNamed(context, '/hashtags', arguments: {"username": username, "totalPoints" : totalPoints});
  }

  static void moreApps(BuildContext context) {
    Navigator.pushNamed(context, '/moreApps');
  }

  static void goPrivacy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }

  static void goAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }
}


var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
  '/start': (BuildContext context) => ContentScreen(),
  "/username": (BuildContext context) => UsernamePage(),
  "/cards": (BuildContext context) => CardsPage(),
  "/counter": (BuildContext context) => CounterPage(),
  "/oneMoreStep": (BuildContext context) => OneMoreStep(),
  "/hashtags": (BuildContext context) => HashtagsPage(),
  '/moreApps': (BuildContext context) => MoreApps(),
  "/privacy": (BuildContext context) => PrivacyPolicyPage(),
  "/about": (BuildContext context) => AboutPage(),
};

