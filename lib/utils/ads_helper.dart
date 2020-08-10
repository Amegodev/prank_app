import 'dart:io';
import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:prank_app/utils/theme.dart';

class AdsHelper {
//===================================> Facebook Ads:
  //FB Banner
  static String fbBannerId_1 = '2964537240339084_2964556847003790';
  static String fbBannerId_2 = '2964537240339084_2964646123661529';

  //FB Inter
  static String fbInterId_1 = '2964537240339084_2964646746994800';
  static String fbInterId_2 = '2964537240339084_2964647196994755';

  //FB Native Banner
  static String fbNativeBannerId = '2964537240339084_2964649440327864';

  //FB Native
  static String fbNativeId = '2964537240339084_2964651180327690';

//===================================> Facebook Ads:
  //FB Banner
  static String admobBannerId_1 =
      'ca-app-pub-7200723121807417/8728733843'; // test : ca-app-pub-3940256099942544/6300978111
  static String admobBannerId_2 = '';

  //FB Inter
  static String admobInterId_1 =
      'ca-app-pub-7200723121807417/1608791722'; // test : ca-app-pub-3940256099942544/1033173712
  static String admobInterId_2 = '';

  //FB Native Banner
  static String admobRewardedId =
      'ca-app-pub-7200723121807417/4272831124'; // test : ca-app-pub-3940256099942544/5224354917

  Widget fbBannerAd, admobBannerAd;
  Widget fbNativeBannerAd;
  Widget fbNativeAd;
  Widget admobRewardAd;
  FacebookInterstitialAd fbInter;

  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;

  static int adsFrequency = 50;
  bool isFbInterAdLoaded = false;
  bool isAdmobInterAdLoaded = false;
  bool isAdmobRewardedloaded = false;
  bool isAdmobRewarded = false;
  Function(bool) onRewarded;

//=======================================  Device ID For Testing :
////  My Raal Device
//  static String testingId = '49561229-6006-416f-a4e5-8ff12965dd02';
////  AVD
  static String testingId = '3f14f4ef-8bfb-4c82-abae-75b16dfa2559';

//======================================= Admob AppId :
  static String getAppId() {
    if (Platform.isIOS) {
      return ''; // test : ca-app-pub-3940256099942544~1458002511
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7200723121807417~1800363419'; //test : ca-app-pub-3940256099942544~3347511713
    }
    return null;
  }

//======================================= Initialize Ads :
  static void initFacebookAds() {
    FacebookAudienceNetwork.init(
      testingId: AdsHelper.testingId,
    );
  }

  static void initAdmobAds() {
    Admob.initialize(getAppId());
  }

