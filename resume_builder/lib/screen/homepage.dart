import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:resume_builder/screen/coverTemplatePage.dart';
import 'package:resume_builder/screen/drawerScreen.dart';
import 'package:resume_builder/screen/edit_profile.dart';
import 'package:resume_builder/screen/resume_template_page.dart';
import 'package:resume_builder/screen/settings_screen.dart';
import 'package:resume_builder/screen/test_dashboard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    TestDashboard(),
    TestDashboard(),
    SettingsScreen()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
          statusBarColor: Color(0xFFDFEDFA), // Color of the status bar
          statusBarIconBrightness: Brightness.dark, // Brightness of system icons (e.g., network, battery)
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDFEDFA),
        body: _screens[_currentIndex],

        bottomNavigationBar: Container(
          child: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        child: Container(
          height: 62,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 36,
            selectedIconTheme: IconThemeData(
              size: 36, // Adjust the size as needed
              color: Color(0xFF6AC9CF), // Change the color for the selected icon
            ),
            unselectedIconTheme: const IconThemeData(
              size: 36, // Adjust the size as needed
            ),
            currentIndex: currentIndex,
            onTap: onTap,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/5.png",
                  width: 31, // Adjust the width as needed
                  height: 31, // Adjust the height as needed
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/6.png",
                  width: 30, // Adjust the width as needed
                  height: 30, // Adjust the height as needed
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/7.png",
                  width: 30, // Adjust the width as needed
                  height: 30, // Adjust the height as needed
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
