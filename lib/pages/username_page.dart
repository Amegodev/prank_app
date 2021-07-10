import 'package:flutter/material.dart';
// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/widgets.dart';

class UsernamePage extends StatefulWidget {
  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  TextEditingController usernameTextController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    ads = new Ads();


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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomAppBar(
                    scaffoldKey: scaffoldKey,
                    title: Text(
                      '🎉 WELCOME 🎉',
                      style: MyTextStyles.title.apply(color: Palette.white),
                      textAlign: TextAlign.center,
                    ),
                    bannerAd: ads.getBannerAd(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
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
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Expanded(
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Insert your username',
                                  style: MyTextStyles.subTitle
                                      .apply(color: Palette.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 50.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Palette.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: TextField(
                                    controller: usernameTextController,
                                    keyboardType: TextInputType.text,
                                    style: MyTextStyles.titleBold
                                        .apply(color: Palette.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Username',
                                      hintStyle: TextStyle(color: Colors.white),
                                      contentPadding: EdgeInsets.all(8.0),
                                      suffix: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          color: Colors.black,
                                        ),
                                        child: InkWell(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          onTap: () =>
                                              usernameTextController.clear(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ButtonFilled(
                      title: Text(
                        'CONTINUE',
                        style: MyTextStyles.title.apply(color: Colors.white),
                      ),
                      onClicked: () async {
                        if (usernameTextController.text.isNotEmpty) {
                          MyNavigator.goCards(
                              context, usernameTextController.text.replaceAll('@', ''));
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text('Attention!'),
                                  content:
                                      Text('Invalid username 🙁\nPlease enter a valid username first.'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ),
                  InkWell(
                    child: Text(
                      "Not working?",
                      style: new TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Not working ?'),
                              content: Text(
                                  'If you have not received anything within 24 hours, please re-launch the process after a few days. The Server blocks us every so often due to the high number of requests.\nThanks for your understanding.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
