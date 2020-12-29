import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/utilities/enums.dart';
import 'package:vitally/widgets/bottomNavigationBarItem.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AppConfig appConfig;
  DashBoardScreen currentDashboardScreen;

  @override
  void initState() {
    currentDashboardScreen = DashBoardScreen.home;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return WillPopScope(
      onWillPop: () => null,
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        body: dashBoardScreen,
      ),
    );
  }

  Widget get dashBoardScreen {
    // do not change the order in dashBoardScreens list
    final List<Widget> dashBoardScreens = [
      Center(child: Text("Home")),
      Center(child: Text("Stats")),
      Center(child: Text("Health Logs")),
      Center(child: Text("Profile Screen")),
      // ProfileScreen()
    ];
    return dashBoardScreens[currentDashboardScreen.index];
  }

  Widget get bottomNavigationBar {
    return BottomNavigationBar(
        elevation: 10.0,
        backgroundColor: appConfig.appColors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentDashboardScreen.index,
        onTap: (index) {
          if (currentDashboardScreen.index != index)
            this.setState(() {
              currentDashboardScreen = DashBoardScreen.values.elementAt(index);
            });
        },
        items: [
          BottomNavBarItem(
            appConfig: appConfig,
            label: "Home",
            iconAddress: "assets/icons/Home.png",
          ).build(),
          BottomNavBarItem(
            appConfig: appConfig,
            label: "Stats",
            iconAddress: "assets/icons/Stats.png",
          ).build(),
          BottomNavBarItem(
            appConfig: appConfig,
            label: "Logs",
            iconAddress: "assets/icons/Clipboard.png",
          ).build(),
          BottomNavBarItem(
            appConfig: appConfig,
            label: "Profile",
            iconAddress: "assets/icons/Profile.png",
          ).build(),
        ]);
  }
}
