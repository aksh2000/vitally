import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/onboardingPage.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  AppConfig appConfig;
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      backgroundColor: appConfig.appColors.green,
      body: SafeArea(
        child: Container(
          height: appConfig.responsive.heightBasedOnPercentage(100),
          width: appConfig.responsive.widthBasedOnPercentage(100),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: appConfig.responsive.width(38),
            right: appConfig.responsive.width(38),
            bottom: appConfig.responsive.height(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              pages,
              sizedBox(25),
              pageIndicator,
              sizedBox(60),
              getStartedButton(context),
              sizedBox(13),
              alreadyHaveAnAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget get pages {
    return Container(
      height: appConfig.responsive.height(398),
      width: appConfig.responsive.width(287),
      alignment: Alignment.center,
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: [
          OnboardingPage(
            imageFilePath: "assets/images/onBoarding/1.png",
            title: "Track your calories",
            description:
                "View Your health data, weight stats, fat loss progress and daily calories in one glance",
            appConfig: appConfig,
          ),
          OnboardingPage(
            imageFilePath: "assets/images/onBoarding/2.png",
            title: "Reach your goals",
            description: "Set your goals and track them from dashboard",
            appConfig: appConfig,
          ),
          OnboardingPage(
            imageFilePath: "assets/images/onBoarding/3.png",
            title: "Get into Shape",
            description: "Rediscover Yourself with Vitally",
            appConfig: appConfig,
          ),
        ],
      ),
    );
  }

  Widget get pageIndicator {
    return Container(
      child: SmoothPageIndicator(
        controller: pageController,
        count: 3,
        effect: WormEffect(
          dotColor: appConfig.appColors.white,
          activeDotColor: appConfig.appColors.blue,
          dotHeight: appConfig.responsive.height(13),
          dotWidth: appConfig.responsive.width(13),
        ),
      ),
    );
  }

  Widget getStartedButton(BuildContext context) {
    return Button(
      title: "Create Account",
      onTap: () {
        // pageController.dispose();
        Navigator.pushReplacementNamed(context, '/signup');
      },
      appConfig: appConfig,
    );
  }

  Widget alreadyHaveAnAccount(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/signin');
        },
        child: Text("Already have an account? Login",
            style: appConfig.appTextTheme.textStyle1));
  }

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }
}
