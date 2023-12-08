import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/screen/personal_info_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../change_password_screen.dart';
import 'Login.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String name = "";
  String url = "";

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    final String? authToken = await loadToken();

    final headers = <String, String>{};
    if (authToken != null) {
      headers['x-auth-token'] =
      '$authToken';
    }

    if (authToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No token"),
        ),
      );
    }

    final response = await http.get(
      Uri.parse(
          'https://lizmyresume.onrender.com/user/auth/profile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void getLoginDetails() async {
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
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) => Login()));
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
    } else {
      setState(() {
        _isLoggedIn = true;
      });
      fetchUserData().then((data) {
        // Update the text fields with data from the API response
        setState(() {
          name = data['data']['name'] ?? 'no name';
          url = data['data']['url'] ?? '';
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch data from API ${error.toString()}"),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLoginDetails();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFEDFA),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                        'Settings',
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
                    url == "" ?
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
                              image: Image
                                  .asset(
                                'assets/images/person.png',
                              )
                                  .image,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ) :
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
                              image: Image
                                  .network(
                                url,
                              )
                                  .image,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(name, style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,

                      ),),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    GestureDetector(
                        onTap: () {
                          _isLoggedIn ?
                          Navigator.push(context, MaterialPageRoute(builder: (
                              _) => PersonalInfoScreen())) : null;
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.person_pin,
                              color: Colors.black,),
                            title: Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)
                          =>
                              ChangePasswordScreen()
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.lock_open,
                              color: Colors.black,),
                            title: Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                          _isLoggedIn ?
                          logout() : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Login First"),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.logout, color: Colors.black,),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
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
