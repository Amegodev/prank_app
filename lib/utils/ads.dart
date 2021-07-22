import 'package:flutter/material.dart';
import 'package:prank_app/utils/ads_networks/mopub.dart';

class Ads {
  MopubHelper mopub = MopubHelper();


  Future<bool> get interAvailable async => await mopub.interstitialAd.isReady();
  Future<bool> get rewardeVideoAvailable async => await mopub.rewardAd.isReady();

  Widget bannerAd = Container(
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
      ),
      nativeAd = Container(
        width: 320.0,
        height: 100.0,
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

  // Ads() {}


  static init() async {
    await MopubHelper.init();
  }

  Future<void> loadInter() async {
    await mopub.loadInterstitialAd();
  }

  Future<void> showInter(BuildContext context) async {
    await mopub.showInter();
  }

  Widget getBannerAd() {
    // return bannerAd;
    return mopub.getBannerAd();
  }

  Widget getNativeAd() {
    return nativeAd;
  }

  Future<void> loadReward() async {
    await mopub.loadRewardedAd();
  }

  Future<void> showRewardAd() async {
    await mopub.showRewardedAd();
  }

  void loadOfferwall() async {}

  void showOfferwall() async {}
}
