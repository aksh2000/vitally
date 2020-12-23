import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/customTextField.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  AppConfig appConfig;
  final TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: appConfig.appColors.white,
      ),
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: appConfig.responsive.width(30)),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            sizedBox(11),
            title,
            sizedBox(3),
            subTitle,
            sizedBox(39),
            emailTextField,
            sizedBox(26),
            sendResetLinkButton,
            sizedBox(30),
          ],
        ),
      ),
    );
  }

  Widget get sendResetLinkButton {
    return Button(
      title: "Send Reset Link",
      appConfig: appConfig,
      color: appConfig.appColors.green,
      onTap: () async {
        await appConfig.businessLogic
            .forgotPassword(email: emailTextController.text);
      },
      height: appConfig.responsive.height(52),
    );
  }

  Widget get emailTextField {
    return CustomTextField1(
      title: "Email",
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        return !EmailValidator.validate(emailTextController.text)
            ? "Invalid Email"
            : null;
      },
      hintText: "qwerty@email.com",
      appConfig: appConfig,
      textEditingController: emailTextController,
    );
  }

  Widget get subTitle {
    return Center(
      child: Text("Enter Your Registered Email Address",
          style: appConfig.appTextTheme.textStyle6),
    );
  }

  Widget get title {
    return Center(
      child: Text(
        "Forgot Password?",
        style: appConfig.appTextTheme.textStyle5,
      ),
    );
  }

  Widget get image {
    return Center(
      child: Image.asset(
        "assets/images/Login/login.png",
        height: appConfig.responsive.height(142),
        width: appConfig.responsive.width(168),
      ),
    );
  }

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }
}