  loadFbInter(String fbInterId) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: fbInterId,
      listener: (result, value) {
        print("===(Fb Inter)===> result : $result =====> value : $value");
        if (result == InterstitialAdResult.LOADED) {
          isFbInterAdLoaded = true;
        }
        if (result == InterstitialAdResult.ERROR) {
          showAdmobInter();
          print('===> Showing Admob Instead');
        }
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          isFbInterAdLoaded = false;
          loadFbInter(fbInterId);
        }
      },
    );
  }

  loadAdmobInter(String admobInterId) {
    interstitialAd = AdmobInterstitial(
      adUnitId: admobInterId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        print("===(Admob Inter)===> result : $event =====> args : $args");
        if (event == AdmobAdEvent.closed || event == AdmobAdEvent.completed)
          interstitialAd.load();
        if (event == AdmobAdEvent.loaded) isAdmobInterAdLoaded = true;
        if (event == AdmobAdEvent.failedToLoad) {
          isAdmobInterAdLoaded = false;
          loadAdmobInter(admobInterId);
        }
      },
    );
    interstitialAd.load();
  }

  loadAdmobReward(String admobRewardId) {
    rewardAd = AdmobReward(
      adUnitId: admobRewardId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        print("===(Admob Reward)===> result : $event =====> args : $args");
        if (event == AdmobAdEvent.closed) {
          onRewarded(isAdmobRewarded);
          rewardAd.load();
          isAdmobRewarded = false;
        }
        if (event == AdmobAdEvent.loaded) isAdmobRewardedloaded = true;
        if (event == AdmobAdEvent.rewarded) isAdmobRewarded = true;
        if (event == AdmobAdEvent.failedToLoad) {
          isAdmobRewardedloaded = false;
          isAdmobRewarded = false;
          loadAdmobReward(admobRewardId);
        }
      },
    );
    rewardAd.load();
  }

  showFbInter({int delay = 0}) {
    if (isFbInterAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd(delay: delay);
      print('===(Fb Inter)===> Inter Ad is about to be Showen :D');
    } else {
      print("===(fb Inter)===> Inter Ad not yet loaded!");
    }
  }

  showAdmobInter() {
    if (isAdmobInterAdLoaded == true) {
      interstitialAd.show();
      print('===(Admob Inter)===> Inter Ad is about to be Showen :D');
    } else {
      print("===(Admob Inter)===> Inter Ad not yet loaded!");
    }
  }

  showAdmobReward({Function(bool) onFailedLoad, int delay = 0}) {
    if (isAdmobRewardedloaded == true) {
      rewardAd.show();
      print('===(Admob Reward)===> Reward Ad is about to be Showen :D');
    } else {
      print("===(Admob Reward)===> Reward Ad not yet loaded!");
      if(isFbInterAdLoaded){
        onFailedLoad(true);
//        showFbInter(delay: delay);
      }else if(isAdmobInterAdLoaded){
        onFailedLoad(true);
//        showAdmobInter();
      }else {
        onFailedLoad(false);
      }
    }
  }

  bool showInter({int probablity, delay = 0})  {
    if (probablity == null) probablity = AdsHelper.adsFrequency;
    Random r = new Random();
    double falseProbability = (100 - probablity) / 100;
    bool result = r.nextDouble() > falseProbability;
    if (result) {
      Random rr = new Random();
      if (rr.nextBool()) {
        showFbInter(delay: delay);
      } else {
        Future.delayed(Duration(milliseconds: delay), () => showAdmobInter());
      }
    }
    print('===> Probablity of $probablity% return $result');
    return result;
  }

  Widget getFbBanner(String bannerId, BannerSize size) {
    if (fbBannerAd == null) {
      fbBannerAd = Container(
        //margin: EdgeInsets.only(bottom: 5.0),
        alignment: Alignment(0.5, 1),
        child: FacebookBannerAd(
          placementId: bannerId,
          bannerSize: size,
          listener: (result, value) {
            print("===(Fb Banner)===> $value");
          },
        ),
      );
    }
    return fbBannerAd;
  }

  Widget getAdmobBanner(String bannerId, AdmobBannerSize size) {
    if (fbBannerAd == null) {
      fbBannerAd = Container(
        child: AdmobBanner(
          adUnitId: bannerId,
          adSize: size,
          listener: (AdmobAdEvent event, Map<String, dynamic> args) {
            print("===(Admob Banner)=== result : $event =====> $args");
          },
        ),
      );
    }
    return fbBannerAd;
  }

  Widget getFbNativeBanner(String nativeBannerId, NativeBannerAdSize size) {
    if (fbNativeBannerAd == null) {
      fbNativeBannerAd = Container(
        child: FacebookNativeAd(
          placementId: nativeBannerId,
          adType: NativeAdType.NATIVE_BANNER_AD,
          bannerAdSize: size,
          width: double.infinity,
          backgroundColor: MyColors.white,
          titleColor: MyColors.black,
          descriptionColor: Colors.grey,
          buttonColor: Colors.black,
          buttonTitleColor: Colors.white,
          buttonBorderColor: Colors.black,
          listener: (result, value) {
            print("===(Fb NativeBanner)===> $value");
          },
        ),
      );
    }
    return fbNativeBannerAd;
  }

  Widget getFbNative(String fbNativeId, double size) {
    if (fbNativeAd == null) {
      fbNativeAd = Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: FacebookNativeAd(
          placementId: fbNativeId,
          adType: NativeAdType.NATIVE_AD,
          width: double.infinity,
          height: size,
          backgroundColor: MyColors.accent,
          titleColor: Colors.black,
          descriptionColor: Colors.black,
          buttonColor: MyColors.black,
          buttonTitleColor: Colors.white,
          buttonBorderColor: Colors.white,
          listener: (result, value) {
            print("===(Fb Native)===> : --> $value");
          },
        ),
      );
    }
    return fbNativeAd;
  }

  disposeAllAds() {
    FacebookInterstitialAd.destroyInterstitialAd();
    interstitialAd.dispose();
  }
}
