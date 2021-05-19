import 'dart:async';

import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prank_app/utils/tools.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
/*

    Future.wait(
      [Tools.initAppSettings()],
    ).then((value) => MyNavigator.goHome(context));
*/

    /*Timer(Duration(seconds: 10), () {
      MyNavigator.goHome(context);
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Center(
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/icon.png',
                  width: 150.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    height: 10.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text('Loading...',style: MyTextStyles.subTitle.apply(color: Colors.black38),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
