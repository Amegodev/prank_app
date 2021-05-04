import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/constant.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_slider/page_slider.dart';

class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  Ads ads;
  GlobalKey<PageSliderState> _sliderKey = GlobalKey();
  String previous = "Quite";
  String next = "Next";

  @override
  void initState() {
    super.initState();
    ads = new Ads();
    ads.loadInter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary.withOpacity(0.95),
      body: Stack(
        children: [
          Positioned(
            bottom: -Tools.width * 0.2,
            right: -Tools.width * 0.2,
            child: Opacity(
              opacity: 0.4,
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
              opacity: 0.2,
              child: Image.asset(
                'assets/icon.png',
                width: Tools.width * 0.5,
              ),
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
                    pages: articles.map((e) {
                      return Scrollbar(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: HtmlWidget(
                                e,
                                customWidgetBuilder: (element) {
                                  if (element.id.contains("NativeAd"))
                                    return ads.getNativeAd(
                                      height: Tools.height * 0.8,
                                      width: Tools.width,
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
                                  articles.length - 1) {
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
                          color: Palette.primary,
                          textStyle: MyTextStyles.bigTitleBold.apply(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: GFButton(
                          onPressed: () async {
                            Tools.logger.i(
                                "currentPage: ${_sliderKey.currentState.currentPage}\narticles.length: ${articles.length}");
                            if (!ads.isInterLoaded) await ads.loadInter();
                            if (_sliderKey.currentState.hasNext) {
                              if (_sliderKey.currentState.currentPage ==
                                  articles.length - 2) {
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
                          color: Palette.primary,
                          textStyle: MyTextStyles.bigTitleBold.apply(color: Colors.white),
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
