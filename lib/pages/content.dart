// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:prank_app/articles.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:page_slider/page_slider.dart';
import 'package:prank_app/widgets/dialogs.dart';
import 'package:prank_app/widgets/widgets.dart';

class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  Ads ads;
  GlobalKey<PageSliderState> _sliderKey = GlobalKey();
  String previous = "Quite";
  String next = "Next";

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    ads = new Ads();
    ads.loadInter();
    ads.loadReward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Stack(
        children: [
          Positioned(
            bottom: -Tools.width * 0.8,
            right: -Tools.width * 0.9,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/icon.png',
                width: Tools.width * 2,
              ),
            ),
          ),
          Positioned(
            top: Tools.width * 0.5,
            right: Tools.width * 0.1,
            child: Opacity(
              opacity: 0.08,
              child: Image.asset(
                'assets/icon.png',
                width: Tools.width * 0.5,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                ads.getBannerAd(),
                Expanded(
                  child: PageSlider(
                    key: _sliderKey,
                    pages: articles.map((e) {
                      return Scrollbar(
                        isAlwaysShown: true,
                        controller: scrollController,
                        radius: Radius.circular(100.0),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: HtmlWidget(
                                e,
                                customWidgetBuilder: (element) {
                                  if (element.id.contains("NativeAd"))
                                    return ads.getNativeAd();
                                  else if (element.id.contains("rate"))
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ButtonFilled(
                                        // bgColor: Colors.black,
                                        bgColor: Palette.white,
                                        title: Text(
                                          'Click here to Rate\n⭐⭐⭐⭐⭐',
                                          style: MyTextStyles.titleBold
                                              .apply(color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        onClicked: () async {
                                          int count = await showDialog(
                                              context: context,
                                              builder: (_) => RatingDialog());
                                          if (count != null && count <= 3)
                                            ads.showInter(context);
                                        },
                                      ),
                                    );
                                  else
                                    return null;
                                },
                                hyperlinkColor: Palette.white,
                                textStyle: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonFilled(
                            bgColor: Palette.white,
                            title: Text(
                              previous,
                              style:
                              MyTextStyles.titleBold.apply(fontFamily: 'SuezOne'),
                            ),
                            onClicked: () async {
                              if (_sliderKey
                                  .currentState.hasPrevious) {
                                if (_sliderKey.currentState.currentPage == 1) {
                                  setState(() {
                                    previous = "Quite";
                                  });
                                }
                                if (_sliderKey.currentState.currentPage ==
                                    articles.length - 1) {
                                  setState(() {
                                    next = "Next";
                                  });
                                }
                                _sliderKey.currentState.previous();
                                if (_sliderKey.currentState.currentPage % 2 ==
                                    0) {

                                }
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonFilled(
                            bgColor: Palette.white,
                            title: Text(
                              next,
                              style:
                              MyTextStyles.titleBold.apply(fontFamily: 'SuezOne'),
                            ),
                            onClicked: () async {

                              await ads.showInter(context);

                              Tools.logger.i(
                                  "currentPage: ${_sliderKey.currentState.currentPage}\narticles.length: ${articles.length}");
                              if (_sliderKey
                                  .currentState.hasNext) {
                                if (_sliderKey.currentState.currentPage ==
                                    articles.length - 2) {
                                  await ads.showRewardAd();
                                  setState(() {
                                    next = "Replay";
                                  });
                                }
                                if (_sliderKey.currentState.currentPage == 0) {
                                  setState(() {
                                    previous = "Previous";
                                  });
                                }
                                _sliderKey.currentState.next();
                                if (_sliderKey.currentState.currentPage % 2 ==
                                    0) {

                                }
                              } else {
                                _sliderKey.currentState.setPage(0);
                                await ads.showRewardAd();
                                setState(() {
                                  next = "Next";
                                  previous = "Quite";
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
