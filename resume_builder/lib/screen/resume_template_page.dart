import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/models/get_all_category.dart';
import 'package:resume_builder/screen/resume_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';

class ResumeTemplate extends StatefulWidget {
  const ResumeTemplate({Key? key}) : super(key: key);

  @override
  _ResumeTemplateState createState() => _ResumeTemplateState();
}

class _ResumeTemplateState extends State<ResumeTemplate> {
  final baseUniqueId = "template";
  String uniqueId1 = "";
  String uniqueId2 = "";
  bool _isLoading = false;
  String category = "Web Developer";

  final List<String> imagePaths = [
    'assets/homepage/01.jpg',
    'assets/homepage/02.jpg',
    'assets/homepage/03.jpg',
    'assets/homepage/04.jpg',
    'assets/homepage/05.jpg',
    'assets/homepage/06.jpg',
    'assets/homepage/06.jpg',
    'assets/homepage/07.jpg',
    'assets/homepage/08.jpg',
    'assets/homepage/09.jpg',
    'assets/homepage/10.jpg',
    'assets/homepage/11.jpg',
    'assets/homepage/12.jpg',
    'assets/homepage/13.jpg',
    'assets/homepage/14.jpg',
    'assets/homepage/15.jpg',
    'assets/homepage/16.jpg',
    'assets/homepage/17.jpg',
    'assets/homepage/18.jpg',
    'assets/homepage/19.jpg',
    'assets/homepage/20.jpg',
    'assets/homepage/21.jpg',
    'assets/homepage/23.jpg',
    'assets/homepage/24.jpg',
    'assets/homepage/25.jpg',
    'assets/homepage/26.jpg',
    'assets/homepage/27.jpg',
    'assets/homepage/28.jpg',
    'assets/homepage/29.jpg',
    'assets/homepage/30.jpg',

  ];

  List<GetAllCategory> categoryList = [];

  Future<List<GetAllCategory>> getAllCategory() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final Uri uri = Uri.parse("https://lizmyresume.onrender.com/user/public/getAllCategoy");
      final response = await http.get(uri);

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data']; // Assuming 'data' contains the list

        categoryList = data.map((json) => GetAllCategory.fromJson(json)).toList();
        setState(() {
          _isLoading = false;
        });
        return categoryList;
      } else {
        // Handle the error if needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed"),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle exceptions here
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred"),
        ),
      );
      print("Error: $error");
      return List<GetAllCategory>.empty(); // or return an appropriate default value
    }
  }


  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Widget buildImageButton(String imagePath, BuildContext context, String uniqueId) {
    return InkResponse(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResumeColorScreen(url: imagePath, uniqueId: uniqueId, category: category, code: "resume", press: false),
          ),
        );
      },
      child: Image.asset(imagePath),
    );
  }
  bool showSuggestionsContainer = true;
  List<String> allSuggestions = [
    "Suggestion 1",
    "Suggestion 2",
    "Suggestion 3",
    "Suggestion 4",
    "Suggestion 5",
    "Suggestion 6",
    "Suggestion 7",
    "Suggestion 8",
    "Suggestion 9",
    "Suggestion 10",
  ];

  List<String> suggestions = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  void updateSuggestions(String query) {
    suggestions.clear();
    if (query.isNotEmpty) {
      suggestions = categoryList
          .where((category) =>
      category.category?.toLowerCase().contains(query.toLowerCase()) == true)
          .map((category) => category.category!)
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading?Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue,)):SingleChildScrollView(
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
                    'Resume Template',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // Search Box
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                          fontFamily: "MontserratRegular",
                        ),
                        decoration: InputDecoration(
                          hintText: category,
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
                          updateSuggestions(query);
                        },
                      ),
                    ),
                  ],
                ),
                if (showSuggestionsContainer)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                       Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: suggestions.map((suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                          onTap: (){
                            setState(() {
                              category = suggestion;
                              showSuggestionsContainer = false;
                              searchController.text = "";
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                const SizedBox(height: 12),
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
