import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/strings.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/widgets/widgets.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      backgroundColor: Palette.primary,
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -200.0,
            top: -50.0,
            child: Opacity(
              child: SvgPicture.asset(
                'assets/icons/privacy_policy.svg',
                width: 500.0,
              ),
              opacity: 0.2,
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                CustomAppBar(
                  scaffoldKey: scaffoldKey,
                  leading: IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                  title: Text(
                    Strings.privacy,
                    style: MyTextStyles.title.apply(color: Palette.white),
                    textAlign: TextAlign.center,
                  ),
                  bannerAd: ads.getBannerAd(),
                  onClicked: () => ads.showInter(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        Strings.privacyText,
                        textStyle: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                MainButton(
                  title: Text(
                    'Return',
                    style: MyTextStyles.bigTitle.apply(color: Palette.white),
                  ),
                  svgIcon: 'assets/icons/back.svg',
                  bgColor: Palette.black,
                  textColor: Palette.white,
                  onClicked: () {
                    ads.showInter();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
