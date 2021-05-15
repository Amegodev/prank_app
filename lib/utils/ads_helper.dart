import 'package:flutter/foundation.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart' as fb;
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart' as admob;
import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

class Ads {
  //static String testDeviceId ="a47d5108-ce0c-4f2b-bb22-d7eea19727cd"; //Real device
  static String testDeviceId = "e5c56faf-6e34-4a4c-8f5a-e8cd07f43b2a"; //AVD

  static String adNetwork = "fb";

  // TODO: Change this please $$
  // static final bool debugMode = true;
  static final bool debugMode = kDebugMode;

  static String admobBanner = kDebugMode
      ? MobileAds.bannerAdTestUnitId
      : "ca-app-pub-8644958469423958/2887839799";
  static String admobInter = kDebugMode
      ? MobileAds.interstitialAdTestUnitId
      : "ca-app-pub-8644958469423958/1574758120";
  static String admobNative = kDebugMode
      ? MobileAds.nativeAdTestUnitId
      : "ca-app-pub-8644958469423958/4009349771";
  static String admobReward = kDebugMode
      ? MobileAds.rewardedAdTestUnitId
      : "ca-app-pub-8644958469423958/6635513118";

  InterstitialAd interstitialAd = InterstitialAd(unitId: admobInter);
  RewardedAd rewardedAd = RewardedAd();
  final controller = BannerAdController();

  //Facebook Ads
  String fbBanner = "979549719249821_979549772583149";
  String fbInter = "979549719249821_979549782583148";
  String fbNative = "979549719249821_979549769249816";

  static String unityGameId = "4111845";
  String unityAdId = "video";

  Widget bannerAd = SizedBox();
  Widget nativeAd = SizedBox();

  bool isInterLoaded = false;

  static bool isVersionUpToLOLLIPOP() {
    bool isVersionUp = true;
    if (Tools.androidInfo.version.sdkInt <= 23) isVersionUp = false;
    return isVersionUp;
  }

  static init() async {
    adNetwork = await Tools.fetchRemoteConfig(
        '${Tools.packageInfo.packageName.replaceAll('.', '_')}_ads') ?? "fb";

    Tools.logger.wtf('addddddddssssssssss: $adNetwork');
    switch (adNetwork) {
      case "fb":
        await FacebookAudienceNetwork.init(
          testingId: testDeviceId,
        );
        break;
      case "admob":
        await MobileAds.initialize(
          bannerAdUnitId: admobBanner,
          interstitialAdUnitId: admobInter,
          nativeAdUnitId: admobNative,
          rewardedAdUnitId: admobReward,
        );
        MobileAds.setTestDeviceIds([testDeviceId]);
        break;
      default:
        break;
    }

    if (isVersionUpToLOLLIPOP() && !kDebugMode) {
      UnityAds.init(
        gameId: unityGameId,
        listener: (state, args) => Tools.logger.i('Unity Ads: $state => $args'),
      );
    }
  }

  loadInter({bool reloadOnClose = false}) async {
    switch (adNetwork) {
      case "fb":
        FacebookInterstitialAd.loadInterstitialAd(
          placementId: fbInter,
          listener: (result, value) {
            Tools.logger.i('Fb Inter: $result\nvalue: $value');
            switch (result) {
              case InterstitialAdResult.DISMISSED:
                isInterLoaded = false;
                // FacebookInterstitialAd.loadInterstitialAd();
                if(reloadOnClose) loadInter();
                break;
              case InterstitialAdResult.LOADED:
                isInterLoaded = true;
                break;
              default:
                break;
            }
            Tools.logger.i('isInterLoaded: $isInterLoaded');
          },
        );
        break;
      case "admob":
        interstitialAd.load();
        interstitialAd.onEvent.listen((e) {
          final event = e.keys.first;
          Tools.logger.e('Admob Inter: $event');
          switch (event) {
            case FullScreenAdEvent.closed:
            // interstitialAd.load();
              isInterLoaded = false;
              break;
            case FullScreenAdEvent.loaded:
              isInterLoaded = true;
              break;
            default:
              break;
          }
        });
        break;
      default:
        break;
    }
  }

  loadReward({Function(bool) onRewarded}) async {
    switch (adNetwork) {
      case "admob":
        await rewardedAd.load(unitId: admobReward);
        rewardedAd.onEvent.listen((e) {
          final event = e.keys.first;
          Tools.logger.i('Admob Reward: $event\nKes: ${e.keys}');
          switch (event) {
            case RewardedAdEvent.closed:
              rewardedAd.load(unitId: admobReward);
              break;
            case RewardedAdEvent.loaded:
              break;
            case RewardedAdEvent.earnedReward:
              final reward = e.values.first;
              onRewarded(true);
              Tools.logger.i('earned reward: $reward');
              break;
            default:
              break;
          }
        });
        break;
      default:
        break;
    }
  }

  showInter() async {
    switch (adNetwork) {
      case "fb":
        if (isInterLoaded)
          FacebookInterstitialAd.showInterstitialAd();
        else
          Tools.logger.e('Fb Inter Not Loaded');
        break;
      case "admob":
        if (interstitialAd.isLoaded)
          interstitialAd.show();
        else
          Tools.logger.e('Admob Inter Not Loaded');
        break;
      default:
        break;
    }

    if (isVersionUpToLOLLIPOP()) {
      if (!isInterLoaded /* && !interstitialAd.isLoaded*/) {
        if (!kDebugMode) {
          await UnityAds.showVideoAd(
            placementId: 'video',
            listener: (state, args) {
              if (state == UnityAdState.complete) {
                Tools.logger
                    .i('User watched a video. User should get a reward!');
              } else if (state == UnityAdState.skipped) {
                Tools.logger.i('User cancel video.');
              }
            },
          );
        } else {
          Tools.logger
              .d('Unity Ads (kDebugMode: $kDebugMode) = Blocking Unity ads');
        }
      }
    } else {
      Tools.logger
          .wtf('Unity Ads instead (SDK blocking) (isVersionUpToLOLLIPOP)');
    }
  }

