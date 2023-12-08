import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/screen/resume_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class CoverTemplate extends StatefulWidget {
  const CoverTemplate({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CoverTemplateState createState() => _CoverTemplateState();
}

class _CoverTemplateState extends State<CoverTemplate> {
  final baseUniqueId = "cover";
  String uniqueId1 = "";
  String uniqueId2 = "";

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

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Widget buildImageButton(String imagePath, BuildContext context, String uniqueId,) {
    return InkResponse(
      onTap: () async{
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
                              height: 200,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResumeColorScreen(url: imagePath, uniqueId: uniqueId, category: "forNow", code: "cover", press: false),
            ),
          );
        }

      },
      child: Image.asset(imagePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/icon/Group 208.png"),
                  ),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    'Cover Letter Template',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontFamily: "MontserratRegular",
                  ),
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400,),
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontFamily: "MontserratRegular",
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontFamily: "MontserratRegular",
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),

                  ),
                  onChanged: (query) {
                    // updateSuggestions(query);
                  },
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (imagePaths.length / 2).ceil(),
                  itemBuilder: (context, index) {

                    uniqueId1 = "$baseUniqueId${2 * index}"; // Generate unique ID
                    uniqueId2 = (index * 2 + 1 < imagePaths.length
                        ? "$baseUniqueId${2 * index + 1}"
                        : null)!;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: buildImageButton(
                                  imagePaths[index * 2], context, uniqueId1),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: index * 2 + 1 < imagePaths.length
                                  ? buildImageButton(
                                      imagePaths[index * 2 + 1], context, uniqueId2)
                                  : Container(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'Template',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_outlined),
          label: 'Cover',
        ),
      ],
    );
  }
}
