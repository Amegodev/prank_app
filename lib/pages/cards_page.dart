import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/constants.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/widgets/animated_counter.dart';
import 'package:prank_app/widgets/widgets.dart';
import 'package:toast/toast.dart';

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State with TickerProviderStateMixin {
  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  var _random = new Random();
  int points;
  int points1;
  int points2;
  int totalPoints = 0;
  String username = '';
  int nbFlip = 0;

  ConfettiController _controllerCenter;

  Animation _animation;
  Animation _animation2;
  Animation _animation3;
  AnimationController _animationController;
  AnimationController _animationController2;
  AnimationController _animationController3;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  AnimationStatus _animationStatus2 = AnimationStatus.dismissed;
  AnimationStatus _animationStatus3 = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    ads = new Ads();
    ads.loadInter(/*reloadOnClose: true*/);
    ads.loadReward();

    customDrawer = CustomDrawer();

    points = _random.nextInt(listPoints.length);
    points1 = _random.nextInt(listPoints.length);
    points2 = _random.nextInt(listPoints.length);

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animationController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animationController3 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween(end: 0.0, begin: 1.0).animate(new CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });

    _animation2 = Tween(end: 0.0, begin: 1.0).animate(new CurvedAnimation(
        parent: _animationController2, curve: Curves.easeInOutBack))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus2 = status;
      });

    _animation3 = Tween(end: 0.0, begin: 1.0).animate(new CurvedAnimation(
        parent: _animationController3, curve: Curves.easeInOutBack))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus3 = status;
      });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      username = args['username'];
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          alignment: Alignment.topCenter,
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
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomAppBar(
                          scaffoldKey: scaffoldKey,
                          title: Text(
                            '😍 Flip cards to win 🎁',
                            style:
                                MyTextStyles.title.apply(color: Palette.white),
                            textAlign: TextAlign.center,
                          ),
                          onClicked: () => ads.showInter(context),
                          bannerAd: ads.getBannerAd(),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '🃏🃏🃏🃏🃏🃏',
                                  style: MyTextStyles.bigTitleBold.apply(
                                    color: Palette.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    cardFlip(
                                      onClicked: () {
                                        setState(() {
                                          totalPoints += listPoints[points];
                                        });
                                        nbFlip++;
                                        print("==================> nbflip : " +
                                            nbFlip.toString());
                                        if (nbFlip % 3 == 0) ads.showInter(context);
                                      },
                                      color: Colors.deepOrange,
                                      points: listPoints[points],
                                      animation: _animation,
                                      animationStatus: _animationStatus,
                                      animationController: _animationController,
                                    ),
                                    cardFlip(
                                      onClicked: () {
                                        setState(() {
                                          totalPoints += listPoints[points1];
                                        });
                                        nbFlip++;
                                        print("==================> nbflip : " +
                                            nbFlip.toString());
                                        if (nbFlip % 3 == 0) ads.showInter(context);
                                      },
                                      color: Colors.amber,
                                      points: listPoints[points1],
                                      animation: _animation2,
                                      animationStatus: _animationStatus2,
                                      animationController:
                                          _animationController2,
                                    ),
                                    cardFlip(
                                      onClicked: () {
                                        setState(() {
                                          totalPoints += listPoints[points2];
                                        });
                                        nbFlip++;
                                        print("==================> nbflip : " +
                                            nbFlip.toString());
                                        if (nbFlip % 3 == 0) ads.showInter(context);
                                      },
                                      color: Colors.orange,
                                      points: listPoints[points2],
                                      animation: _animation3,
                                      animationStatus: _animationStatus3,
                                      animationController:
                                          _animationController3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 35.0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                AnimatedFlipCounter(
                                  duration: Duration(seconds: 2),
                                  value: totalPoints,
                                  color: Colors.black,
                                  size: 40,
                                  celebrate: () {
                                    _controllerCenter.play();
                                  },
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: ConfettiWidget(
                                    confettiController: _controllerCenter,
                                    blastDirectionality:
                                        BlastDirectionality.explosive,
                                    shouldLoop: false,
                                    colors: const [
                                      Colors.green,
                                      Colors.blue,
                                      Colors.pink,
                                      Colors.orange,
                                      Colors.purple
                                    ], // manually specify the colors to be used
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ButtonFilled(
                            bgColor: nbFlip < 3 ? Colors.grey : Palette.primary,
                            title: Text(
                              'CONTINUE',
                              style:
                                  MyTextStyles.title.apply(color: Colors.white),
                            ),
                            onClicked: nbFlip < 3
                                ? null
                                : () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Text(
                                              'Share profile',
                                            ),
                                            content: Text(
                                                'We are going to share your profile @$username with $totalPoints users from our community (we are +2M). By using the EXACT combination of hashtags that you are going to see on the next screen you will be able to get approximately $totalPoints new potential followers.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  ads.showInter(context);
                                                  MyNavigator.goCounter(
                                                      context,
                                                      username,
                                                      totalPoints.toString());
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                          ),
                        ),
                        nbFlip < 3
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    ButtonOutlined(
                                      borderColor: Palette.primary,
                                      title: Text(
                                        'TRY AGAIN',
                                        style: MyTextStyles.title
                                            .apply(color: Palette.primary),
                                      ),
                                      onClicked: () async {
                                        if (await ads.rewardeVideoAvailable) {
                                          ads.showRewardAd();
                                          Future.delayed(Duration(seconds: 1),
                                              () => reFlipCards());
                                        } else {
                                          if (await ads.interAvailable) {
                                            ads.showInter(context);
                                            reFlipCards();
                                          } else {
                                            Toast.show(
                                              "OOPS! The Server blocks us every so often due to the high number of requests\nPlease try again later 😪.",
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM,
                                            );

                                            /*Toast.show("Please Continue watching Ad, to get more flipping chances.",
                                                context,
                                                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);*/
                                          }
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'watch an ad to try again, and win more 😉',
                                        style: MyTextStyles.subTitle
                                            .apply(fontSizeFactor: 0.8),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  ads.getNativeAd(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void reFlipCards() {
    _animationController.reverse().then((value) {
      points = _random.nextInt(listPoints.length);
    });

    _animationController2.reverse().then((value) {
      points1 = _random.nextInt(listPoints.length);
    });

    _animationController3.reverse().then((value) {
      points2 = _random.nextInt(listPoints.length);
    });
    setState(() {
      nbFlip = 0;
    });
  }
}
