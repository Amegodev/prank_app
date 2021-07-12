import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:tapdaq_flutter/tapdaq_flutter.dart';

class Ads {
  static const String APPLOVIN_APP_KEY =
      "QO91l1_TOsERBEiVdyJ1_v6565RlGQWzRisC9X6f4R7ycMd9S-piVBfREtbtmUp8IDf8a3H_O-fk-rFy9nk0JH";

  static const String TAPDAQ_APP_KEY = "60ead1d808fe6c2d735d67f4";
  static const String TAPDAQ_CLIENT_KEY =
      "be58c4e8-9d82-450a-8903-4ef39755ec48";

  static bool rewardeVideoAvailable = false,
      offerwallAvailable = false,
      showBanner = false,
      isInterLoaded = false;

  static Tapdaq tapdaq = new Tapdaq(
    appId: TAPDAQ_APP_KEY,
    clientKey: TAPDAQ_CLIENT_KEY,
  );

  TapdaqInterstitial tapdaqInterstitial = new TapdaqInterstitial(
    adTag: "testtagone",
    listener: (tapdaqInterstitiaEvent, value) {
      Tools.logger.wtf("tapdaqBannerEventHandler $tapdaqInterstitiaEvent");
      Tools.logger.wtf("Event: $value");
    },
  );

  Widget bannerAd, nativeAd;

  Ads() {
    // init();
    init();
  }

  static init() async {
    // await FlutterApplovinMax.init(APPLOVIN_APP_KEY);
    tapdaq.initialize();
    // tapdaq.test();
  }

  Future<void> loadInter() async {
    tapdaqInterstitial.load();
  }

  void showInter() async {
    bool isInterLoaded = await tapdaqInterstitial.isLoaded;
    if (isInterLoaded != null) {
      tapdaqInterstitial.show();
    } else {
      Tools.logger.i("Tapdaq Inter not loaded yet");
    }
  }

  Widget getBannerAd() {
    return Container(
      width: 320.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black87,
        ),
      ),
      child: Center(
        child: Text(
          "Banner Ad",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );

    if (bannerAd == null) {
      bannerAd = TapdaqBanner(
        adSize: TapdaqBannerSize.STANDARD,
        adTag: "testtagbannerone",
        listener: (tapdaqBannerEventHandler, value) async {
          Tools.logger
              .wtf("tapdaqBannerEventHandler $tapdaqBannerEventHandler");
          Tools.logger.wtf("Event: $value");
          /*switch (event.) {
            case 'didLoad':
              _listener(TapdaqBannerEvent.didLoad, null);
              break;
            case 'didFailToLoad':
              _listener(TapdaqBannerEvent.didFailToLoad,
                  Map<String, dynamic>.from(call.arguments));
              break;
            case 'didRefresh':
              _listener(TapdaqBannerEvent.didRefresh, null);
              break;
            case 'didFailToRefresh':
              _listener(TapdaqBannerEvent.didFailToRefresh,
                  Map<String, dynamic>.from(call.arguments));
              break;
            case 'didClick':
              _listener(TapdaqBannerEvent.didClick, null);
              break;
          }*/
        },
        onBannerCreated: (onBannercreated) {
          Tools.logger.wtf("onBannercreated: $onBannercreated");
        },
      );

      return bannerAd;
    }

    return bannerAd;
  }

  Widget getNativeAd() {
    return Container(
      width: 320.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black87,
        ),
      ),
      child: Center(
        child: Text(
          "Native Ad",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
    return nativeAd;
  }

  void loadReward() async {}

  showRewardAd() async {}

  void loadOfferwall() async {}

  void showOfferwall() async {}
}
