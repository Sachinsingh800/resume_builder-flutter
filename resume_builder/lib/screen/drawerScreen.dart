import 'package:flutter/material.dart';
import 'package:resume_builder/screen/Login.dart';
import 'package:resume_builder/screen/all_resume_screen.dart';
import 'package:resume_builder/screen/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/editprofileWidget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: 404,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6AC9CF), Color(0xFFF4FBFB)],
                stops: [0.3, 1],
                begin: AlignmentDirectional(1, -1),
                end: AlignmentDirectional(-1, 1),
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/person.png',
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
                        child: Text(
                          'Robin',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: const EditProfileWidget(
                url: "assets/drawer/Group.png",
                title: "Profile",
              )),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AllResumeScreen()));
            },
            child: const EditProfileWidget(
              url: "assets/drawer/CV.png",
              title: "Your Resume",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const EditProfileWidget(
            url: "assets/drawer/Vector.png",
            title: "Invite Friends",
          ),
          const SizedBox(
            height: 20,
          ),
          const EditProfileWidget(
            url: "assets/drawer/Information button.png",
            title: "About Us",
          ),
          const SizedBox(
            height: 20,
          ),
          const EditProfileWidget(
            url: "assets/drawer/Operator.png",
            title: "Contact us",
          ),
          const SizedBox(
            height: 20,
          ),
          const EditProfileWidget(
            url: "assets/drawer/User protection.png",
            title: "Privacy Policy",
          ),
          const SizedBox(
            height: 20,
          ),
          const EditProfileWidget(
            url: "assets/drawer/Accept.png",
            title: "Terms of Services",
          ),
          const SizedBox(
            height: 20,
          ),
          const EditProfileWidget(
            url: "assets/drawer/Rating.png",
            title: "Rate the App",
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Login()));
            },
            child: const EditProfileWidget(
              url: "assets/drawer/Logout.png",
              title: "Logout",
            ),
          ),
        ],
      ),
    );
  }
}
