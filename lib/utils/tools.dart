import 'dart:math';


import 'package:getwidget/getwidget.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';

class Tools {
  static double height = 781.0909090909091;
  static double width = 392.72727272727275;
  static AndroidDeviceInfo androidInfo;
  static RemoteConfig remoteConfig;
  static FirebaseMessaging firebaseMessaging;


  static initAppSettings() async {
    await Firebase.initializeApp();
    await initAppInfo();
    await getDeviceInfo();
    await Ads.init();
    await initFireMessaging();
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
      logger.i('fetched config: $body');
      return body;
    } catch (e) {
      logger.e(e.toString());
      return '';
    }
  }
  static checkAppVersion(BuildContext context) async {
    try {
      String newVersion = await fetchRemoteConfig(
          '${packageInfo.packageName.replaceAll('.', '_')}_last_version');

      newVersion = newVersion.isNotEmpty ? newVersion : "1.0.0";
      double currentVersion =
      double.parse(newVersion.trim().replaceAll(".", ""));
      double installedVersion =
      double.parse(packageInfo.version.trim().replaceAll(".", ""));

      logger.i(
          'Current version: $currentVersion \nInstalled version: $installedVersion');

      if (installedVersion < currentVersion) {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: Scaffold(
              body: Center(
                child: GFFloatingWidget(
                  verticalPosition: Tools.height * 0.3,
                  showBlurness: true,
                  child: GFAlert(
                    title: 'Update available 🎉',
                    content:
                    'Version $newVersion is available to download. By downloading the latest version you will get the latest features, improvements and bug fixes.',
                    type: GFAlertType.rounded,
                    bottombar: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  new BorderRadius.circular(100.0),
                                  color: Colors.grey),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'later',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(100.0),
                                gradient: RadialGradient(
                                  colors: [Colors.amber, Colors.amber[200]],
                                  center: Alignment.bottomLeft,
                                  radius: 2.0,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Tools.launchURLRate();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      logger.e(e.toString());
    }

  }


  static initFireMessaging() async {
    firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Tools.logger.i("onMessage: $message");
        if (message['data']['cpa_offer'] != null &&
            message['data']['cpa_offer'] != '') {
          try {
            // Tools.showCpaDialog(context, message);
          } catch (e) {
            Tools.logger.e("error: $e");
          }
        } else
          // Tools.showItemDialog(context, message);
          Tools.logger.wtf("Somthing");
      },
      onResume: (Map<String, dynamic> message) async {
        Tools.logger.wtf("onResume: $message");
        if (message['data']['cpa_offer'] != null &&
            message['data']['cpa_offer'] != '') {
          try {
            // Tools.showCpaDialog(context, message);
          } catch (e) {
            Tools.logger.e("error: $e");
          }
        } else
          // Tools.showItemDialog(context, message);
          Tools.logger.wtf("onResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        Tools.logger.wtf("From Tools================> onLaunch: $message");
//        MyNavigator.goNotifFetch(context: context, imageUrl: message['data']['imageUrl']);
        if (message['data']['cpa_offer'] != null &&
            message['data']['cpa_offer'] != '') {
          try {
            // Tools.showCpaDialog(context, message);
          } catch (e) {
            Tools.logger.e("error: $e");
          }
        } else
          // Tools.showItemDialog(context, message);
          Tools.logger.wtf("Somthing");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
    );
    String token = await firebaseMessaging.getToken();
    Tools.logger.i('Messaging Token : $token');
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


Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  Tools.logger.wtf(
      '============================= catched handler ${message['data']['imageUrl']}');
  if (message.containsKey('data')) {
// Handle data message
    final dynamic data = message['data'];
    Tools.logger
        .wtf('==================> MessageHolder (data) ' + data.toString());
  }

  if (message.containsKey('notification')) {
// Handle notification message
    final dynamic notification = message['notification'];
    Tools.logger.wtf('==================> MessageHolder (notification) ' +
        notification.toString());
  }
// Or do other work.


  return await Future.value(message);
}
