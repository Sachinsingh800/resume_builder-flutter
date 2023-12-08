import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/controller/cover_controller.dart';
import 'package:resume_builder/screen/onboarding/IntroScreen1.dart';
import 'package:resume_builder/screen/onboarding/onboarding_screen.dart';
import 'package:resume_builder/screen/resume_details_screen.dart';
import 'package:resume_builder/screen/test_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/controller/postResume.dart';
import 'screen/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      return HomePage();
    } else {
        return OnboardingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(GlobalController());
    Get.put(CoverController());
    Get.put(PostResume());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkLogin(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else {
            return Scaffold(body: const Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
