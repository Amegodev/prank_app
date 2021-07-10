import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/constants.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/widgets.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OneMoreStep extends StatefulWidget {
  @override
  _OneMoreStepState createState() => _OneMoreStepState();
}

class _OneMoreStepState extends State<OneMoreStep> {
  Ads ads;
  CustomDrawer customDrawer;
  int totalPoints;
  String username;
  List hashs;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new Ads();


    customDrawer = new CustomDrawer();
    hashs = Tools.shuffle(Constants.hashtag, 40, 60);
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      totalPoints = int.parse(args['totalPoints']);
      username = args['username'];
    }

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
                    bannerAd: ads.getBannerAd(),
                    title: Text(
                      'Almost done',
                      style: MyTextStyles.title.apply(color: Palette.white),
                      textAlign: TextAlign.center,
                    ),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Verifiyng previous step !',
                                  style: MyTextStyles.title.apply(
                                    color: Palette.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'PLEASE WAIT...',
                                  style: MyTextStyles.titleBold.apply(
                                    color: Palette.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Countdown(
                                        seconds: 40,
                                        build: (BuildContext context,
                                            double time) {
                                          return Text(
                                            format(
                                              Duration(seconds: time.toInt()),
                                            ),
                                            style:
                                                MyTextStyles.bigTitleBold.apply(
                                              color: Palette.white,
                                              fontSizeFactor: 1.5,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        },
                                        interval: Duration(milliseconds: 100),
                                        onFinished: () {
                                          MyNavigator.goHashtags(context,
                                              username, totalPoints.toString());
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularPercentIndicator(
                                          percent: 1,
                                          animationDuration: 40 * 1000,
                                          animation: true,
                                          restartAnimation: false,
                                          reverse: false,
                                          backgroundColor: Colors.black12,
                                          progressColor: Colors.white,
                                          radius: 60.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Make sure that you complet the previous step, it\'s very important ⚠ to complet the process",
                      style: new TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonOutlined(
                          title: Text(
                            'Previous',
                            style:
                            MyTextStyles.title.apply(color: Palette.primary),
                          ),
                          onClicked: () {
                            ads.showInter();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Text(
                        "- Or -",
                        style: new TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonFilled(
                          title: Text(
                            'PLAY AGAIN',
                            style: MyTextStyles.title.apply(color: Colors.white),
                          ),
                          onClicked: () {
                            ads.showInter();
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName("/cards"));
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: InkWell(
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
                                      ads.showInter();
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
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
