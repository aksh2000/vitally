import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class CustomTextField3 extends StatelessWidget {
  final TextEditingController textEditingController;
  final AppConfig appConfig;
  final String title;
  final String hintText;
  final Function validator;
  final TextInputType textInputType;
  final bool isDense;
  final String suffixUnits;
  final bool enabled;
  final Color textColor;

  CustomTextField3(
      {@required this.textEditingController,
      @required this.appConfig,
      @required this.textInputType,
      this.enabled,
      @required this.title,
      @required this.suffixUnits,
      this.textColor,
      this.isDense,
      this.hintText,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: appConfig.appTextTheme.textStyle7,
          ),
          TextFormField(
            controller: this.textEditingController,
            keyboardType: this.textInputType,
            cursorColor: appConfig.appColors.green,
            enabled: enabled ?? true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: this.validator ??
                (value) {
                  return null;
                },
            style: TextStyle(
                fontFamily: "Roboto",
                color: this.textColor ?? appConfig.appColors.black,
                fontSize: appConfig.responsive.height(15)),
            decoration: InputDecoration(
                hintText: this.hintText ?? "",
                hintStyle: appConfig.appTextTheme.textStyle8,
                suffix:
                    suffix("$suffixUnits", suffixUnits.length > 2 ? 33 : 24),
                isDense: this.isDense ?? false),
          )
        ],
      ),
    );
  }

  Widget suffix(String units, double _width) {
    return Container(
      height: appConfig.responsive.height(24),
      width: appConfig.responsive.width(_width) ?? 32,
      alignment: Alignment.center,
      child: Text(units, style: appConfig.appTextTheme.textStyle12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: appConfig.appColors.green, width: 1)),
    );
  }
}
