import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder/controller/global_controller.dart';

import 'package:resume_builder/screen/UserInformation/UserEducation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ger_latest_resume.dart';
import '../../models/get_all_bio.dart';

class UserPersonalInfo extends StatefulWidget {
  final code;
  final String category;

  UserPersonalInfo({super.key, required this.code, required this.category});

  @override
  State<UserPersonalInfo> createState() => _UserPersonalInfoState();
}
final GlobalController globalController = Get.find();
class _UserPersonalInfoState extends State<UserPersonalInfo> {
  final _formKey = GlobalKey<FormState>();

  DateTime? dateOfBirth;
  bool _isLoading = false;
  File? image;
  final _picker = ImagePicker();
  var snap = {};

  TextEditingController bioController = TextEditingController();

  TextEditingController jobTitleController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController postcodeController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  List<GetLatestResumeModel> resumeDetails = [];
  GetLatestResumeModel? globalResumeModel;

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
      Uri.parse('https://lizmyresume.onrender.com/user/resume/getLatestResume'),
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

  Future<Map<String, dynamic>> fetchCategoryData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.get(
        Uri.parse(
            'https://lizmyresume.onrender.com/user/public/getFilteredDummyResume?category=${widget.category}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        return json.decode(response.body);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.statusCode} ${response.body}"),
          ),
        );
        return {};
      }
    } catch (e) {
      // Handle the exception, you can print an error message or take appropriate action.
      print('Error in fetchCategoryData: $e');
      // You can also rethrow the exception if you want to propagate it.
      // throw e;
      return {}; // or return a default value, or handle it in some other way.
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
    // TODO: implement initState
    if (widget.code == "create") {
      fetchCategoryData().then((data) {
        // Update the text fields with data from the API response
        print("good");
        setState(() {
          snap = data;
          String name = data['data'][0]['name'];
          List<String> nameParts = name.split(' ');
          firstNameController.text = nameParts[0];
          lastNameController.text = nameParts[1];
          emailController.text =
              data['data'][0]['contact']['email'] ?? 'no email';
          phoneController.text =
              data['data'][0]['contact']['phone'] ?? 'no email';
          addressController.text =
              data['data'][0]['address']['address'] ?? 'no email';
          cityController.text =
              data['data'][0]['address']['city'] ?? 'no email';
          postcodeController.text =
              data['data'][0]['address']['postalCode'] ?? 'no email';
          stateController.text =
              data['data'][0]['address']['state'] ?? 'no email';
          countryController.text =
              data['data'][0]['address']['country'] ?? 'no email';
          jobTitleController.text =
              data['data'][0]['jobTitle'] ?? 'no jobTitle';
          bioController.text = data['data'][0]['summary'] ?? 'no summary';
          dateOfBirthController.text = data['data'][0]['dob'] ?? 'no dob';
          genderController.text = data['data'][0]['gender'] ?? 'no gender';
          // Repeat this for other fields
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${error.toString()}"),
          ),
        );
      });
    } else {
      // Fetch data from the API
      fetchData().then((data) {
        // Update the text fields with data from the API response
        setState(() {
          firstNameController.text = data['data']['name'] ?? 'no name';
          emailController.text = data['data']['contact']['email'] ?? 'no email';
          phoneController.text = data['data']['contact']['phone'] ?? 'no email';
          addressController.text =
              data['data']['address']['address'] ?? 'no email';
          cityController.text = data['data']['address']['city'] ?? 'no email';
          postcodeController.text =
              data['data']['address']['postalCode'] ?? 'no email';
          stateController.text = data['data']['address']['state'] ?? 'no email';
          countryController.text =
              data['data']['address']['country'] ?? 'no email';
          jobTitleController.text = data['data']['jobTitle'] ?? 'no jobTitle';
          bioController.text = data['data']['summary'] ?? 'no summary';
          dateOfBirthController.text = data['data']['dob'] ?? 'no dob';
          genderController.text = data['data']['gender'] ?? 'no gender';
          // Repeat this for other fields
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch data from API"),
          ),
        );
      });
    }

    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
              ))
            : Container(
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
                                  child:
                                      Image.asset("assets/icon/Group 208.png")),
                            ),
                          ],
                        ),

                        //profile part
                        (widget.code == "create")
                            ? Text(
                                "Create",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MontserratBold",
                          ),
                              )
                            : SizedBox(),
                        (widget.code == "create")
                            ? Text(
                                "Your Resume Professional",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: "MontserratBold",
                            ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(top: 33),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Personal Information",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MontserratBold",
                                ),
                              ),
                            ],
                          ),
                        ),

                        //image
                        GestureDetector(
                          onTap: () {
                            //pickImage
                            getImage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: image != null
                                ? Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),

                                    ),
                                    child: Image.file(image!, fit: BoxFit.cover),
                                  )
                                : Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(width: 1, color: Colors.blue)
                              ),
                              child: Icon(Icons.person, color: Colors.grey,size: 36,),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //fields
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: (){
                                          _showCustomDialog(context, bioController, widget.category);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.edit_note_sharp, color: Colors.green, size: 25,),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "MontserratRegular",
                                      ),
                                      maxLines: 6,
                                      controller: bioController,
                                      decoration: InputDecoration(
                                        labelText: "Bio",
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
                                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.blue, width: 2),
                                        ),
                                      ),
                                      onSaved: (value) {
                                        globalController.bio.value = value!;
                                      },
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
                                    onSaved: (value) {
                                      globalController.jobTitle.value = value!;
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomTextFormField(
                                    title: "First Name:",
                                    controller: firstNameController,
                                    onSaved: (value) {
                                      final firstName = value!;
                                      final lastName = lastNameController.text;
                                      final fullName = '$firstName $lastName';
                                      globalController.name.value = fullName;
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
                                    title: "Last Name:",
                                    controller: lastNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      final firstName =
                                          firstNameController.text;
                                      final lastName = value!;
                                      final fullName = '$firstName $lastName';
                                      globalController.name.value = fullName;
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
                                    onSaved: (value) {
                                      globalController.phone.value = value!;
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
                                    onSaved: (value) {
                                      globalController.email.value = value!;
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
                                    onSaved: (value) {
                                      globalController.address.value = value!;
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
                                    onSaved: (value) {
                                      globalController.city.value = value!;
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
                                    onSaved: (value) {
                                      globalController.postalCode.value =
                                          value!;
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
                                    onSaved: (value) {
                                      globalController.state.value = value!;
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
                                    onSaved: (value) {
                                      globalController.country.value = value!;
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // height: 45,
                                        width: MediaQuery.of(context).size.width * 0.46,
                                        child: TextFormField(
                                          controller: dateOfBirthController,
                                          readOnly: true,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "MontserratRegular",
                                          ),

                                          decoration: InputDecoration(
                                            labelText: "Date of Birth",
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
                                              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Colors.blue, width: 2),
                                            ),
                                            hintText: "Date of Birth",
                                            helperStyle:
                                                TextStyle(fontSize: 12),
                                            suffixIcon: InkWell(
                                              onTap: () =>
                                                  _selectDate(context, true),
                                              child: Icon(
                                                Icons.calendar_month,
                                                size: 13,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a date';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            globalController.dob.value = value!;
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
                                    onSaved: (value) {
                                      globalController.gender.value = value!;
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        (widget.code == "create")
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xff6AC9CF),
                                              Color(0xffE9F7F8)
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 38, vertical: 8),
                                        child: Text("Previous"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          globalController.userPersonalInfo(
                                             color: globalController.color.value,
                                              bio: bioController.text,
                                              jobTitle: jobTitleController.text,
                                              name:
                                                  '${firstNameController.text} ${lastNameController.text}',
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              dob: dateOfBirthController.text
                                                  .toString(),
                                              gender: genderController.text,
                                              address: addressController.text,
                                              city: cityController.text,
                                              state: stateController.text,
                                              postalCode:
                                                  postcodeController.text,
                                              country: countryController.text);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return UserEducation(
                                                      code: "create",
                                                      image: image,
                                                      snap: snap, caregory: widget.category);
                                                },
                                              ));
                                        }
                                      },
                                      child: Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Color(0xff6AC9CF),
                                                Color(0xffE9F7F8)
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 8),
                                          child: Text("Next"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),

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
  Future<void> _showCustomDialog(BuildContext context, TextEditingController controller, String category) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: StadiumBorder(),
            content: CoverDialog(controller: controller, category: category),
          ),
        );
      },
    );
  }
}



