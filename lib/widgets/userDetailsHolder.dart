import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class UserDetailsHolder extends StatelessWidget {
  final String title;
  final String value;
  final String units;
  final AppConfig appConfig;
  UserDetailsHolder(
      {@required this.title,
      @required this.value,
      @required this.units,
      @required this.appConfig});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: appConfig.appTextTheme.textStyle33),
          SizedBox(height: appConfig.responsive.height(2)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: appConfig.appTextTheme.textStyle34),
              SizedBox(width: appConfig.responsive.width(2)),
              Text(units, style: appConfig.appTextTheme.textStyle35),
            ],
          ),
        ],
      ),
    );
  }
}
