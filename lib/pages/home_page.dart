import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdsHelper ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.loadInter();
    customDrawer = new CustomDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: -MediaQuery.of(context).size.width,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 1.5,
                        width: MediaQuery.of(context).size.width * 1.5,
                        decoration: BoxDecoration(
                          color: Palette.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -MediaQuery.of(context).size.width,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 1.485,
                        width: MediaQuery.of(context).size.width * 1.485,
                        decoration: BoxDecoration(
                          color: Palette.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            Tools.packageInfo.appName,
                            style: MyTextStyles.bigTitle.apply(
                              color: Palette.white,
                              fontFamily: 'SuezOne',
                              fontSizeFactor: 1.5,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -Tools.width * 0.15,
                      child: Image.asset(
                        'assets/icon.png',
                        width: Tools.width * 0.3,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Tools.width * 0.2,),
              ads.getNativeAd(height: 200.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonFilled(
                        // bgColor: Colors.black,
                        bgColor: Palette.accent,
                        title: Text(
                          'Tango',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.black),
                        ),
                        onClicked: () {
                          ads.showInter();
                          MyNavigator.goUserNamePage(context);
                        },
                      ),
                    ),
                    Text(
                      "- Or -",
                      style: new TextStyle(
                          color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonFilled(
                        title: Text(
                          'Tango Lite',
                          style: MyTextStyles.titleBold.apply(color: Colors.white),
                        ),
                        onClicked: () {
                          ads.showInter();
                          MyNavigator.goUserNamePage(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
