import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../UserInformation/UserAreaofInterest.dart';

class UpdatePersonalInfoScreen extends StatefulWidget {
  final String resumeId;
  const UpdatePersonalInfoScreen({required this.resumeId});

  @override
  State<UpdatePersonalInfoScreen> createState() => _UpdatePersonalInfoScreenState();
}

class _UpdatePersonalInfoScreenState extends State<UpdatePersonalInfoScreen> {

  bool _isLoading = false;
  DateTime? dateOfBirth;
  String url = "";
  File? image;
  final _picker = ImagePicker();

  TextEditingController bioController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();


  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? dateOfBirth ?? DateTime.now()
          : dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        dateOfBirth = picked;
      });
      final formattedDate = "${picked.day}/${picked.month}/${picked.year}";

      dateOfBirthController.text = formattedDate;
    }
  }

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Future<Map<String, dynamic>> fetchData() async {
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
          'https://lizmyresume.onrender.com/user/resume/getParticularResume/${widget.resumeId}'),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((data) {
      // Update the text fields with data from the API response
      setState(() {
        firstNameController.text = data['data']['name'] ?? 'no name';
        addressController.text = data['data']['address']['address'] ?? 'no email';
        cityController.text = data['data']['address']['city'] ?? 'no email';
        postcodeController.text = data['data']['address']['postalCode'] ?? 'no email';
        stateController.text = data['data']['address']['state'] ?? 'no email';
        countryController.text = data['data']['address']['country'] ?? 'no email';
        jobTitleController.text = data['data']['jobTitle'] ?? 'no jobTitle';
        bioController.text = data['data']['summary'] ?? 'no summary';
        dateOfBirthController.text = data['data']['dob'] ?? 'no dob';
        genderController.text = data['data']['gender'] ?? 'no gender';
        url = data['data']['profilePicture']['url'] ?? '';
        phoneController.text = data['data']['contact']['phone'] ?? 'no email';
        emailController.text = data['data']['contact']['email'] ?? 'no email';

      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to fetch data from API ${error.toString()}"),
        ),
      );
    });


  }

  Future<void> makePostRequest() async{
    final url = 'https://lizmyresume.onrender.com/user/updatePersonalInfo/${widget.resumeId}';

    final requestBody = {
      'name':  firstNameController.text,
      'gender': genderController.text,
      'contact': {
        'email': emailController.text,
        'phone': phoneController.text,
      },
      'address': {
        'address':addressController.text,
        'city': cityController.text,
        'state': stateController.text,
        'postalCode': postcodeController.text,
        'country': countryController.text,
      },
      'summary': bioController.text,
      'dob': dateOfBirthController.text,
      'jobTitle': jobTitleController.text,
      // Add other data lists as needed (e.g., knownLanguages, certifications, etc.)
    };

    try {

      final String? authToken = await loadToken();

      final String requestBodyJson = jsonEncode(requestBody);

      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "x-auth-token": "$authToken"
        },
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        // Request was successful, and you can handle the response here.
        print("Response: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Response: ${response.body}"),
          ),
        );
      } else {
        // Request failed, handle the error here.
        print("Request failed with status: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Request failed with status: ${response.statusCode}"),
          ),
        );

      }
    } catch (e) {
      // Handle exceptions that may occur during the request.
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.toString()}"),
        ),
      );
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading ? Center(child: CircularProgressIndicator(strokeWidth: 2,)):
        Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset("assets/icon/Group 208.png")),
                      ),
                    ],
                  ),

                  //profile part
                  Text(
                    "Create",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),

                  Text(
                    "Your Resume Professional",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 33),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  //image
                  GestureDetector(
                    onTap: (){
                      getImage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: image != null?Image.file(image!, width: 60, height: 60,):
                      Image.network(url, width: 60, height: 60,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Card(
                      elevation: 8,
                      color: Color(0xffF4FBFB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13.0, vertical: 7),
                        child: Text(
                          "upload Image",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //fields
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Bio:",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(fontSize: 20),
                              controller: bioController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          CustomTextFormField(
                            title: "Job Title:",
                            controller: jobTitleController,

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomTextFormField(
                            title: "First Name:",
                            controller: firstNameController,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          CustomTextFormField(
                            title: "Last Name:",
                            controller: lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomTextFormField(
                            title: "Phone:",
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            },

                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          CustomTextFormField(
                            title: "Email:",
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomTextFormField(
                            title: "Address:",
                            controller: addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },

                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          CustomTextFormField(
                            title: "City:",
                            controller: cityController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomTextFormField(
                            title: "Post Code:",
                            controller: postcodeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your postcode';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          CustomTextFormField(
                            title: "State",
                            controller: stateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your state';
                              }
                              return null;
                            },

                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomTextFormField(
                            title: "Country",
                            controller: countryController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your country';
                              }
                              return null;
                            },

                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Date of Birth:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                // height: 45,
                                width: 150,
                                child: TextFormField(
                                  controller: dateOfBirthController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 3),
                                    hintText: "dd/mm/yyyy",
                                    helperStyle: TextStyle(fontSize: 12),
                                    suffixIcon: InkWell(
                                      onTap: () => _selectDate(context, true),
                                      child: Icon(
                                        Icons.calendar_month,
                                        size: 13,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a date';
                                    }
                                    return null;
                                  },
                                  // No need for onSaved here
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomTextFormField(
                            title: "Gender",
                            controller: genderController,

                          )
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: GestureDetector(
                        onTap: () async {
                          await makePostRequest();
                        },
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xff6AC9CF),
                                  Color(0xffE9F7F8)
                                ]),
                                borderRadius: BorderRadius.circular(18)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 8),
                            child: Text("Update"),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
