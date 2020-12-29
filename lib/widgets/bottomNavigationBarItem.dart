import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class BottomNavBarItem {
  final String iconAddress;
  final String label;
  final AppConfig appConfig;

  BottomNavBarItem(
      {@required this.iconAddress,
      @required this.label,
      @required this.appConfig});

  BottomNavigationBarItem build() {
    return BottomNavigationBarItem(
        icon: BottomNavBarIcon(
          appConfig: this.appConfig,
          iconAddress: iconAddress,
        ),
        label: this.label,
        activeIcon: BottomNavBarActiveIcon(
          appConfig: appConfig,
          label: this.label,
        ));
  }
}

class BottomNavBarIcon extends StatelessWidget {
  final String iconAddress;
  final AppConfig appConfig;

  BottomNavBarIcon({@required this.iconAddress, @required this.appConfig});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: appConfig.responsive.height(27),
        width: appConfig.responsive.width(28),
        alignment: Alignment.center,
        child: Image.asset(iconAddress));
  }
}

class BottomNavBarActiveIcon extends StatelessWidget {
  final AppConfig appConfig;
  final String label;
  BottomNavBarActiveIcon({@required this.appConfig, @required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Text(label, style: appConfig.appTextTheme.textStyle27));
  }
}
