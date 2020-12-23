import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/customTextField.dart';
import 'package:vitally/widgets/customTextField_2.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  AppConfig appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.bottomCenter,
        padding:
            EdgeInsets.symmetric(horizontal: appConfig.responsive.width(30)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              image,
              sizedBox(11),
              title,
              sizedBox(3),
              subTitle,
              sizedBox(39),
              emailTextField,
              sizedBox(26),
              passwordTextField,
              sizedBox(21),
              forgotPassword,
              sizedBox(44),
              signInButton,
              sizedBox(16),
              googleButton,
              sizedBox(20),
              dontHaveAnAccount,
              sizedBox(30),
            ],
          ),
        ),
      ),
    );
  }

  Widget get dontHaveAnAccount {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ",
            style: appConfig.appTextTheme.textStyle9),
        InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(appConfig.context, '/signup'),
            child:
                Text("Create Now", style: appConfig.appTextTheme.textStyle10)),
      ],
    );
  }

  Widget get signInButton {
    return Button(
      title: "Sign In",
      appConfig: appConfig,
      onTap: () async {},
      height: appConfig.responsive.height(52),
    );
  }

  Widget get googleButton {
    return Button(
      title: "Google",
      appConfig: appConfig,
      onTap: () async {},
      height: appConfig.responsive.height(52),
      color: Colors.blue,
    );
  }

  Widget get forgotPassword {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(appConfig.context, '/forgotPassword');
          },
          child: Text(
            "Forgot Password",
            style: appConfig.appTextTheme.textStyle10,
          ),
        ),
        sizedBox(0, 5),
      ],
    );
  }

  Widget get subTitle {
    return Center(
      child: Text("We missed you!", style: appConfig.appTextTheme.textStyle6),
    );
  }

  Widget get title {
    return Center(
      child: Text(
        "Welcome back!",
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

  Widget get passwordTextField {
    return CustomTextField2(
      title: "Password",
      textInputType: TextInputType.visiblePassword,
      validator: (value) {
        return value.length < 6 ? "minimum 6 characters" : null;
      },
      hintText: "•••••••••••••",
      appConfig: appConfig,
      textEditingController: passwordTextController,
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

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }
}
