import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder/controller/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isLoading = false;
  String url = "";
  File? image;
  final _picker = ImagePicker();
  bool _isUploading = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

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
        _isLoading = false;
      });
      return json.decode(response.body);
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data ${response.body}');
    }
  }

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF00CDAC),
          // Color of the status bar
          statusBarIconBrightness: Brightness.dark,
          // Brightness of system icons (e.g., network, battery)
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    // Create an animation controller with a duration
    _controller = AnimationController(
      vsync: this, // Use the widget's TickerProvider
      duration: Duration(milliseconds: 800), // Adjust the duration as needed
    );

    // Create an animation with a curve
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);

    // Start the animation
    _controller.forward();

    fetchUserData().then((data) {
      // Update the text fields with data from the API response
      setState(() {
        _nameController.text = data['data']['name'] ?? 'No name';
        _roleController.text = data['data']['role'] ?? 'No  Role';
        _emailController.text = data['data']['email'] ?? 'No  email';
        _phoneNoController.text = data['data']['number'] ?? 'No  number';
        url = data['data']['profileImg']['url'] ?? '';
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch data from API ${error.toString()}"),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00CDAC),
        title: Text(
          "Personal Details",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontFamily: "MontserratBold",
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Expanded(
                  child: FadeTransition(
                    opacity: _animation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        url == ""
                            ? GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(0.00, -0.00),
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
                                          image: image != null
                                              ? Image.file(
                                                  image!,
                                                ).image
                                              : Image.asset(
                                                  'assets/images/person.png',
                                                ).image,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(0.00, -0.00),
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
                                          image: image != null
                                              ? Image.file(image!).image
                                              : Image.network(
                                                  url,
                                                ).image,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 36,
                        ),
                        TextField(
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              labelText: "Full Name",
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),
                            decoration: InputDecoration(
                              hintText: "Email ID",
                              labelText: "Email ID",
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                            keyboardType: TextInputType.text,
                            controller: _phoneNoController,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),
                            decoration: InputDecoration(
                              hintText: "Phone No",
                              labelText: "Phone No",
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                            keyboardType: TextInputType.text,
                            controller: _roleController,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),
                            decoration: InputDecoration(
                              hintText: "Role",
                              labelText: "Role",
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: "MontserratRegular",
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                              ),
                            )),
                        SizedBox(
                          height: 36,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (image != null) {
                              setState(() {
                                _isUploading = true;
                              });
                              String message = await UpdateProfile()
                                  .updateWithImage(
                                      image!,
                                      _nameController.text.trim(),
                                      _phoneNoController.text.trim(),
                                      _roleController.text.trim());

                              if (message == "Profile Updated") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$message'),
                                  ),
                                );
                                setState(() {
                                  _isUploading = false;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$message'),
                                  ),
                                );
                                setState(() {
                                  _isUploading = false;
                                });
                              }
                            } else {
                              setState(() {
                                _isUploading = true;
                              });
                              String message = await UpdateProfile()
                                  .updateProfile(
                                      _nameController.text.trim(),
                                      _phoneNoController.text.trim(),
                                      _roleController.text.trim());

                              if (message == "Profile Updated") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$message'),
                                  ),
                                );
                                setState(() {
                                  _isUploading = false;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$message'),
                                  ),
                                );
                                setState(() {
                                  _isUploading = false;
                                });
                              }
                            }
                          },
                          child: Container(
                            width: double.infinity, // Set the desired width
                            height: 49.0, // Set the desired height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF02AABD),
                                  Color(0xFF00CDAC)
                                ], // Replace with your desired colors
                              ),
                            ),
                            child: Center(
                              child: _isUploading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ))
                                  : Text(
                                      "Update",
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
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
