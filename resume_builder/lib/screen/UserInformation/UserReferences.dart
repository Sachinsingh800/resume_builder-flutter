import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/screen/UserInformation/UserEducation.dart';
import 'package:resume_builder/screen/UserInformation/UserIntereted.dart';
import 'package:resume_builder/screen/homepage.dart';

import '../../controller/global_controller.dart';

class UserReference extends StatefulWidget {
  File? image;
  final snap;
  UserReference({Key? key, this.image, this.snap}) : super(key: key);

  @override
  State<UserReference> createState() => _UserReferenceState();
}

class ReferenceData {
  String name = '';
  String company = '';
  String position = '';
  String email = '';
  String phone = '';
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'company': company,
      'position': position,
      'email': email,
      'phone': phone,
    };
  }
}

class _UserReferenceState extends State<UserReference> {
  final _formKey = GlobalKey<FormState>();
  final List<ReferenceData> referenceDataList = [
    ReferenceData()
  ]; // Initial entry

  int referenceCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // Other fields have already been set in your code
      // Set skills data
      final reference = widget.snap['data'][0]['references'];
      if (reference != null && reference.isNotEmpty) {
        referenceCount = reference.length;

        // Clear the skills data list and existing skills data list
        referenceDataList.clear();

        for (var projectEntry in reference) {
          final referenceData = ReferenceData();

          referenceData.name = projectEntry['name'] ?? 'No interest';
          referenceData.company = projectEntry['company'] ?? 'No interest';
          referenceData.position = projectEntry['position'] ?? 'No interest';
          referenceData.phone = projectEntry['phone'] ?? 'No interest';
          referenceData.email = projectEntry['email'] ?? 'No interest';

          // Add skill data to the existingSkillsDataList and skillsDataList
          referenceDataList.add(referenceData);


        }
      } else {
        // Handle the case when there are no skills in the API response
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                          child: Image.asset("assets/icon/Group 208.png"),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: "MontserratBold",
                    ),
                  ),
                  Text(
                    "Your Resume Professional",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: "MontserratBold",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 33),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "References",
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
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          for (var index = 0;
                              index < referenceDataList.length;
                              index++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                if (index > 0)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            thickness: 2,
                                            color: Colors.black.withOpacity(0.2),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              referenceDataList.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            width: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(),
                                            ),
                                            child: Text(
                                              "-",
                                              style: TextStyle(fontSize: 50),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(children: [
                                     CustomTextFormField(
                                  title: "Name:",
                                  controller: TextEditingController(
                                      text: referenceDataList[index].name),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    referenceDataList[index].name = value!;
                                  },
                                ),
                                SizedBox(width: 10,),
                                CustomTextFormField(
                                  title: "Company:",
                                  controller: TextEditingController(
                                      text: referenceDataList[index].company),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a company name';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    referenceDataList[index].company = value!;
                                  },
                                ),
                                
                                  ],),
                                  Row(
                                    children: [
                                      CustomTextFormField(
                                  title: "Position:",
                                  controller: TextEditingController(
                                      text: referenceDataList[index].position),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a position';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    referenceDataList[index].position = value!;
                                  },
                                ),
                                SizedBox(width: 10,),
                                CustomTextFormField(
                                  title: "Email:",
                                  controller: TextEditingController(
                                      text: referenceDataList[index].email),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email address';
                                    }
                                    // You can add more email validation logic here if needed
                                    return null;
                                  },
                                  onSaved: (value) {
                                    referenceDataList[index].email = value!;
                                  },
                                ),
                                
                                    ],
                                  ),
                                CustomTextFormField(
                                  title: "Phone:",
                                  controller: TextEditingController(
                                      text: referenceDataList[index].phone),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a phone number';
                                    }
                                    // You can add more phone number validation logic here if needed
                                    return null;
                                  },
                                  onSaved: (value) {
                                    referenceDataList[index].phone = value!;
                                  },
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      referenceDataList
                                          .insert(0, ReferenceData()); // Add a new entry
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all()),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff6AC9CF),
                                          Color(0xffE9F7F8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 38,
                                      vertical: 8,
                                    ),
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
                              for (var data in referenceDataList) {
                                // Add education data to the GlobalController
                                Get.find<GlobalController>()
                                    .addUserReferencesData(data);
                              }
                              
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return UserInterested(image: widget.image);
                                },
                              ));
                            }
                                  },
                                  child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff6AC9CF),
                                            Color(0xffE9F7F8),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50,
                                        vertical: 8,
                                      ),
                                      child: Text("Next"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return UserInterested(image: widget.image);
                                },
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 36.0).copyWith(right: 60),
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xff6AC9CF),
                                        Color(0xffE9F7F8)
                                      ]),
                                      borderRadius: BorderRadius.circular(18)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 38, vertical: 8),
                                  child: Center(child: Text("Skip")),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
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

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CustomTextFormField({
    required this.title,
    required this.controller,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.44,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: controller,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
              fontFamily: "MontserratRegular",
            ),
            decoration: InputDecoration(
              hintText: title == "Start Date:" || title == "End Date:"
                  ? "dd/mm/yyyy"
                  : title,
              labelText: title,
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
              suffixIcon: title == "Start Date:" || title == "End Date:"
                  ? InkWell(
                onTap: () {},
                child: Icon(
                  Icons.calendar_month,
                  size: 13,
                ),
              )
                  : null,
            ),
            readOnly: title == "Start Date:" || title == "End Date:",

            validator: validator,
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}

