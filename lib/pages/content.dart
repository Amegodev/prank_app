import 'dart:ui';

import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/constant.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_slider/page_slider.dart';
import 'package:prank_app/widgets/dialogs.dart';
import 'package:prank_app/widgets/widgets.dart';

class ContentScreen extends StatefulWidget {
  final int articleId;

  const ContentScreen({Key key, this.articleId}) : super(key: key);
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  Ads ads;
  GlobalKey<PageSliderState> _sliderKey = GlobalKey();
  String previous = "Quite";
  String next = "Next";
  int id;

  @override
  void initState() {
    super.initState();
    ads = new Ads();
    ads.loadInter();
  }

  @override
  Widget build(BuildContext context) {

    final Map args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      id = args['id'];
    }

    return Scaffold(
      backgroundColor: Palette.primary.withOpacity(0.95),
      body: Stack(
        children: [
          Positioned(
            bottom: -Tools.width * 0.2,
            right: -Tools.width * 0.2,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/icon.png',
                width: Tools.width * 1.2,
              ),
            ),
          ),
          Positioned(
            top: Tools.width * 0.5,
            right: Tools.width * 0.1,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/icon.png',
                width: Tools.width * 0.5,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Center(
                  child: ads.getBannerAd(),
                ),
                Expanded(
                  child: PageSlider(
                    key: _sliderKey,
                    pages: articles[id].map((item) {
                      return Scrollbar(
                        radius: Radius.circular(100.0),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: HtmlWidget(
                                item,
                                customWidgetBuilder: (element) {
                                  if (element.id.contains("NativeAd"))
                                    return ads.getNativeAd(
                                      height: Tools.height * 0.8,
                                      width: Tools.width,
                                    );
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
                                            ads.showInter();
                                        },
                                      ),
                                    );
                                  else
                                    return null;
                                },
                                hyperlinkColor: Palette.black,
                                textStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Palette.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GFButton(
                          onPressed: () async {
                            if (!ads.isInterLoaded) await ads.loadInter();
                            if (_sliderKey.currentState.hasPrevious) {
                              if (_sliderKey.currentState.currentPage == 1) {
                                setState(() {
                                  previous = "Quite";
                                });
                              }
                              if (_sliderKey.currentState.currentPage ==
                                  articles[id].length - 1) {
                                setState(() {
                                  next = "Next";
                                });
                              }
                              _sliderKey.currentState.previous();
                              if (_sliderKey.currentState.currentPage % 2 ==
                                  0) {
                                ads.showInter();
                                ads.loadInter();
                              }
                            } else {
                              ads.showInter();
                              Navigator.pop(context);
                            }
                          },
                          text: previous,
                          shape: GFButtonShape.pills,
                          size: GFSize.LARGE,
                          fullWidthButton: true,
                          color: Palette.accent,
                          textStyle: MyTextStyles.bigTitleBold
                              .apply(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: GFButton(
                          onPressed: () async {
                            Tools.logger.i(
                                "currentPage: ${_sliderKey.currentState.currentPage}\narticles.length: ${articles[id].length}");
                            if (!ads.isInterLoaded) await ads.loadInter();
                            if (_sliderKey.currentState.hasNext) {
                              if (_sliderKey.currentState.currentPage ==
                                  articles[id].length - 2) {
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
                                ads.showInter();
                                ads.loadInter();
                              }
                            } else {
                              _sliderKey.currentState.setPage(0);
                              setState(() {
                                next = "Next";
                                previous = "Quite";
                              });
                            }
                          },
                          text: next,
                          shape: GFButtonShape.pills,
                          size: GFSize.LARGE,
                          fullWidthButton: true,
                          color: Palette.accent,
                          textStyle: MyTextStyles.bigTitleBold
                              .apply(color: Colors.white),
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
