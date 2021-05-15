import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prank_app/utils/ads_helper.dart';
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
  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new Ads();
    Tools.checkAppVersion(context);
    ads.loadInter();
    customDrawer = new CustomDrawer();
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
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                            'assets/icons/burger_menu.svg',
                            color: Palette.black,
                          ),
                        ),
                        onPressed: () =>
                            scaffoldKey.currentState.openDrawer(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.star,
                            color: Palette.black,
                          ),
                        ),
                        onPressed: () async {
                          int count = await showDialog(
                              context: context,
                              builder: (_) => RatingDialog());
                          if (count != null && count <= 3) ads.showInter();
                        },
                      ),
                    ),
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
                    Positioned(
                      bottom: -Tools.width * 0.15,
                      child: SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: Tools.width,
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
                            Image.asset(
                              'assets/icon.png',
                              width: Tools.width * 0.3,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Tools.width * 0.2,
              ),
              ads.getNativeAd(height: 200.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonFilled(
                        title: Text(
                          'Guide & Tips 💡',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.white),
                        ),
                        onClicked: () {
                          ads.showInter();
                          MyNavigator.goTitles(context);
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
                        bgColor: Palette.accent,
                        // bgColor: Colors.black,
                        title: Text(
                          '💎 Earn Diamonds 💎',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.white),
                        ),
                        onClicked: () {
                          ads.showInter();
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
                        bgColor: Colors.black,
                        title: Text(
                          '😍 Rate us 😍\n⭐⭐⭐⭐⭐',
                          style:
                              MyTextStyles.titleBold.apply(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        onClicked: () async {
                          int count = await showDialog(
                              context: context, builder: (_) => RatingDialog());
                          if(count != null && count <= 3) ads.showInter();
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
