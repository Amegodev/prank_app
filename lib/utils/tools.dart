import 'dart:math';


import 'package:logger/logger.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:prank_app/utils/strings.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prank_app/utils/ads_helper.dart';

class Tools {
  static double height = 781.0909090909091;
  static double width = 392.72727272727275;
  static AndroidDeviceInfo androidInfo;
  static RemoteConfig remoteConfig;


  static Future initAppSettings() async {
    await Firebase.initializeApp();
    logger.i("await Firebase.initializeApp();");
    await initAppInfo();
    logger.i("await initAppInfo();");
    await getDeviceInfo();
    logger.i("await getDeviceInfo();");
    await Ads.init();
    logger.i("await Ads.init();");
    cleanStatusBar();

    logger.i("""
    height      : $height
    width       : $width
    packageName : ${packageInfo.packageName}(${packageInfo.packageName.replaceAll('.','_')})
    appName     : ${packageInfo.appName}
    buildNumber : ${packageInfo.buildNumber}
    version     : ${packageInfo.version}""");
  }

  static Future<void> initAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
  }

  static Future<void> getDeviceInfo() async {
    androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    Tools.logger.i(
        'Android: $release, SDK: $sdkInt, manufacturer: $manufacturer ,model: $model');
  }

  static cleanStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  static PackageInfo packageInfo = PackageInfo(
    appName: ' ',
    packageName: ' ',
    version: ' ',
    buildNumber: ' ',
  );

  static Future<void> getAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
  }
  static var logger = Logger(
    printer: PrettyPrinter(methodCount: 1, colors: false, prefix: true),
  );

  static launchURLRate() async {
    var url = 'https://play.google.com/store/apps/details?id=' +
        Tools.packageInfo.packageName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchURLMore() async {
    var url;
    if (Strings.storeId != "") {
      url = 'https://play.google.com/store/apps/dev?id=' + Strings.storeId;
    } else {
      url = 'https://play.google.com/store/apps/developer?id=' +
          Strings.storeName.split(' ').join('+');
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<String> fetchRemoteConfig(String key) async {
    try {
      remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      String body = remoteConfig.getString(key);
      logger.i('fetched config: ${body.isEmpty ? null : body}');
      return body.isEmpty ? null : body;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }


  static openInInternalBrowser({String link, VoidCallback onClosed}) async {
    ChromeSafariBrowser browser = MyChromeSafariBrowser(() => onClosed(),browserFallback: InAppBrowser());
    await browser.open(
      url: link,
      options: ChromeSafariBrowserClassOptions(
        android: AndroidChromeCustomTabsOptions(
            addDefaultShareMenuItem: false, keepAliveEnabled: true),
        ios: IOSSafariOptions(
            dismissButtonStyle: IOSSafariDismissButtonStyle.CLOSE,
            presentationStyle: IOSUIModalPresentationStyle.OVER_FULL_SCREEN),
      ),
    );
  }

  static List shuffle(List items, int start, int end) {
    var random = new Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items.sublist(start,end);
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  final VoidCallback onClosed1;

  MyChromeSafariBrowser(this.onClosed1, {browserFallback}) : super(bFallback: browserFallback);

  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    this.onClosed1();
  }
}