  showRewardAd() async {
    switch (adNetwork) {
      case "fb":
        showInter();
        break;
      case "admob":
        if (rewardedAd.isLoaded) {
          rewardedAd.show();
        } else {
          showInter();
        }
        break;
      default:
        break;
    }

    if (isVersionUpToLOLLIPOP()) {
      if (!isInterLoaded && !interstitialAd.isLoaded) {
        Tools.logger.wtf(
            "Adsssssss: isInterLoaded: $isInterLoaded interstitialAd.isLoaded: ${interstitialAd.isLoaded}");
        if (!kDebugMode) {
          await UnityAds.showVideoAd(
            placementId: 'video',
            listener: (state, args) {
              if (state == UnityAdState.complete) {
                Tools.logger
                    .i('User watched a video. User should get a reward!');
              } else if (state == UnityAdState.skipped) {
                Tools.logger.i('User cancel video.');
              }
            },
          );
        } else {
          Tools.logger.wtf('Unity Ads (Debug blocking) (kDebugMode)');
        }
      }
    } else {
      Tools.logger
          .wtf('Unity Ads instead (SDK blocking) (isVersionUpToLOLLIPOP)');
    }
  }

  Widget getBannerAd() {
    switch (adNetwork) {
      case "fb":
        bannerAd = Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Palette.primary,
            border: Border(
              top: BorderSide(
                color: Palette.primary,
              ),
              bottom: BorderSide(
                color: Palette.primary,
              ),
            ),
          ),
          child: FacebookBannerAd(
            placementId: fbBanner,
            bannerSize: fb.BannerSize.STANDARD,
            listener: (result, value) {
              switch (result) {
                case BannerAdResult.ERROR:
                  Tools.logger.i("Fb Banner: Error: $value");
                  break;
                case BannerAdResult.LOADED:
                  Tools.logger.i("Fb Banner: Loaded: $value");
                  break;
                case BannerAdResult.CLICKED:
                  Tools.logger.i("Fb Banner: Clicked: $value");
                  break;
                case BannerAdResult.LOGGING_IMPRESSION:
                  Tools.logger.i("Fb Banner: Logging Impression: $value");
                  break;
              }
            },
          ),
        );
        break;
      case "admob":
        bannerAd = Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Palette.primary,
              ),
              bottom: BorderSide(
                color: Palette.primary,
              ),
            ),
          ),
          child: BannerAd(
            controller: controller,
            size: admob.BannerSize.ADAPTIVE,
          ),
        );
        controller.onEvent.listen((e) {
          final event = e.keys.first;
          switch (event) {
            case BannerAdEvent.loading:
              Tools.logger.i('Admob Banner: loading');
              break;
            case BannerAdEvent.loaded:
              Tools.logger.i('Admob Banner: loaded');
              break;
            case BannerAdEvent.loadFailed:
              final errorCode = e.values.first;
              Tools.logger.i('Admob Banner: loadFailed $errorCode');
              break;
            case BannerAdEvent.impression:
              Tools.logger.i('Admob Banner: ad rendered');
              break;
            default:
              break;
          }
        });
        break;
      case "unity":
        break;
      case "startapp":
        break;
      default:
        break;
    }

    return bannerAd;
  }

  Widget getNativeAd({double height = 300, double width}) {
    switch (adNetwork) {
      case 'fb':
        nativeAd = Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Palette.primary,
              width: 2.0,
            ),
          ),
          child: FacebookNativeAd(
            placementId: fbNative,
            adType: NativeAdType.NATIVE_AD,
            height: height,
            width: width ?? Tools.width * 0.9,
            backgroundColor: Colors.blue,
            titleColor: Colors.white,
            descriptionColor: Colors.white,
            buttonColor: Colors.deepPurple,
            buttonTitleColor: Colors.white,
            buttonBorderColor: Colors.white,
            keepAlive: true,
            //set true if you do not want adview to refresh on widget rebuild
            keepExpandedWhileLoading: false,
            // set false if you want to collapse the native ad view when the ad is loading
            expandAnimationDuraion: 300,
            //in milliseconds. Expands the adview with animation when ad is loaded
            listener: (result, value) {
              Tools.logger.i("Fb Native Ad: $result");
            },
          ),
        );
        break;
      case 'admob':
        nativeAd = NativeAd(
          height: height ?? 300.0,
          width: width ?? Tools.width * 0.9,
          body: AdTextView(style: TextStyle(color: Colors.black)),
          headline: AdTextView(style: TextStyle(color: Colors.black)),
          advertiser: AdTextView(style: TextStyle(color: Colors.black)),
          attribution: AdTextView(style: TextStyle(color: Colors.black)),
          price: AdTextView(style: TextStyle(color: Colors.black)),
          store: AdTextView(style: TextStyle(color: Colors.black)),
          buildLayout: adBannerLayoutBuilder,
          loading: Text('loading'),
          error: Text('error'),
        );
        break;
      case "unity":
        break;
      case "startapp":
        break;
      default:
        break;
    }
    return nativeAd;
  }
}