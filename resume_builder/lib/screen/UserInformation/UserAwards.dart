import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/screen/UserInformation/UservolunteerExperience.dart';
import 'package:resume_builder/userdata.dart';

class UserAwards extends StatefulWidget {
  File? image;
  final snap;
  String? category;
  UserAwards({Key? key, this.image, this.snap, this.category}) : super(key: key);

  @override
  State<UserAwards> createState() => _UserAwardsState();
}

class AwardData {
  String title = '';
  String issuingOrganization = '';
  DateTime? date;
  TextEditingController dateController = TextEditingController();
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'issuingOrganization': issuingOrganization,
      'date': date!.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
}

class _UserAwardsState extends State<UserAwards> {
  final _formKey = GlobalKey<FormState>();
  final List<AwardData> awardDataList = [AwardData()]; // Initial entry

  int awardCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // Other fields have already been set in your code
      // Set skills data
      final awards = widget.snap['data'][0]['awards'];
      if (awards != null && awards.isNotEmpty) {
        awardCount = awards.length;

        // Clear the skills data list and existing skills data list
        awardDataList.clear();

        for (var projectEntry in awards) {
          final projectData = AwardData();

          projectData.title = projectEntry['title'] ?? 'No skill';
          projectData.dateController.text = projectEntry['date'] ?? 'No skill';
          projectData.issuingOrganization = projectEntry['issuingOrganization'] ?? 'No skill';

          // Add skill data to the existingSkillsDataList and skillsDataList
          final endYearString = projectEntry['date'];
          if (endYearString != null) {
            try {
              // Specify the format of the date string, e.g., 'yyyy-MM-dd'
              final format = DateFormat('yyyy-MM-dd');
              final endDate = format.parseStrict(endYearString);
              projectData.date = endDate;
            } catch (e) {
              // Handle parsing errors, e.g., set a default date or handle as needed
              projectData.date = DateTime.now(); // Set it to the current date as an example.
            }
          } else {
            // Handle the case where 'endYear' is null or empty.
            // You can assign a default date or handle it according to your requirements.
            projectData.date = DateTime.now(); // For example, set it to the current date.
          }


          awardDataList.add(projectData);

        }
      } else {
        // Handle the case when there are no skills in the API response
      }
    });
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, AwardData awardData) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      final formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      setState(() {
        awardData.date = picked;
        controller.text = formattedDate; // Update the controller's text as well
      });
    }
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
                          "Awards",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        for (var index = 0;
                        index < awardDataList.length;
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
                                            awardDataList.removeAt(index);
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
                              CustomTextFormField(
                                title: "Award Title:",
                                controller: TextEditingController(
                                  text: awardDataList[index].title,
                                ),

                                onSaved: (value) {
                                  awardDataList[index].title = value!;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextFormField(
                                title: "Issuing Organization:",
                                controller: TextEditingController(
                                  text:
                                  awardDataList[index].issuingOrganization,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an issuing organization';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  awardDataList[index].issuingOrganization =
                                  value!;
                                },
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
                                        width: MediaQuery.of(context).size.width * 0.46,
                                        child: TextFormField(
                                          controller: awardDataList[index]
                                              .dateController,

                                          readOnly: true,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "MontserratRegular",
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "End Date",
                                            labelText: "End Date",
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
                                                  awardDataList[index]
                                                      .dateController,
                                                  awardDataList[index]),
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
                                ],
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
                                    awardDataList.insert(
                                        0, AwardData()); // Add a new entry
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
                                  // Handle the form submission here
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    for (var data in awardDataList) {
                                      // Add education data to the GlobalController
                                      Get.find<GlobalController>()
                                          .addUserAwardsData(data);
                                    }
                                    // Navigate to the next screen
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return UserVolunteerExperience(image: widget.image, snap: widget.snap,category:widget.category);
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
                                return UserVolunteerExperience(image: widget.image, snap: widget.snap, category:widget.category);
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
          width: MediaQuery.of(context).size.width * 0.9,
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
