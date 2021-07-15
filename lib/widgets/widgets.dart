import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prank_app/utils/navigator.dart';
import 'package:prank_app/constants.dart';
import 'package:prank_app/utils/theme.dart';
import 'package:prank_app/utils/tools.dart';
import 'package:prank_app/widgets/dialogs.dart';
import 'package:tinycolor/tinycolor.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget title;
  final Widget bannerAd;
  final Widget trailing;
  final Widget leading;
  final Color bgColor;
  final VoidCallback onClicked;

  const CustomAppBar(
      {Key key,
      this.scaffoldKey,
      this.bannerAd,
      this.title,
      this.onClicked,
      this.leading,
      this.trailing,
      this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: this.bgColor ?? Palette.primary),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            this.bannerAd != null
                ? SizedBox(height: 50.0, child: this.bannerAd)
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  this.leading != null
                      ? this.leading
                      : IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              'assets/icons/burger_menu.svg',
                              color: Palette.white,
                            ),
                          ),
                          onPressed: () =>
                              scaffoldKey.currentState.openDrawer(),
                        ),
                  Expanded(
                    child: this.title,
                  ),
                  this.trailing != null
                      ? this.trailing
                      : IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.star,
                              color: Palette.white,
                            ),
                          ),
                          onPressed: () async {
                            int count = await showDialog(
                                context: context,
                                builder: (_) => RatingDialog());
                            if (count != null && count <= 3) this.onClicked();
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer {

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Palette.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: -MediaQuery.of(context).size.width * 0.9,
                    left: -MediaQuery.of(context).size.width * 0.4,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 1.5,
                      width: MediaQuery.of(context).size.width * 1.5,
                      decoration: BoxDecoration(
                        color: Palette.black.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -MediaQuery.of(context).size.width * 0.9,
                    left: -MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 1.5,
                      width: MediaQuery.of(context).size.width * 1.5,
                      decoration: BoxDecoration(
                        color: Palette.primary.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image.asset(
                      'assets/icon.png',
                      width: 114.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Tools.packageInfo == null
                      ? SizedBox()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20.0, top: 20.0),
                            child: Text(
                              Tools.packageInfo.appName,
                              style: MyTextStyles.bigTitleBold
                                  .apply(color: Palette.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                    child: MaterialButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0),
                      ),
                      onPressed: () {
                        MyNavigator.goUserNamePage(context);
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/home.svg',
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            Constants.home,
                            style: MyTextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0, right: 8.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0),
                      ),
                      onPressed: () {
                        Tools.launchURLRate();
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/rate.svg',
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            Constants.rate,
                            style: MyTextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0, right: 8.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0),
                      ),
                      onPressed: () {
                        MyNavigator.moreApps(context);
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/more_apps.svg',
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            Constants.more,
                            style: MyTextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0, right: 8.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        MyNavigator.goPrivacy(context);
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/privacy_policy.svg',
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            Constants.privacy,
                            style: MyTextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0, right: 8.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        /*int count = */
                        await showDialog(
                            context: context, builder: (_) => RatingDialog());
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/about.svg',
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            Constants.about,
                            style: MyTextStyles.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Version ' + Tools.packageInfo.version,
                style: MyTextStyles.subTitle.apply(fontSizeFactor: 0.8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Build number ' + Tools.packageInfo.buildNumber,
                style: MyTextStyles.subTitle.apply(fontSizeFactor: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final Text title;
  final String svgIcon;
  final Color bgColor;
  final Color textColor;
  final Function() onClicked;

  const MainButton(
      {Key key,
      this.title,
      this.svgIcon,
      this.onClicked,
      this.bgColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: this.bgColor == null ? Palette.primary : this.bgColor,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Palette.black),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: EdgeInsets.all(20.0),
        onPressed: this.onClicked,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: this.title,
            ),
            SvgPicture.asset(
              this.svgIcon,
              width: 30.0,
              color: this.textColor == null ? Colors.black : this.textColor,
            )
          ],
        ),
      ),
    );
  }
}

class ButtonFilled extends StatelessWidget {
  final Text title;
  final Color bgColor;
  final Function() onClicked;

  const ButtonFilled({Key key, this.title, this.onClicked, this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.bgColor == null ? Palette.primary : this.bgColor,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: EdgeInsets.all(16.0),
        onPressed: this.onClicked,
        child: this.title,
      ),
    );
  }
}

class ButtonOutlined extends StatelessWidget {
  final Text title;
  final Color borderColor;
  final Function() onClicked;

  const ButtonOutlined({Key key, this.title, this.onClicked, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color:
                this.borderColor == null ? Palette.primary : this.borderColor,
            width: 2.0,
          )),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: EdgeInsets.all(14.0),
        onPressed: this.onClicked,
        child: this.title,
      ),
    );
  }
}

Container cardSide({int points, Color color, bool front}) {
  return Container(
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3.0,
            offset: Offset(0.0, 5.0),
          ),
        ]),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color == null ? Colors.black : color,
          width: 2.0,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/card_bg.svg',
            height: 150,
            color: color == null ? Colors.black : color,
          ),
          front
              ? BorderedText(
                  strokeWidth: 5.0,
                  strokeColor: Colors.white,
                  child: Text(
                    points.toString(),
                    style: TextStyle(
                      fontFamily: 'SuezOne',
                      fontSize: 25.0,
                      color: color == null
                          ? Colors.black
                          : TinyColor(color).darken().color,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}

Transform cardFlip(
    {int points,
    Color color,
    Animation animation,
    AnimationStatus animationStatus,
    AnimationController animationController,
    VoidCallback onClicked}) {
  return Transform(
    alignment: FractionalOffset.center,
    transform: Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateY(3.14 * animation.value),
    child: GestureDetector(
      onTap: () {
        if (animationStatus == AnimationStatus.dismissed) {
          animationController.forward();
          onClicked();
        }
        /*else {
          animationController.reverse();
        }*/
      },
      child: animation.value > 0.5
          ? cardSide(
              color: color != null ? color : Colors.black,
              front: false,
            )
          : cardSide(
              color: color != null ? color : Colors.black,
              front: true,
              points: points,
            ),
    ),
  );
}
