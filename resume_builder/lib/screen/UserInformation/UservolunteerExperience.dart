import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/screen/UserInformation/UserAreaofInterest.dart';

class UserVolunteerExperience extends StatefulWidget {
  File? image;
  final snap;
  String? category;
  UserVolunteerExperience({Key? key, this.image, this.snap, this.category}) : super(key: key);

  @override
  State<UserVolunteerExperience> createState() =>
      _UserVolunteerExperienceState();
}

class VolunteerExperienceData {
  String title = '';
  String company = '';
  DateTime? startDate;
  DateTime? endDate;
  String location = '';
  String description = '';
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'location': location,
      'description': description,
    };
  }
}

class _UserVolunteerExperienceState extends State<UserVolunteerExperience> {
  final _formKey = GlobalKey<FormState>();
  final List<VolunteerExperienceData> volunteerExperienceDataList = [
    VolunteerExperienceData()
  ]; // Initial entry
  int voulennteerCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // Other fields have already been set in your code
      // Set skills data
      final volunteerExperience = widget.snap['data'][0]['volunteerExperience'];
      if (volunteerExperience != null && volunteerExperience.isNotEmpty) {
        voulennteerCount = volunteerExperience.length;

        // Clear the skills data list and existing skills data list
        volunteerExperienceDataList.clear();

        for (var projectEntry in volunteerExperience) {
          final VolunteerData = VolunteerExperienceData();

          VolunteerData.title = projectEntry['title'] ?? 'No skill';
          VolunteerData.company = projectEntry['company'] ?? 'No skill';
          VolunteerData.startDateController.text = projectEntry['startDate'] ?? 'No skill';
          VolunteerData.endDateController.text = projectEntry['endDate'] ?? 'No skill';
          VolunteerData.location = projectEntry['location'] ?? 'No skill';
          VolunteerData.description = projectEntry['description'] ?? 'No skill';

          // Add skill data to the existingSkillsDataList and skillsDataList
          final endYearString = projectEntry['endDate'];
          if (endYearString != null) {
            try {
              // Specify the format of the date string, e.g., 'yyyy-MM-dd'
              final format = DateFormat('yyyy-MM-dd');
              final endDate = format.parseStrict(endYearString);
              VolunteerData.endDate = endDate;
            } catch (e) {
              // Handle parsing errors, e.g., set a default date or handle as needed
              VolunteerData.endDate = DateTime.now(); // Set it to the current date as an example.
            }
          } else {
            // Handle the case where 'endYear' is null or empty.
            // You can assign a default date or handle it according to your requirements.
            VolunteerData.endDate = DateTime.now(); // For example, set it to the current date.
          }

          final startYearString = projectEntry['startDate'];
          if (startYearString != null) {
            try {
              // Specify the format of the date string, e.g., 'yyyy-MM-dd'
              final format = DateFormat('yyyy-MM-dd');
              final startDate = format.parseStrict(startYearString);
              VolunteerData.startDate = startDate;
            } catch (e) {
              // Handle parsing errors, e.g., set a default date or handle as needed
              VolunteerData.startDate = DateTime.now(); // Set it to the current date as an example.
            }
          } else {
            // Handle the case where 'startYear' is null or empty.
            // You can assign a default date or handle it according to your requirements.
            VolunteerData.startDate = DateTime.now(); // For example, set it to the current date.
          }



          volunteerExperienceDataList.add(VolunteerData);

        }
      } else {
        // Handle the case when there are no skills in the API response
      }
    });
  }

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      VolunteerExperienceData volunteerExperienceData,
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
      if (controller == volunteerExperienceData.startDateController) {
        volunteerExperienceData.startDate = picked;
      } else if (controller == volunteerExperienceData.endDateController) {
        volunteerExperienceData.endDate = picked;
      }
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
                          "Volunteer Experience",
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
                        index < volunteerExperienceDataList.length;
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
                                            volunteerExperienceDataList
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
                              CustomTextFormField(
                                title: "Title:",
                                controller: TextEditingController(
                                  text:
                                  volunteerExperienceDataList[index].title,
                                ),

                                onSaved: (value) {
                                  volunteerExperienceDataList[index].title =
                                  value!;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextFormField(
                                title: "Company:",
                                controller: TextEditingController(
                                  text: volunteerExperienceDataList[index]
                                      .company,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a company';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  volunteerExperienceDataList[index].company =
                                  value!;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 52,
                                          width: MediaQuery.of(context).size.width * 0.46,
                                          child: TextFormField(
                                            controller: volunteerExperienceDataList[
                                            index].startDateController,
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
                                                onTap: () => _selectDate(
                                                    context,
                                                    volunteerExperienceDataList[
                                                    index].startDateController,volunteerExperienceDataList[
                                                index]
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
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 52,
                                          width: 150,
                                          child: TextFormField(
                                            controller: volunteerExperienceDataList[
                                            index].endDateController,
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
                                                  volunteerExperienceDataList[
                                                  index].endDateController,
                                                  volunteerExperienceDataList[
                                                  index],
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
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              CustomTextFormField(
                                title: "Location:",
                                controller: TextEditingController(
                                  text: volunteerExperienceDataList[index]
                                      .location,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a location';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  volunteerExperienceDataList[index].location =
                                  value!;
                                },
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      maxLines: 4,
                                      controller: TextEditingController(
                                        text: volunteerExperienceDataList[index]
                                            .description,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "MontserratRegular",
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Description",
                                        labelText: "Description",
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a description';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        volunteerExperienceDataList[index]
                                            .description = value!;
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
                                    volunteerExperienceDataList.insert(0,
                                        VolunteerExperienceData()); // Add a new entry
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
                                    for (var data in volunteerExperienceDataList) {
                                      Get.find<GlobalController>()
                                          .addUserVolunteerExperienceData(data);
                                    }
                                    // Navigate to the next screen
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return UserAreaOfInterest(image: widget.image, snap: widget.snap,category:widget.category);
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
                                return UserAreaOfInterest(image: widget.image, snap: widget.snap,category:widget.category);
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
