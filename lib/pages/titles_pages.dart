import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/constant.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/widgets.dart';

class TitlesPage extends StatefulWidget {
  @override
  _TitlesPageState createState() => _TitlesPageState();
}

class _TitlesPageState extends State<TitlesPage> {
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
      body: Column(
        children: [
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            bannerAd: ads.getBannerAd(),
            leading: IconButton(
              padding: EdgeInsets.all(10.0),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              Tools.packageInfo.appName,
              style: MyTextStyles.title.apply(color: Palette.white),
              textAlign: TextAlign.center,
            ),
            onClicked: () => ads.showInter(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: titles.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ButtonFilled(
                    bgColor: Palette.accent,
                    title: Text(
                      e,
                      style: MyTextStyles.titleBold.apply(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onClicked: () {
                      ads.showInter();
                      MyNavigator.goArticle(context, titles.indexOf(e));
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonFilled(
              // bgColor: Palette.accent,
              bgColor: Colors.black,
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
        ],
      ),
    );
  }
}
