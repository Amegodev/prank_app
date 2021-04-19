import 'package:flutter/material.dart';

class MyNavigator {
  static void goHome(BuildContext context) {
//    Navigator.pushReplacementNamed(context, "/home");
    Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
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

  static void goPrivacy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }

  static void goAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }
}
