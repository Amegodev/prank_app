import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/constants.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/widgets.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:toast/toast.dart';

class HashtagsPage extends StatefulWidget {
  @override
  _HashtagsPageState createState() => _HashtagsPageState();
}

class _HashtagsPageState extends State<HashtagsPage> {
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
    ads.loadInter();

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
                      'Congratulations',
                      style: MyTextStyles.title.apply(color: Palette.white),
                      textAlign: TextAlign.center,
                    ),
                    onClicked: () => ads.showInter(),
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 25.0),
                                child: Text(
                                  'Profile @$username shared with $totalPoints users',
                                  style: MyTextStyles.title.apply(
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
                                        seconds: 86400,
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
                                          MyNavigator.goHome(context);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LinearPercentIndicator(
                                          width: 140.0,
                                          lineHeight: 5.0,
                                          percent: 1,
                                          animationDuration: 60 * 1000,
                                          animation: true,
                                          alignment: MainAxisAlignment.center,
                                          restartAnimation: true,
                                          backgroundColor: Colors.black12,
                                          progressColor: Colors.white,
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
                    padding: const EdgeInsets.all(20.0),
                    child: ButtonOutlined(
                      title: Text(
                        'View HASHTAGS',
                        style: MyTextStyles.title.apply(color: Palette.primary),
                      ),
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('hashtags'),
                                content: Text(hashs.toList().join(' ')),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('COPY AND CONTINUE'),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: hashs.toList().join(' ')));
                                      Navigator.of(context).pop();
                                      Toast.show(
                                        'Hashtags copied to the clipboard successfully 🎉',
                                        context,
                                        gravity: Toast.BOTTOM,
                                        duration: Toast.LENGTH_LONG,
                                      );
                                      ads.showInter();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      "Or you can play again and add more coins",
                      style: new TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
              ads.getNativeAd(),
            ],
          ),
        ),
      ),
    );
  }
}
