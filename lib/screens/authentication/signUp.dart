import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/customTextField.dart';
import 'package:vitally/widgets/customTextField_2.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        padding: EdgeInsets.only(
          left: appConfig.responsive.width(30),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              block1,
              privacyPolicy,
              block2,
            ],
          ),
        ),
      ),
    );
  }

  Widget get block2 {
    return Padding(
      padding: EdgeInsets.only(
        right: appConfig.responsive.width(30),
      ),
      child: Column(
        children: [
          sizedBox(16),
          signUpButton,
          sizedBox(16),
          googleButton,
          sizedBox(20),
          alreadyHaveAnAccount,
          sizedBox(30),
        ],
      ),
    );
  }

  Widget get alreadyHaveAnAccount {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already Have an Account? ",
            style: appConfig.appTextTheme.textStyle9),
        InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, '/signin'),
            child:
                Text("Login Here", style: appConfig.appTextTheme.textStyle10)),
      ],
    );
  }

  Widget get signUpButton {
    return Button(
      title: "Sign Up",
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

  Widget get block1 {
    return Padding(
      padding: EdgeInsets.only(
        right: appConfig.responsive.width(30),
      ),
      child: Column(children: [
        image,
        sizedBox(11),
        title,
        sizedBox(3),
        subTitle,
        sizedBox(39),
        emailTextField,
        sizedBox(26),
        passwordTextField,
        sizedBox(44),
      ]),
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

  Widget get privacyPolicy {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text("By Signing Up you agree to our ",
              style: appConfig.appTextTheme.textStyle9),
          Text("Terms and Conditions ",
              style: appConfig.appTextTheme.textStyle10),
          Text(" &", style: appConfig.appTextTheme.textStyle9)
        ]),
        sizedBox(3),
        Text("Privacy Policy", style: appConfig.appTextTheme.textStyle10)
      ],
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
      child:
          Text("Let's get started", style: appConfig.appTextTheme.textStyle6),
    );
  }

  Widget get title {
    return Center(
      child: Text(
        "Welcome to the club",
        style: appConfig.appTextTheme.textStyle5,
      ),
    );
  }

  Widget get image {
    return Center(
      child: Image.asset(
        "assets/images/Login/signUp.png",
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
