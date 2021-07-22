import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/dialogs.dart';
import 'package:prank_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Ads mopubads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    mopubads = new Ads();
    mopubads.loadInter();
    customDrawer = new CustomDrawer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
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
                  clipBehavior: Clip.none, alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: -MediaQuery.of(context).size.width * 0.6,
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
                      top: -MediaQuery.of(context).size.width * 0.6,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomAppBar(
                            scaffoldKey: scaffoldKey,
                            bannerAd: mopubads.getBannerAd(),
                            title: Text(
                              Tools.packageInfo.appName,
                              style: MyTextStyles.title.apply(color: Palette.white, fontFamily: 'SuezOne'),
                              textAlign: TextAlign.center,
                            ),
                            onClicked: () => mopubads.showInter(context),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -Tools.width * 0.15,
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/icon.png',
                          width: Tools.width * 0.3,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Tools.width * 0.2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonFilled(
                        title: Text(
                          '🤔 Start Walkthrough 💭',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.white),
                        ),
                        onClicked: () {
                          mopubads.showInter(context);
                          MyNavigator.start(context);
                        },
                      ),
                    ),
                    Text(
                      "Or",
                      style: new TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonFilled(
                        // bgColor: Colors.black,
                        bgColor: Palette.black,
                        title: Text(
                          '🛒 Play And Earn 🎉',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.white),
                        ),
                        onClicked: () {
                          mopubads.showInter(context);
                          MyNavigator.goUserNamePage(context);
                        },
                      ),
                    ),
                    Text(
                      "Or",
                      style: new TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonFilled(
                        // bgColor: Colors.black,
                        bgColor: Palette.white,
                        title: Text(
                          '😍 Rate us ⭐',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.black),
                        ),
                        onClicked: () async {
                          int count = await showDialog(
                              context: context, builder: (_) => RatingDialog());
                          if (count != null && count <= 3) mopubads.showInter(context);
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