class CoverDialog extends StatefulWidget {
  final TextEditingController controller;
  final String category;
  const CoverDialog({
    super.key, required this.controller, required this.category,
  });
  @override
  State<CoverDialog> createState() => _CoverDialogState();
}

class _CoverDialogState extends State<CoverDialog> {
  bool _isLoading = false;
  List<GetAllBio> bioList = [];

  late Future<List<GetAllBio>> bioListFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the Future in initState
    bioListFuture = getAllBio();
  }

  Future<List<GetAllBio>> getAllBio() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final Uri uri = Uri.parse(
          "https://lizmyresume.onrender.com/user/public/getSummary");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<
            dynamic> data = responseData['data']; // Assuming 'data' contains the list

        String targetCategory = widget.category; // Specify the category you want

        bioList = data
            .where((json) => json['category'] == targetCategory)
            .map((json) => GetAllBio.fromJson(json))
            .toList();


        setState(() {
          _isLoading = false;
        });
        return bioList;
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
      return List<GetAllBio>.empty(); // or return an appropriate default value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              height: 600,
              padding: EdgeInsets.all(16),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: FutureBuilder(
                future: bioListFuture,
                builder: (context, AsyncSnapshot<List<GetAllBio>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while data is being fetched
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Display an error message if there's an error
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // Display the data when it's available
                    List<GetAllBio> bioList = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${widget.category}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontFamily: "MontserratBold",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Display bioList data in the dialog
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: bioList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    Navigator.pop(context);
                                    widget.controller.text = bioList[index].summary!;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${bioList[index].summary}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "MontserratRegular",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}