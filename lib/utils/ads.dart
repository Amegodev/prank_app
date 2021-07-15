import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:flutter_ironsource_x/models.dart';
import 'package:prank_app/utils/tools.dart';
// import 'package:tapdaq_flutter/tapdaq_flutter.dart';

class Ads with WidgetsBindingObserver {
  static const String IRONSOURCE_APP_KEY = "fd1bce71";

  static const String APPLOVIN_APP_KEY =
      "QO91l1_TOsERBEiVdyJ1_v6565RlGQWzRisC9X6f4R7ycMd9S-piVBfREtbtmUp8IDf8a3H_O-fk-rFy9nk0JH";

  static const String TAPDAQ_APP_KEY = "60ead1d808fe6c2d735d67f4";
  static const String TAPDAQ_CLIENT_KEY =
      "be58c4e8-9d82-450a-8903-4ef39755ec48";

  static bool rewardeVideoAvailable = false,
      offerwallAvailable = false,
      showBanner = false,
      isInterLoaded = false;

  /*static Tapdaq tapdaq = new Tapdaq(
    appId: TAPDAQ_APP_KEY,
    clientKey: TAPDAQ_CLIENT_KEY,
  );*/

  /*TapdaqInterstitial tapdaqInterstitial = new TapdaqInterstitial(
    adTag: "testtagone",
    listener: (tapdaqInterstitiaEvent, value) {
      Tools.logger.wtf("tapdaqBannerEventHandler $tapdaqInterstitiaEvent");
      Tools.logger.wtf("Event: $value");
    },
  );*/

  Widget bannerAd, nativeAd;

  Ads() {
    init();
  }

  static init() async {
    // var userId = await IronSource.getAdvertiserId();
    // await IronSource.validateIntegration();

    // Tools.logger.wtf(userId);

    // await IronSource.setUserId(userId);

    await IronSource.initialize(
        appKey: IRONSOURCE_APP_KEY,
        listener: IrSourceAdListener(
            interstitialReady: isInterLoaded,
            rewardeVideoAvailable: rewardeVideoAvailable,
            offerwallAvailable: offerwallAvailable),
        gdprConsent: true,
        ccpaConsent: false);
    rewardeVideoAvailable = await IronSource.isRewardedVideoAvailable();
    offerwallAvailable = await IronSource.isOfferwallAvailable();
  }

  loadInter() {
    IronSource.loadInterstitial();
  }

  Future<void> showInter(BuildContext context) async {
    if (await IronSource.isInterstitialReady()) {
      await IronSource.showInterstitial();
    } else {
      Tools.logger.i("IronSource Inter not loaded yet");
    }

    /*bool isInterLoaded = await tapdaqInterstitial.isLoaded;
    if (isInterLoaded != null) {
      tapdaqInterstitial.show();
    } else {
      Tools.logger.i("Tapdaq Inter not loaded yet");
    }*/
  }

  Widget getBannerAd() {
    if (bannerAd == null) {
      bannerAd = Container(
        padding: EdgeInsets.only(bottom: 2),
        width: Tools.width,
        child: new IronSourceBannerAd(
          listener: new BannerAdListener(this),
        ),
      );
      return bannerAd;
    }

    return bannerAd;

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

    /*if (bannerAd == null) {
      bannerAd = TapdaqBanner(
        adSize: TapdaqBannerSize.STANDARD,
        adTag: "testtagbannerone",
        listener: (tapdaqBannerEventHandler, value) async {
          Tools.logger
              .wtf("tapdaqBannerEventHandler $tapdaqBannerEventHandler");
          Tools.logger.wtf("Event: $value");
          */ /*switch (event.) {
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
          }*/ /*
        },
        onBannerCreated: (onBannercreated) {
          Tools.logger.wtf("onBannercreated: $onBannercreated");
        },
      );

      return bannerAd;
    }
*/
    return bannerAd;
  }

