import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:flutter_ironsource_x/models.dart';
import 'package:prank_app/utils/tools.dart';

class Ads with WidgetsBindingObserver {
  static const String APP_KEY = "fd1bce71";

  static bool rewardeVideoAvailable = false,
      offerwallAvailable = false,
      showBanner = false,
      isInterLoaded = false;

  Ads() {
    init();
  }

  static init() async {
    var userId = await IronSource.getAdvertiserId();

    await IronSource.validateIntegration();

    Tools.logger.wtf(userId);

    await IronSource.setUserId(userId);

    await IronSource.initialize(
        appKey: APP_KEY,
        listener: IrSourceAdListener(
            interstitialReady: isInterLoaded,
            rewardeVideoAvailable: rewardeVideoAvailable,
            offerwallAvailable: offerwallAvailable),
        gdprConsent: true,
        ccpaConsent: false);
    rewardeVideoAvailable = await IronSource.isRewardedVideoAvailable();
    offerwallAvailable = await IronSource.isOfferwallAvailable();
    // setState(() {});
  }


  loadInter() {
    IronSource.loadInterstitial();
  }

  void showInter() async {
    if (await IronSource.isInterstitialReady()) {
      // showHideBanner();
      IronSource.showInterstitial();
    } else {
      Tools.logger.i(
          "Interstial is not ready. use 'Ironsource.loadInterstial' before showing it");
    }
  }

  Widget getBannerAd() {
    return IronSourceBannerAd(keepAlive: true, listener: BannerAdListener());
  }

  Widget getNativeAd() {
    return IronSourceBannerAd(keepAlive: true, listener: BannerAdListener());
  }

  void loadReward() async {
    rewardeVideoAvailable = await IronSource.isRewardedVideoAvailable();
  }

  showRewardAd() async {
    if (await IronSource.isRewardedVideoAvailable()) {
      IronSource.showRewardedVideo();
    } else {
      Tools.logger.i("RewardedVideo not available");
    }
  }

  void loadOfferwall() async {
    offerwallAvailable = await IronSource.isOfferwallAvailable();
  }

  void showOfferwall() async {
    if (await IronSource.isOfferwallAvailable()) {
      IronSource.showOfferwall();
    } else {
      Tools.logger.i("Offerwall not available");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        IronSource.activityResumed();
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        IronSource.activityPaused();
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }
}

class IrSourceAdListener extends IronSourceListener {
  bool interstitialReady;
  bool rewardeVideoAvailable;
  bool offerwallAvailable;

  IrSourceAdListener(
      {this.interstitialReady,
      this.rewardeVideoAvailable,
      this.offerwallAvailable});

  @override
  void onInterstitialAdClicked() {
    Tools.logger.i("onInterstitialAdClicked");
  }

  @override
  void onInterstitialAdClosed() {
    Tools.logger.i("onInterstitialAdClosed");
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    Tools.logger.i("onInterstitialAdLoadFailed : ${error.errorMessage.toString()}");
  }

  @override
  void onInterstitialAdOpened() {
    Tools.logger.i("onInterstitialAdOpened");
    interstitialReady = false;
    /*setState(() {
    interstitialReady = false;
    });*/
  }

  @override
  void onInterstitialAdReady() {
    Tools.logger.i("onInterstitialAdReady");
    interstitialReady = true;
    /*setState(() {
    interstitialReady = true;
    });*/
  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {
    Tools.logger.i("onInterstitialAdShowFailed : ${error.errorMessage.toString()}");
    interstitialReady = false;
    /*setState(() {
      interstitialReady = false;
    });*/
  }

  @override
  void onInterstitialAdShowSucceeded() {
    Tools.logger.i("nInterstitialAdShowSucceeded");
  }

  @override
  void onGetOfferwallCreditsFailed(IronSourceError error) {
    Tools.logger.i("onGetOfferwallCreditsFailed : ${error.errorMessage.toString()}");
  }

  @override
  void onOfferwallAdCredited(OfferwallCredit reward) {
    Tools.logger.i("onOfferwallAdCredited : $reward");
  }

  @override
  void onOfferwallAvailable(bool available) {
    Tools.logger.i("onOfferwallAvailable : $available");

    offerwallAvailable = available;
    /*setState(() {
      offerwallAvailable = available;
    });*/
  }

  @override
  void onOfferwallClosed() {
    Tools.logger.i("onOfferwallClosed");
  }

  @override
  void onOfferwallOpened() {
    Tools.logger.i("onOfferwallOpened");
  }

  @override
  void onOfferwallShowFailed(IronSourceError error) {
    Tools.logger.i("onOfferwallShowFailed ${error.errorMessage.toString()}");
  }

  @override
  void onRewardedVideoAdClicked(Placement placement) {
    Tools.logger.i("onRewardedVideoAdClicked");
  }

  @override
  void onRewardedVideoAdClosed() {
    Tools.logger.i("onRewardedVideoAdClosed");
  }

  @override
  void onRewardedVideoAdEnded() {
    Tools.logger.i("onRewardedVideoAdEnded");
  }

  @override
  void onRewardedVideoAdOpened() {
    Tools.logger.i("onRewardedVideoAdOpened");
  }

  @override
  void onRewardedVideoAdRewarded(Placement placement) {
    Tools.logger.i("onRewardedVideoAdRewarded: ${placement.placementName}");
  }

  @override
  void onRewardedVideoAdShowFailed(IronSourceError error) {
    Tools.logger.i("onRewardedVideoAdShowFailed : ${error.errorMessage.toString()}");
  }

  @override
  void onRewardedVideoAdStarted() {
    Tools.logger.i("onRewardedVideoAdStarted");
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool available) {
    Tools.logger.i("onRewardedVideoAvailabilityChanged : $available");
    rewardeVideoAvailable = available;
    /*setState(() {
      rewardeVideoAvailable = available;
    });*/
  }
}

class BannerAdListener extends IronSourceBannerListener {
  @override
  void onBannerAdClicked() {
    Tools.logger.i("onBannerAdClicked");
  }

  @override
  void onBannerAdLeftApplication() {
    Tools.logger.i("onBannerAdLeftApplication");
  }

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    Tools.logger.i("onBannerAdLoadFailed");
  }

  @override
  void onBannerAdLoaded() {
    Tools.logger.i("onBannerAdLoaded");
  }

  @override
  void onBannerAdScreenDismissed() {
    Tools.logger.i("onBannerAdScreenDismisse");
  }

  @override
  void onBannerAdScreenPresented() {
    Tools.logger.i("onBannerAdScreenPresented");
  }
}
