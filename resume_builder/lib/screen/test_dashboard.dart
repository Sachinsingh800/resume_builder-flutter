import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/pdf_viewer_screen.dart';
import 'package:resume_builder/screen/all_covers_screen.dart';
import 'package:resume_builder/screen/all_resume_screen.dart';
import 'package:resume_builder/screen/coverTemplatePage.dart';
import 'package:resume_builder/screen/edit_profile.dart';
import 'package:http/http.dart' as http;
import 'package:resume_builder/screen/resume_template_page.dart';
import 'package:resume_builder/screen/terms_condition_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/postResume.dart';

class TestDashboard extends StatefulWidget {
  const TestDashboard({super.key});

  @override
  State<TestDashboard> createState() => _TestDashboardState();
}

class _TestDashboardState extends State<TestDashboard> {
  bool _isLoading = false;
  String name = "Loading";
  String url = "";

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    setState(() {
      // _isLoading = true;
    });
    final String? authToken = await loadToken();

    final headers = <String, String>{};
    if (authToken != null) {
      headers['x-auth-token'] = '$authToken';
    }

    if (authToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No token"),
        ),
      );
    }

    final response = await http.get(
      Uri.parse('https://lizmyresume.onrender.com/user/auth/profile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      setState(() {
        // _isLoading = false;
      });
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData().then((data) {
      // Update the text fields with data from the API response
      setState(() {
        String fullName = data['data']['name'] ?? 'No name';
        // url = data['data']['profileImg']['url'] ?? '';
        List<String> nameParts = fullName.split(' ');
        name = nameParts.isNotEmpty ? nameParts[0] : '';
        String lastName =
            nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
        if (data['data']['profileImg'] != null &&
            data['data']['profileImg']['url'] != null) {
          url = data['data']['profileImg']['url'];
        } else {
          // Handle the case where the URL is not available
          url = '';
        }
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch data from API ${error.toString()}"),
        ),
      );
      print(error.toString());
    });
  }

  Future<void> _saveAndOpenPdf(String pdfBytes) async {
    Directory? directory;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // if platform is android
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          print("No download directory");
          directory = await getExternalStorageDirectory();
          String tempPath = directory!.path;
          File file = File('$tempPath/example.pdf');
          await file.writeAsBytes(pdfBytes.codeUnits, flush: true);
          final String filePath = file.absolute.path;
          final Uri uri = Uri.file(filePath);
        } else {
          print("Download directory exists");
          String tempPath = directory.path;
          File file = File('$tempPath/$timestamp.pdf');
          await file.writeAsBytes(pdfBytes.codeUnits, flush: true);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => PDFViewerScreen(file: file,)));
        }
      }
    } catch (error) {
      print('Error saving and opening PDF: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving and opening PDF: $error'),
        ),
      );
      // Handle the error (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFDFEDFA),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome\nHome",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 160),
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditProfile()));
                          },
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.shade200,
                                    // Yellow shadow color
                                    blurRadius: 12,
                                    spreadRadius: 12,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                color: Colors.yellow.shade100,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  topRight: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(4.0).copyWith(bottom: 0),
                              child: url == ""
                                  ? Image.asset("assets/person.png")
                                  : Image.network(url),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 36,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllResumeScreen()));
                        },
                        child: CategoryItem(
                            path: "assets/abcd.png", title: "Your\nResume"),
                      ),
                      SizedBox(
                        width: 36,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllCoverScreen()));
                        },
                        child: CategoryItem(
                            path: "assets/abcd.png",
                            title: "Your\nCover Letter"),
                      ),
                      SizedBox(
                        width: 36,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CategoryItem(
                            path: "assets/abcd.png", title: "Your\nCV"),
                      ),
                      SizedBox(
                        width: 36,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => TermsConditionScreen()));
                        },
                        child: CategoryItem(
                            path: "assets/9.png", title: "Terms &\nServices"),
                      ),
                      SizedBox(
                        width: 36,
                      ),
                      CategoryItem(
                          path: "assets/10.png", title: "Privacy\nPolicy"),
                      SizedBox(
                        width: 36,
                      ),
                      CategoryItem(path: "assets/11.png", title: "About Us"),
                      SizedBox(
                        width: 36,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResumeTemplate()));
                      },
                      child: ResumeItem(
                          path: "assets/1.png",
                          title: "Resume",
                          color: 0xffc6ecfa,
                          addPath: "assets/12.png")),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CoverTemplate()));
                    },
                    child: ResumeItem(
                        path: "assets/2.png",
                        title: "Cover Letter",
                        color: 0xffc6cdfa,
                        addPath: "assets/13.png"),
                  ),
                ],
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResumeItem(
                      path: "assets/3.png",
                      title: "CV",
                      color: 0xffc1dbfd,
                      addPath: "assets/14.png"),
                  ResumeItem(
                      path: "assets/4.png",
                      title: "Blog",
                      color: 0xffc6ecfa,
                      addPath: "assets/15.png"),
                ],
              ),
              SizedBox(
                height: 36,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () async {
              //         setState(() {
              //           _isLoading = true;
              //         });
              //         String pdfBytes = await PostResume().generatePdf();
              //         setState(() {
              //           _isLoading = false;
              //         });
              //         await _saveAndOpenPdf(pdfBytes);
              //
              //       },
              //       child: Container(
              //         width: 220,
              //         height: 52,
              //         decoration: BoxDecoration(
              //             color: Colors.greenAccent,
              //             borderRadius: BorderRadius.circular(26)),
              //         child: Center(
              //             child: _isLoading
              //                 ? CircularProgressIndicator(
              //                     strokeWidth: 2,
              //                     color: Colors.white,
              //                   )
              //                 : Text("TextPDF")),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String path;
  final String title;

  const CategoryItem({Key? key, required this.path, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow, // Yellow shadow color
                  blurRadius: 3,
                  spreadRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(path),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            height: 1,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }
}

class ResumeItem extends StatelessWidget {
  final String path;
  final String addPath;
  final String title;
  final int color;

  const ResumeItem(
      {super.key,
      required this.path,
      required this.title,
      required this.color,
      required this.addPath});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.5 - 32;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 180,
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.transparent, // Background color of the card
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: cardWidth - 12,
                height: 168,
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Image.asset(
                            path, // Replace with your image path
                            width: cardWidth - 32,
                            // Adjust the image width as needed
                            height: 100, // Adjust the image height as needed
                          ),
                        ),
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                        0xff89e0fb), // Background color of the circular container
                  ),
                  child: Image.asset(addPath)),
            ),
          ],
        ),
      ),
    );
  }
}
