import 'package:flutter/material.dart';

class Ads {

  static const String APP_KEY = "fd1bce71";

  static bool rewardeVideoAvailable = false,
      offerwallAvailable = false,
      showBanner = false,
      isInterLoaded = false;

  Widget bannerAd, nativeAd;

  Ads() {
    // init();
  }

  static init() async {

  }

  loadInter() {

  }

  void showInter() async {

  }

  Widget getBannerAd() {

    return bannerAd;
  }

  Widget getNativeAd() {

    return nativeAd;
  }

  void loadReward() async {

  }

  showRewardAd() async {

  }

  void loadOfferwall() async {

  }

  void showOfferwall() async {

  }

}