import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/screen/UserInformation/UserEducation.dart';
import 'package:resume_builder/screen/UserInformation/UserProject.dart';

class UserInternship extends StatefulWidget {
  File? image;
  String? category;
  final snap;
  UserInternship({Key? key, this.image, this.snap, this.category}) : super(key: key);

  @override
  State<UserInternship> createState() => _UserInternshipState();
}

class UserInternshipData {
  String positionTitle = '';
  String companyName = '';
  String workSummary = '';
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String location = '';
  Map<String, dynamic> toJson() {
    return {
      'title': positionTitle,
      'company': companyName,
      'description': workSummary,
      'startDate': startDate?.toIso8601String(), // Convert DateTime to ISO 8601 string
      'endDate': endDate?.toIso8601String(),     // Convert DateTime to ISO 8601 string
      'location': location,
    };
  }
}

class _UserInternshipState extends State<UserInternship> {
  int internshipCount = 0;
  final _formKey = GlobalKey<FormState>();
  final List<UserInternshipData> userInternshipDataList = [
    UserInternshipData()
  ]; // Initial entry
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _enddateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      UserInternshipData internshipData,
      ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      final formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      controller.text = formattedDate;
      // Update the educationData with the selected date
      if (controller == internshipData.startDateController) {
        internshipData.startDate = picked;
      } else if (controller == internshipData.endDateController) {
        internshipData.endDate = picked;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // Other fields have already been set in your code
      // Set skills data
      final internship = widget.snap['data'][0]['internShips'];
      if (internship != null && internship.isNotEmpty) {
        internshipCount = internship.length;

        // Clear the skills data list and existing skills data list
        userInternshipDataList.clear();

        for (var internshipEntry in internship) {
          final internshipData = UserInternshipData();

          internshipData.positionTitle = internshipEntry['title'] ?? 'No skill';
          internshipData.location = internshipEntry['location'] ?? 'Beginner';
          internshipData.companyName = internshipEntry['company'] ?? 'Beginner';
          internshipData.startDateController.text = internshipEntry['startDate'] ?? 'Beginner';
          internshipData.endDateController.text = internshipEntry['endDate'] ?? 'Beginner';
          internshipData.workSummary = internshipEntry['description'] ?? 'Beginner';

          // Add skill data to the existingSkillsDataList and skillsDataList

          final endYearString = internshipEntry['endDate'];
          if (endYearString != null) {
            try {
              // Specify the format of the date string, e.g., 'yyyy-MM-dd'
              final format = DateFormat('yyyy-MM-dd');
              final endDate = format.parseStrict(endYearString);
              internshipData.endDate = endDate;
            } catch (e) {
              // Handle parsing errors, e.g., set a default date or handle as needed
              internshipData.endDate = DateTime.now(); // Set it to the current date as an example.
            }
          } else {
            // Handle the case where 'endYear' is null or empty.
            // You can assign a default date or handle it according to your requirements.
            internshipData.endDate = DateTime.now(); // For example, set it to the current date.
          }

          // Assuming that educationEntry['startYear'] is a date string in a specific format, e.g., 'yyyy-MM-dd'.
          final startYearString = internshipEntry['startDate'];
          if (startYearString != null) {
            try {
              // Specify the format of the date string, e.g., 'yyyy-MM-dd'
              final format = DateFormat('yyyy-MM-dd');
              final startDate = format.parseStrict(startYearString);
              internshipData.startDate = startDate;
            } catch (e) {
              // Handle parsing errors, e.g., set a default date or handle as needed
              internshipData.startDate = DateTime.now(); // Set it to the current date as an example.
            }
          } else {
            // Handle the case where 'startYear' is null or empty.
            // You can assign a default date or handle it according to your requirements.
            internshipData.startDate = DateTime.now(); // For example, set it to the current date.
          }



          userInternshipDataList.add(internshipData);

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
                          "Internship",
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
                    child: Column(
                      children: [
                        for (var index = 0;
                        index < userInternshipDataList.length;
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
                                            userInternshipDataList
                                                .removeAt(index);
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
                              Row(
                                children: [
                                  CustomTextFormField(
                                    title: "Position Title:",
                                    controller: TextEditingController(
                                        text: userInternshipDataList[index]
                                            .positionTitle),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your position title';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userInternshipDataList[index]
                                          .positionTitle = value!;
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomTextFormField(
                                    title: "Company Name:",
                                    controller: TextEditingController(
                                        text: userInternshipDataList[index]
                                            .companyName),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your company name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userInternshipDataList[index]
                                          .companyName = value!;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CustomTextFormField(
                                    title: "Location:",
                                    controller: TextEditingController(
                                        text: userInternshipDataList[index]
                                            .location),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your position location';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userInternshipDataList[index].location =
                                      value!;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.46,
                                        child: TextFormField(
                                          controller: userInternshipDataList[index]
                                              .startDateController,
                                          readOnly: true,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "MontserratRegular",
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "Start Date",
                                            labelText: "Start Date",
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
                                            suffixIcon: InkWell(
                                              onTap: () => _selectDate(context,
                                                  userInternshipDataList[index]
                                                      .startDateController,userInternshipDataList[index]
                                              ),
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

                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.46,
                                          child: TextFormField(
                                            controller: userInternshipDataList[index]
                                                .endDateController,
                                            readOnly: true,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "MontserratRegular",
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "End Date",
                                              labelText: "eND Date",
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
                                              suffixIcon: InkWell(
                                                onTap: () => _selectDate(
                                                    context,
                                                    userInternshipDataList[index]
                                                        .endDateController,userInternshipDataList[index]),
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    TextFormField(
                                      maxLines: 8,
                                      controller: TextEditingController(
                                          text: userInternshipDataList[index]
                                              .workSummary),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "MontserratRegular",
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Work Summary",
                                        labelText: "Work Summary",
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
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your work summary';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userInternshipDataList[index]
                                            .workSummary = value!;
                                      },
                                    ),
                                  ],
                                ),
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
                                    userInternshipDataList.insert(0,
                                        UserInternshipData()); // Add a new entry
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
                                    for (var data in userInternshipDataList) {
                                      // Add education data to the GlobalController
                                      Get.find<GlobalController>()
                                          .addUserInternshipData(data);
                                    }
                                    // Navigate to the next screen
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return UserProject(image: widget.image, snap: widget.snap, category: widget.category);
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
                                return UserProject(image: widget.image, snap: widget.snap);
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
          width: MediaQuery.of(context).size.width * 0.46,
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
