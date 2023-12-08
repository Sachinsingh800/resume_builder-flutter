import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/screen/UserInformation/UserEducation.dart';
import 'package:resume_builder/screen/UserInformation/UserPersonalnfo.dart';
import 'package:resume_builder/screen/UserInformation/UserSkills.dart';
import 'package:resume_builder/screen/UserInformation/UserWorkExperience.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/editprofileWidget.dart';
import 'Login.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  bool _isLoggedIn = false;

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  void getLoginDetails()async{
    final String? authToken = await loadToken();

    if (authToken == "") {
      setState(() {
        _isLoggedIn = false;
      });
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Login First",
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: "MontserratBold",
                            ),
                          ),
                          subtitle: Text(
                            "To get resume, please log in first.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratBold",
                            ),
                          ),
                        ),
                        Lottie.asset(
                          'assets/raw/login.json',
                          width: 200,
                          height: 300,
                          repeat: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 49.0, // Set the desired height
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF02AABD),
                                        Color(0xFF00CDAC),
                                      ], // Replace with your desired colors
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MontserratBold",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Login()));
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 49.0, // Set the desired height
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF02AABD),
                                        Color(0xFF00CDAC),
                                      ], // Replace with your desired colors
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MontserratBold",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }else{
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFEDFA),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6AC9CF), Color(0xFFF4FBFB)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(33),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
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
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(37, 0, 0, 0),
                      child: Text(
                        'Edit Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.03, 0.00),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 130, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.00, -0.00),
                      child: Material(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          width: 99,
                          height: 99,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/person.png',
                              ).image,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 32),
                      child: Text(
                        'Change Image',
                        style: TextStyle(
                          color: Color(0xFF009AA4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _isLoggedIn?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UserPersonalInfo(code: "edit", category: "null",))):null;
                      },
                      child: const EditProfileWidget(
                        url: "assets/icon/Driver license.png",
                        title: "Personal Information",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _isLoggedIn?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UserEducation(code: "edit",))):null;
                      },
                      child: const EditProfileWidget(
                        url: "assets/icon/Mortarboard.png",
                        title: "Education",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        _isLoggedIn?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UserWorkExperience(code: "edit",))):null;
                      },
                      child: const EditProfileWidget(
                        url: "assets/icon/Meeting.png",
                        title: "Work Experience",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    GestureDetector(
                      onTap: () {
                        _isLoggedIn?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UserSkills(code: "edit",))):null;
                      },
                      child: const EditProfileWidget(
                        url: "assets/icon/Skills.png",
                        title: "Skills",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
