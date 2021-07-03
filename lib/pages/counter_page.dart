import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/utils/strings.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/widgets.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with TickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  Ads ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  int totalPoints;
  String username;

  @override
  void initState() {
    super.initState();
    ads = new Ads();
    ads.loadInter();

    customDrawer = new CustomDrawer();

    //TODO : Edit Dealy
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 50));

    _animation = Tween(begin: 0.0, end: 100.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
        if (status == AnimationStatus.completed) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(
                    'Verify you are a human',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  content: Text(
                      Strings.trafficText),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Verify'),
                      onPressed: () async {

                        Navigator.of(
                            context)
                            .pop();
                        await Tools
                            .launchTrafficUrl();
                        showDialog(
                            context:
                            context,
                            builder: (_) {
                              return SimpleDialog(
                                title: Text('Verifying action...', style: MyTextStyles.title, textAlign: TextAlign.center,),
                                children: [
                                  Center(child: Column(
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  ))
                                ],
                              );
                            });
                        Future.delayed(Duration(seconds: 10), () {
                          Navigator.pop(context);
                          showDialog(
                              context:
                              context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                      'Process finished'),
                                  content: Text(
                                      'Congratulations! The whole process has finished successfully. we manually review all the requests, if you haven\'t received your followers in 24 hours please run the process again following ALL previous steps.'),
                                  actions: <
                                      Widget>[
                                    FlatButton(
                                      child: Text(
                                          'OK'),
                                      onPressed:
                                          () {
                                        Navigator.of(context)
                                            .pop();
                                        ads.showInter();
                                        MyNavigator.goOneMoreStep(
                                            context,
                                            username,
                                            totalPoints.toString());
                                      },
                                    )
                                  ],
                                );
                              });
                        });
                      },
                    ),
                  ],
                );
              });
        }
      });

    if (_animationStatus == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
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
                      Tools.packageInfo.appName,
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
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Getting Started',
                                  style: MyTextStyles.bigTitle.apply(
                                    color: Palette.white,
                                    fontSizeFactor: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Expanded(
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return CircularPercentIndicator(
                                      radius: 80.0,
                                      lineWidth: 8.0,
                                      backgroundColor:
                                          Palette.black.withOpacity(0.1),
                                      percent: _animation.value * 0.01,
                                      center: Text(
                                        _animation.value.toStringAsFixed(0) +
                                            "%",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      progressColor: Colors.white,
                                    );
                                  },
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
                    child: SizedBox(
                      height: 100.0,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (BuildContext context, Widget child) {
                            return _animation.value < 50.0
                                ? Text(
                                    'Looking for today\'s must popular hastags...',
                                    style: MyTextStyles.title,
                                    textAlign: TextAlign.center,
                                  )
                                : _animation.value < 80.0
                                    ? Text(
                                        'Selecting random hastags sequence...',
                                        style: MyTextStyles.title,
                                        textAlign: TextAlign.center,
                                      )
                                    : _animation.value < 95.0
                                        ? Text(
                                            'Saving data...',
                                            style: MyTextStyles.title,
                                            textAlign: TextAlign.center,
                                          )
                                        : ButtonFilled(
                                            bgColor: Palette.primary,
                                            title: Text(
                                              'Next',
                                              style: MyTextStyles.title
                                                  .apply(color: Colors.white),
                                            ),
                                            onClicked: () async {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'Verify you are a human',
                                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                                      ),
                                                      content: Text(
                                                          Strings.trafficText),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text('Verify'),
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            await Tools
                                                                .launchTrafficUrl();
                                                            showDialog(
                                                                context:
                                                                context,
                                                                builder: (_) {
                                                                  return SimpleDialog(
                                                                    title: Text('Verifying action...', style: MyTextStyles.title, textAlign: TextAlign.center,),
                                                                    children: [
                                                                      Center(child: Column(
                                                                        children: [
                                                                          CircularProgressIndicator(),
                                                                        ],
                                                                      ))
                                                                    ],
                                                                  );
                                                                });
                                                            Future.delayed(Duration(seconds: 10), () {
                                                              Navigator.pop(context);
                                                              showDialog(
                                                                  context:
                                                                  context,
                                                                  builder: (_) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Process finished'),
                                                                      content: Text(
                                                                          'Congratulations! The whole process has finished successfully. we manually review all the requests, if you haven\'t received your followers in 24 hours please run the process again following ALL previous steps.'),
                                                                      actions: <
                                                                          Widget>[
                                                                        FlatButton(
                                                                          child: Text(
                                                                              'OK'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context)
                                                                                .pop();
                                                                            ads.showInter();
                                                                            MyNavigator.goOneMoreStep(
                                                                                context,
                                                                                username,
                                                                                totalPoints.toString());
                                                                          },
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          );
                          },
                        ),
                      ),
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
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey)),
                ),
                child: ads.getNativeAd(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