  Widget getNativeAd() {
    if (nativeAd == null) {
      nativeAd = Container(
        width: Tools.width,
        child: IronSourceBannerAd(
          keepAlive: true,
          listener: new BannerAdListener(this),
        ),
      );
      return nativeAd;
    }

    return nativeAd;

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

  void showRewardAd() async {
    if (await IronSource.isRewardedVideoAvailable()) {
      IronSource.showRewardedVideo();
    } else {
      Tools.logger.i("RewardedVideo not available");
    }
  }

  void loadOfferwall() async {}

  void showOfferwall() async {
    if (await IronSource.isOfferwallAvailable()) {
      IronSource.showOfferwall();
    } else {
      print("Offerwall not available");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        IronSource.activityResumed();
        break;
      case AppLifecycleState.paused:
        // IronSource.activityPaused();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }
}

class IrSourceAdListener extends IronSourceListener {
  final bool interstitialReady, rewardeVideoAvailable, offerwallAvailable;

  IrSourceAdListener(
      {this.interstitialReady,
      this.rewardeVideoAvailable,
      this.offerwallAvailable});

  @override
  void onInterstitialAdClicked() {
    Tools.logger.i("onInterstitialAdClicked");
  }

  @override
  void onGetOfferwallCreditsFailed(IronSourceError error) {
    // implement onGetOfferwallCreditsFailed
    Tools.logger.i("onGetOfferwallCreditsFailed: $error");
  }

  @override
  void onInterstitialAdClosed() {
    // implement onInterstitialAdClosed
    IronSource.loadInterstitial();
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    // implement onInterstitialAdLoadFailed
    Tools.logger.i("onInterstitialAdLoadFailed: $error");
  }

  @override
  void onInterstitialAdOpened() {
    // implement onInterstitialAdOpened
  }

  @override
  void onInterstitialAdReady() {
    // implement onInterstitialAdReady
    Tools.logger.i("onInterstitialAdReady");
  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {
    // implement onInterstitialAdShowFailed
  }

  @override
  void onInterstitialAdShowSucceeded() {
    // implement onInterstitialAdShowSucceeded
  }

  @override
  void onOfferwallAdCredited(OfferwallCredit reward) {
    // implement onOfferwallAdCredited
  }

  @override
  void onOfferwallAvailable(bool available) {
    // implement onOfferwallAvailable
    Tools.logger.i("onOfferwallAvailable");
  }

  @override
  void onOfferwallClosed() {
    // implement onOfferwallClosed
    Tools.logger.i("onOfferwallClosed");
  }

  @override
  void onOfferwallOpened() {
    // implement onOfferwallOpened
    Tools.logger.i("onOfferwallOpened");
  }

  @override
  void onOfferwallShowFailed(IronSourceError error) {
    // implement onOfferwallShowFailed
    Tools.logger.i("onOfferwallShowFailed: $error");
  }

  @override
  void onRewardedVideoAdClicked(Placement placement) {
    // implement onRewardedVideoAdClicked
    Tools.logger.i("onRewardedVideoAdClicked: placement($placement)");
  }

  @override
  void onRewardedVideoAdClosed() {
    // implement onRewardedVideoAdClosed
    Tools.logger.i("onRewardedVideoAdClosed");
  }

  @override
  void onRewardedVideoAdEnded() {
    // implement onRewardedVideoAdEnded
    Tools.logger.i("onRewardedVideoAdEnded");
  }

  @override
  void onRewardedVideoAdOpened() {
    // implement onRewardedVideoAdOpened
  }

  @override
  void onRewardedVideoAdRewarded(Placement placement) {
    // implement onRewardedVideoAdRewarded
    Tools.logger.i("onRewardedVideoAdRewarded: placement($placement)");
  }

  @override
  void onRewardedVideoAdShowFailed(IronSourceError error) {
    // implement onRewardedVideoAdShowFailed
    Tools.logger.i("onRewardedVideoAdShowFailed: $error");
  }

  @override
  void onRewardedVideoAdStarted() {
    // implement onRewardedVideoAdStarted
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool available) {
    // implement onRewardedVideoAvailabilityChanged
  }
}

class BannerAdListener extends IronSourceBannerListener {
  final Ads ads;

  BannerAdListener(this.ads);

  @override
  void onBannerAdClicked() {
    Tools.logger.wtf("onBannerAdClicked");
  }

  @override
  void onBannerAdLeftApplication() {
    Tools.logger.wtf("onBannerAdLeftApplication");
  }

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    Tools.logger.wtf("onBannerAdLoadFailed");
    ads.bannerAd = ads.getNativeAd();
  }

  @override
  void onBannerAdLoaded() {
    Tools.logger.wtf("onBannerAdLoaded");
  }

  @override
  void onBannerAdScreenDismissed() {
    Tools.logger.wtf("onBannerAdScreenDismisse");
  }

  @override
  void onBannerAdScreenPresented() {
    Tools.logger.wtf("onBannerAdScreenPresented");
  }
}
