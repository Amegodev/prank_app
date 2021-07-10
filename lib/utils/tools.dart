import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:getwidget/getwidget.dart';
import 'package:logger/logger.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prank_app/constants.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:prank_app/utils/ads_helper.dart';
import 'package:prank_app/utils/ads.dart';
import 'package:http/http.dart' as http;

class Tools {
  static double height = 781.0909090909091;
  static double width = 392.72727272727275;
  static AndroidDeviceInfo androidInfo;
  static RemoteConfig remoteConfig;
  static FirebaseMessaging firebaseMessaging;

  static Future initAppSettings() async {
    await Firebase.initializeApp();
    await initAppInfo();
    await getDeviceInfo();
    await Ads.init();
    await getRemotConfigs();
    await initFireMessaging();
    await initOneSignal();
    cleanStatusBar();

    logger.i("""
    height      : $height
    width       : $width
    packageName : ${packageInfo.packageName}(${packageInfo.packageName.replaceAll('.', '_')})
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

  static Future<void> initOneSignal() async {
    String _debugLabelString = "";

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(Constants.oneSignalAppId);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      Tools.logger.i("Accepted permission: $accepted");
    });

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      // this.setState(() {
      _debugLabelString =
          "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      _debugLabelString =
          "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      _debugLabelString =
          "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
      Tools.logger.i("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      Tools.logger.i("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
      Tools.logger.i("EMAIL SUBSCRIPTION STATE CHANGED ${emailChanges.jsonRepresentation()}");
    });

    // Some examples of how to use In App Messaging public methods with OneSignal SDK
    oneSignalInAppMessagingTriggerExamples();

    // Some examples of how to use Outcome Events public methods with OneSignal SDK
    oneSignalOutcomeEventsExamples();
  }

  static oneSignalInAppMessagingTriggerExamples() async {
    /// Example addTrigger call for IAM
    /// This will add 1 trigger so if there are any IAM satisfying it, it
    /// will be shown to the user
    OneSignal.shared.addTrigger("trigger_1", "one");

    /// Example addTriggers call for IAM
    /// This will add 2 triggers so if there are any IAM satisfying these, they
    /// will be shown to the user
    Map<String, Object> triggers = new Map<String, Object>();
    triggers["trigger_2"] = "two";
    triggers["trigger_3"] = "three";
    OneSignal.shared.addTriggers(triggers);

    // Removes a trigger by its key so if any future IAM are pulled with
    // these triggers they will not be shown until the trigger is added back
    OneSignal.shared.removeTriggerForKey("trigger_2");

    // Get the value for a trigger by its key
    Object triggerValue = await OneSignal.shared.getTriggerValueForKey("trigger_3");
    Tools.logger.i("'trigger_3' key trigger value: " + triggerValue.toString());

    // Create a list and bulk remove triggers based on keys supplied
    List<String> keys = ["trigger_1", "trigger_3"];
    OneSignal.shared.removeTriggersForKeys(keys);

    // Toggle pausing (displaying or not) of IAMs
    OneSignal.shared.pauseInAppMessages(false);
  }

  static oneSignalOutcomeEventsExamples() async {
    // Await example for sending outcomes
    outcomeAwaitExample();

    // Send a normal outcome and get a reply with the name of the outcome
    OneSignal.shared.sendOutcome("normal_1");
    OneSignal.shared.sendOutcome("normal_2").then((outcomeEvent) {
      Tools.logger.i(outcomeEvent.jsonRepresentation());
    });

    // Send a unique outcome and get a reply with the name of the outcome
    OneSignal.shared.sendUniqueOutcome("unique_1");
    OneSignal.shared.sendUniqueOutcome("unique_2").then((outcomeEvent) {
      Tools.logger.i(outcomeEvent.jsonRepresentation());
    });

    // Send an outcome with a value and get a reply with the name of the outcome
    OneSignal.shared.sendOutcomeWithValue("value_1", 3.2);
    OneSignal.shared.sendOutcomeWithValue("value_2", 3.9).then((outcomeEvent) {
      Tools.logger.i(outcomeEvent.jsonRepresentation());
    });
  }

  static Future<void> outcomeAwaitExample() async {
    var outcomeEvent = await OneSignal.shared.sendOutcome("await_normal_1");
    Tools.logger.i(outcomeEvent.jsonRepresentation());
  }


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
    if (Constants.storeId != "") {
      url = 'https://play.google.com/store/apps/dev?id=' + Constants.storeId;
    } else {
      url = 'https://play.google.com/store/apps/developer?id=' +
          Constants.storeName.split(' ').join('+');
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchTrafficUrl() async {
    final url = Constants.trafficUrl;
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

  static getRemotConfigs() async {
    Constants.trafficText = await fetchRemoteConfig(
            '${packageInfo.packageName.replaceAll('.', '_')}_trafficText') ??
        Constants.trafficText;
    Constants.trafficUrl = await fetchRemoteConfig(
            '${packageInfo.packageName.replaceAll('.', '_')}_trafficUrl') ??
        Constants.trafficUrl;
  }

  static checkAppVersion(BuildContext context) async {
    try {
      String newVersion = await fetchRemoteConfig(
              '${packageInfo.packageName.replaceAll('.', '_')}_last_version') ??
          "1.0.0";

      // newVersion = newVersion ?? "1.0.0";
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
                        SizedBox(
                          width: 10.0,
                        ),
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
    ChromeSafariBrowser browser = MyChromeSafariBrowser(() => onClosed(),
        browserFallback: InAppBrowser());
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

    return items.sublist(start, end);
  }

/*static Future<String> getCountryName() async {
    Network n = new Network("http://ip-api.com/json");
    final locationSTR = (await n.getData());
    final locationx = jsonDecode(locationSTR);
    return locationx["country"];
  }*/
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  final VoidCallback onClosed1;

  MyChromeSafariBrowser(this.onClosed1, {browserFallback})
      : super(bFallback: browserFallback);

  @override
  void onOpened() {
    Tools.logger.i("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    Tools.logger.i("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    this.onClosed1();
  }
}

class Network {
  final String url;

  Network(this.url);

  Future<String> apiRequest(Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/x-www-form-urlencoded');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  Future<String> sendData(Map data) async {
    http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data));
    if (response.statusCode == 200)
      return (response.body);
    else
      return 'No Data';
  }

  Future<String> getData() async {
    http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});
    if (response.statusCode == 200)
      return (response.body);
    else
      return 'No Data';
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
