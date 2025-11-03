import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'screens/dashboard_screen.dart';
import 'screens/eye_care_screen.dart';
import 'screens/screen_time_screen.dart';
import 'screens/settings_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    EyeCareScreen(),
    ScreenTimeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFFFFFFF),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFFFFFFFF),
        //statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          // gradient: LinearGradient(
          //   colors: [Colors.white, Colors.grey.shade200],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1), // soft shadow
              blurRadius: 20,
              offset: const Offset(0, 5), // below the bar
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                height: 30,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey, // 👈 here!
                  BlendMode.srcIn,
                ),
              ),
              title: Text("Home"),
              selectedColor: Theme.of(context).primaryColor,
            ),
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/eye.svg",
                height: 30,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey, // 👈 here!
                  BlendMode.srcIn,
                ),
              ),
              title: Text("EyeCare"),
              selectedColor: Theme.of(context).primaryColor,
            ),
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/bar-chart.svg",
                height: 30,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey, // 👈 here!
                  BlendMode.srcIn,
                ),
              ),
              title: Text("Usage"),
              selectedColor: Theme.of(context).primaryColor,
            ),
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/icons/setting.svg",
                height: 30,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 3
                      ? Theme.of(context).primaryColor
                      : Colors.grey, // 👈 here!
                  BlendMode.srcIn,
                ),
              ),
              title: Text("Settings"),
              selectedColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
