import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:resume_builder/resume%20template/firstResumeTemplate.dart';
import 'package:resume_builder/screen/Login.dart';
import 'package:resume_builder/screen/resume_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/get_all_resume.dart';
import 'UpdateResumeScreen/update_resume_activity.dart';

class AllResumeScreen extends StatefulWidget {
  const AllResumeScreen({super.key});

  @override
  State<AllResumeScreen> createState() => _AllResumeScreenState();
}

class _AllResumeScreenState extends State<AllResumeScreen> {
  final List<String> imagePaths = [
    'assets/homepage/resume1.png',
    'assets/homepage/resume2.png',
    'assets/homepage/resume3.jpeg',
    'assets/homepage/resume4.jpeg',
    'assets/homepage/resume5.jpeg',
    'assets/homepage/resume6.jpeg',
    'assets/homepage/resume7.jpeg',
    'assets/homepage/resume8.jpeg',
    'assets/homepage/resume9.jpeg',
    'assets/homepage/resume10.jpg',
    'assets/homepage/resume11.jpg',
    'assets/homepage/resume12.jpeg',
    'assets/homepage/resume13.jpg',
    'assets/homepage/resume14.jpeg',
    'assets/homepage/resume15.jpeg',
    'assets/homepage/resume16.jpg',
    'assets/homepage/resume17.jpeg',
    'assets/homepage/resume18.jpg',
    'assets/homepage/resume19.jpg',
    'assets/homepage/resume20.jpg',
    'assets/homepage/resume21.jpg',
    'assets/homepage/resume22.jpeg',
    'assets/homepage/resume23.jpeg',
    'assets/homepage/resume24.jpeg',
    'assets/homepage/resume25.jpeg',
    'assets/homepage/resume26.jpg',
    'assets/homepage/resume27.jpg',
    'assets/homepage/resume28.jpeg',
    'assets/homepage/resume29.jpeg',
    'assets/homepage/resume30.jpeg'
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

  List<GetAllResume> resumeList = [];

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Future<List<GetAllResume>> getAllResume() async {
    final Uri uri =
        Uri.parse("https://lizmyresume.onrender.com/user/resume/getAllResume/");

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

      resumeList = data.map((json) => GetAllResume.fromJson(json)).toList();
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
      return resumeList;
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
    } else if (tempId == "template10") {
      return imagePaths[10];
    } else if (tempId == "template11") {
      return imagePaths[11];
    } else if (tempId == "template12") {
      return imagePaths[12];
    } else if (tempId == "template13") {
      return imagePaths[13];
    } else if (tempId == "template14") {
      return imagePaths[14];
    } else if (tempId == "template15") {
      return imagePaths[15];
    } else if (tempId == "template16") {
      return imagePaths[16];
    } else if (tempId == "template17") {
      return imagePaths[17];
    } else if (tempId == "template18") {
      return imagePaths[18];
    } else if (tempId == "template19") {
      return imagePaths[19];
    } else if (tempId == "template20") {
      return imagePaths[20];
    } else if (tempId == "template21") {
      return imagePaths[21];
    } else if (tempId == "template22") {
      return imagePaths[22];
    } else if (tempId == "template23") {
      return imagePaths[23];
    } else if (tempId == "template24") {
      return imagePaths[24];
    } else if (tempId == "template25") {
      return imagePaths[25];
    } else if (tempId == "template26") {
      return imagePaths[26];
    } else if (tempId == "template27") {
      return imagePaths[27];
    } else if (tempId == "template28") {
      return imagePaths[28];
    } else if (tempId == "template29") {
      return imagePaths[29];
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
        title: Text("All Resume"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: FutureBuilder<List<GetAllResume>>(
          future: getAllResume(),
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
                    final resume = snapshot.data![index];
                    final assetPath = getAssetPath(resume.tempId!);
                    return ResumeItem(resume: resume, assetPath: assetPath);
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

class ResumeItem extends StatelessWidget {
  final GetAllResume resume;
  final String assetPath;

  ResumeItem({required this.resume, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateResumeScreen(
                      resumeId: resume.sId!,
                      tempId: resume.tempId!,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  assetPath,
                  fit: BoxFit.contain,
                  height: 140,
                ),
                Text(resume.name!),

                // Add more resume information here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
