import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:resume_builder/coverLetter/10CoverLetter.dart';
import 'package:resume_builder/coverLetter/2coverLetter.dart';
import 'package:resume_builder/coverLetter/5coverLetter.dart';
import 'package:resume_builder/coverLetter/7CoverLetter.dart';
import 'package:resume_builder/coverLetter/8CoverLetter.dart';
import 'package:resume_builder/resume%20template/firstResumeTemplate.dart';
import 'package:resume_builder/screen/Login.dart';
import 'package:resume_builder/screen/resume_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../coverLetter/1coverLetter.dart';
import '../coverLetter/3coverLetter.dart';
import '../coverLetter/4coverLetter.dart';
import '../coverLetter/6Coverletter.dart';
import '../coverLetter/9CoverLetter.dart';
import '../models/get_all_cover.dart';

class AllCoverScreen extends StatefulWidget {
  const AllCoverScreen({super.key});

  @override
  State<AllCoverScreen> createState() => _AllCoverScreenState();
}

class _AllCoverScreenState extends State<AllCoverScreen> {

  final List<String> imagePaths = [
    'assets/homepage/cover1.jpg',
    'assets/homepage/cover2.jpg',
    'assets/homepage/cover3.jpg',
    'assets/homepage/cover4.jpg',
    'assets/homepage/cover5.jpg',
    'assets/homepage/cover6.png',
    'assets/homepage/cover7.png',
    'assets/homepage/cover8.png',
    'assets/homepage/cover9.png',
    'assets/homepage/cover10.png',
  ];

  Widget buildImage(String assetPath, int index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.contain,
        ),
      ));

  List<GetAllCover> coverList = [];

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Future<List<GetAllCover>> getAllCover() async {
    final Uri uri =
    Uri.parse("https://lizmyresume.onrender.com/user/coverletter/getYourCoverLetter");

    final String? authToken = await loadToken();

    print("auth token$authToken");

    if (authToken == "") {
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

      return []; // Return an empty list or handle the case accordingly.
    }

    final Map<String, String> headers = {'x-auth-token': '$authToken'};

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> data =
      responseData['data']; // Assuming 'data' contains the list

        coverList = data.map((json) => GetAllCover.fromJson(json)).toList();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${authToken}"),
        ),
      );
      return coverList;
    } else {
      // Handle the error if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed"),
        ),
      );
      throw Exception('Failed to load data');
    }
  }

  String getAssetPath(String tempId) {
    if (tempId == "template0") {
      return imagePaths[0];
    } else if (tempId == "template1") {
      return imagePaths[1];
    } else if (tempId == "template2") {
      return imagePaths[2];
    } else if (tempId == "template3") {
      return imagePaths[3];
    } else if (tempId == "template4") {
      return imagePaths[4];
    } else if (tempId == "template5") {
      return imagePaths[5];
    } else if (tempId == "template6") {
      return imagePaths[6];
    } else if (tempId == "template7") {
      return imagePaths[7];
    } else if (tempId == "template8") {
      return imagePaths[8];
    } else if (tempId == "template9") {
      return imagePaths[9];
    }
    // Provide a default value in case of no matches
    return imagePaths[0]; // Default to the first image if no match is found.
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
          // Color of the status bar
          statusBarIconBrightness: Brightness.dark,
          // Brightness of system icons (e.g., network, battery)
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Cover Letter"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: FutureBuilder<List<GetAllCover>>(
                future: getAllCover(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(strokeWidth: 2));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Set the cross-axis count to 2
                      ),
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final cover = snapshot.data![index];
                        final assetPath = getAssetPath(cover.tempID!);
                        return CoverItem(cover: cover, assetPath: assetPath,);
                      },
                    );
                  }
                },
              ))
        ],
      ),
    );
  }
}

class CoverItem extends StatelessWidget {
  final GetAllCover cover;
  final String assetPath;

  CoverItem({required this.cover, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cover.tempID == "template0") {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => FirstCoverLetter(code: "update", cover: cover,)));
        }else if(cover.tempID == "template1"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SecondCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template2"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ThirdCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template3"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => FourthCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template4"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => FifthCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template5"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SixthCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template6"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SeventhCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template7"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => EighthCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template8"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NinthCoverLetter(code: "update",cover: cover,)));
        }else if(cover.tempID == "template9"){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => TenthCoverLetter(code: "update",cover: cover,)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                  assetPath,
                fit: BoxFit.contain,
                height: 140,
              ),
              Text(cover.signature!),
              // Add more resume information here
            ],
          ),
        ),
      ),
    );
  }
}
