import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/screen/UserInformation/UserSkills.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserWorkExperience extends StatefulWidget {
  final code;
  final String? resumeId;
  final String? category;
  File? image;
  final snap;
  UserWorkExperience({required this.code, this.resumeId, this.image, this.snap, this.category});

  @override
  State<UserWorkExperience> createState() => _UserWorkExperienceState();
}
String codeToDelete = "update";
class WorkExperienceData {
  String positionTitle = '';
  String companyName = '';
  String workSummary = '';
  DateTime? startDate;
  DateTime? endDate;
  String? workId = '';
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  String location = '';

  Map<String, dynamic> toJson() {
    if(codeToDelete == "delete"){
      return {
        "title": positionTitle,
        "company": companyName,
        "_id": workId,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "location": location,
        "description": workSummary,
      };
    }else{
      return {
        "title": positionTitle,
        "company": companyName,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "location": location,
        "description": workSummary,
      };
    }

  }
}

class _UserWorkExperienceState extends State<UserWorkExperience> {
  int experienceCount = 0;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final List<WorkExperienceData> workExperienceDataList = [
    WorkExperienceData()
  ];
  final List<WorkExperienceData> existingWorkExperienceDataList =
      []; // Initial entry
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
    WorkExperienceData workExperienceData,
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
      if (controller == workExperienceData.startDateController) {
        workExperienceData.startDate = picked;
      } else if (controller == workExperienceData.endDateController) {
        workExperienceData.endDate = picked;
      }
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

  Future<Map<String, dynamic>> fetchUpdateData() async {
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
      Uri.parse('https://lizmyresume.onrender.com/user/getParticularResume/${widget.resumeId}'),
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
    if (widget.code == "edit") {
      fetchData().then((data) {
        print(data);
        setState(() {
          // Other fields have already been set in your code
          // Set skills data
          final experience = data['data']['work'];
          if (experience != null && experience.isNotEmpty) {
            experienceCount = experience.length;

            // Clear the existing skillsDataList and add the skills from the API
            workExperienceDataList.clear();
            existingWorkExperienceDataList.clear();

            for (var workEntry in experience) {
              final experienceData = WorkExperienceData();

              experienceData.positionTitle =
                  workEntry['title'] ?? 'No positionTitle';
              experienceData.companyName = workEntry['company'] ?? 'No name';
              experienceData.location = workEntry['location'] ?? 'No location';
              experienceData.workId = workEntry['_id'] ?? 'null';
              experienceData.workSummary =
                  workEntry['description'] ?? 'No workSummary';
              experienceData.startDateController.text =
                  workEntry['startDate'] ?? 'No date';
              experienceData.endDateController.text =
                  workEntry['endDate'] ?? 'No date';

              workExperienceDataList.add(experienceData);
              existingWorkExperienceDataList.add(experienceData);
            }
          } else {
            // Handle the case when there are no skills in the API response
          }
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch data from API"),
          ),
        );
      });
    }else if(widget.code == "update"){
      fetchUpdateData().then((data) {
        print(data);
        setState(() {
          // Other fields have already been set in your code
          // Set skills data
          final experience = data['data']['work'];
          if (experience != null && experience.isNotEmpty) {
            experienceCount = experience.length;

            // Clear the existing skillsDataList and add the skills from the API
            workExperienceDataList.clear();
            existingWorkExperienceDataList.clear();

            for (var workEntry in experience) {
              final experienceData = WorkExperienceData();

              experienceData.positionTitle =
                  workEntry['title'] ?? 'No positionTitle';
              experienceData.companyName = workEntry['company'] ?? 'No name';
              experienceData.location = workEntry['location'] ?? 'No location';
              experienceData.workId = workEntry['_id'] ?? 'null';
              experienceData.workSummary =
                  workEntry['description'] ?? 'No workSummary';
              experienceData.startDateController.text =
                  workEntry['startDate'] ?? 'No date';
              experienceData.endDateController.text =
                  workEntry['endDate'] ?? 'No date';

              workExperienceDataList.add(experienceData);
              existingWorkExperienceDataList.add(experienceData);
            }
          } else {
            // Handle the case when there are no skills in the API response
          }
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch data from API"),
          ),
        );
      });
    }else{
      setState(() {
        // Other fields have already been set in your code
        // Set skills data
        final experience = widget.snap['data'][0]['work'];
        if (experience != null && experience.isNotEmpty) {
          experienceCount = experience.length;

          // Clear the existing skillsDataList and add the skills from the API
          workExperienceDataList.clear();
          existingWorkExperienceDataList.clear();

          for (var workEntry in experience) {
            final experienceData = WorkExperienceData();

            experienceData.positionTitle =
                workEntry['title'] ?? 'No positionTitle';
            experienceData.companyName = workEntry['company'] ?? 'No name';
            experienceData.location = workEntry['location'] ?? 'No location';
            experienceData.workId = workEntry['_id'] ?? 'null';
            experienceData.workSummary =
                workEntry['description'] ?? 'No workSummary';


            experienceData.startDateController.text =
                workEntry['startDate'] ?? 'No date';
            experienceData.endDateController.text =
                workEntry['endDate'] ?? 'No date';

            final endYearString = workEntry['endYear'];
            if (endYearString != null) {
              try {
                // Specify the format of the date string, e.g., 'yyyy-MM-dd'
                final format = DateFormat('yyyy-MM-dd');
                final endDate = format.parseStrict(endYearString);
                experienceData.endDate = endDate;
              } catch (e) {
                // Handle parsing errors, e.g., set a default date or handle as needed
                experienceData.endDate = DateTime.now(); // Set it to the current date as an example.
              }
            } else {
              // Handle the case where 'endYear' is null or empty.
              // You can assign a default date or handle it according to your requirements.
              experienceData.endDate = DateTime.now(); // For example, set it to the current date.
            }

            final startYearString = workEntry['startYear'];
            if (startYearString != null) {
              try {
                // Specify the format of the date string, e.g., 'yyyy-MM-dd'
                final format = DateFormat('yyyy-MM-dd');
                final startDate = format.parseStrict(startYearString);
                experienceData.startDate = startDate;
              } catch (e) {
                // Handle parsing errors, e.g., set a default date or handle as needed
                experienceData.startDate = DateTime.now(); // Set it to the current date as an example.
              }
            } else {
              // Handle the case where 'startYear' is null or empty.
              // You can assign a default date or handle it according to your requirements.
              experienceData.startDate = DateTime.now(); // For example, set it to the current date.
            }

            workExperienceDataList.add(experienceData);
            existingWorkExperienceDataList.add(experienceData);

          }
        } else {
          // Handle the case when there are no skills in the API response
        }
      });
    }
  }

  Future<void> updateWorkExperience() async {
    final url =
        'https://lizmyresume.onrender.com/user/updateWorkExperience/${widget.resumeId}';
    GlobalController globalController = Get.find();

    // Create a list to store the updated skills data
    final updatedWorkExperienceDataList = <WorkExperienceData>[];

    if (widget.code == "update") {
      // If it's an update, add existing skills data to the updatedSkillsDataList
      updatedWorkExperienceDataList.addAll(workExperienceDataList);
    }

    // Add only the new skills data from the global controller to the updatedSkillsDataList

    final requestBody = {
      'work': updatedWorkExperienceDataList
          .where((work) => !existingWorkExperienceDataList.contains(work))
          .map((work) => work.toJson())
          .toList(),
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

        globalController.educationDataList.clear();
        workExperienceDataList.clear();
        existingWorkExperienceDataList.clear();
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

  Future<String> deleteExperience(String workId) async {
    final url = 'https://lizmyresume.onrender.com/user/deleteWorkExperience/${widget.resumeId}/${workId}';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // Request was successful, and you can handle the response here.
        print("Work Deleted");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Education Deleted"),
          ),
        );
        return "Success";
      } else {
        // Request failed, handle the error here.
        print("Work delete failed");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Request failed with status: ${response.statusCode}"),
          ),
        );
        return "Failed";
      }
    } catch (e) {
      // Handle exceptions that may occur during the request.
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.toString()}"),
        ),
      );
      return "Failed";
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
                                "Work Experience",
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
                                  index < workExperienceDataList.length;
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
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () { widget.code == "update"?
                                              setState(() async{
                                                String message = await deleteExperience(workExperienceDataList[index].workId!);
                                                (message == "Success")?
                                                workExperienceDataList.removeAt(index):null;
                                              })
                                                  :

                                                setState(() {
                                                  workExperienceDataList
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
                                                  style:
                                                      TextStyle(fontSize: 50),
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
                                              text:
                                                  workExperienceDataList[index]
                                                          ?.positionTitle ??
                                                      'null'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your position title';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            workExperienceDataList[index]
                                                .positionTitle = value!;
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CustomTextFormField(
                                          title: "Company Name:",
                                          controller: TextEditingController(
                                              text:
                                                  workExperienceDataList[index]
                                                      .companyName),
                                          onSaved: (value) {
                                            workExperienceDataList[index]
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
                                              text:
                                                  workExperienceDataList[index]
                                                      .location),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your position location';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            workExperienceDataList[index]
                                                .location = value!;
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
                                                controller:
                                                    workExperienceDataList[
                                                            index]
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
                                                  suffixIcon: InkWell(
                                                    onTap: () => _selectDate(
                                                        context,
                                                        workExperienceDataList[
                                                        index]
                                                            .startDateController,
                                                        workExperienceDataList[
                                                        index]),
                                                    child: Icon(
                                                      Icons.calendar_month,
                                                      size: 13,
                                                    ),
                                                  ),
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
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter a start date';
                                                  }
                                                  return null;
                                                },
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
                                                  controller:
                                                      workExperienceDataList[
                                                              index]
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
                                                    labelText: "End Date",
                                                    suffixIcon: InkWell(
                                                      onTap: () => _selectDate(
                                                          context,
                                                          workExperienceDataList[
                                                          index]
                                                              .endDateController,
                                                          workExperienceDataList[
                                                          index]),
                                                      child: Icon(
                                                        Icons.calendar_month,
                                                        size: 13,
                                                      ),
                                                    ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            maxLines: 4,
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
                                            ),
                                            controller: TextEditingController(
                                                text: workExperienceDataList[
                                                        index]
                                                    .workSummary),

                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your work summary';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              workExperienceDataList[index]
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
                                          workExperienceDataList.insert(0,
                                              WorkExperienceData()); // Add a new entry
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
                              (widget.code == "edit")
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        (widget.code == "update")
                                            ? SizedBox()
                                            : GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Card(
                                                  elevation: 8,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xff6AC9CF),
                                                          Color(0xffE9F7F8),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 38,
                                                      vertical: 8,
                                                    ),
                                                    child: Text("Previous"),
                                                  ),
                                                ),
                                              ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 25),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Handle the form submission here
                                              if (widget.code == "update") {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  for (var data
                                                      in workExperienceDataList) {
                                                    // Add education data to the GlobalController
                                                    Get.find<GlobalController>()
                                                        .addWorkExperienceData(
                                                            data);
                                                  }
                                                  final globalController = Get
                                                      .find<GlobalController>();
                                                  print("noting");
                                                  for (var woekExperienceData
                                                      in globalController
                                                          .workExperienceDataList) {

                                                    // Print other education data fields as needed
                                                  }
                                                  // Navigate to the next screen
                                                  updateWorkExperience();
                                                }
                                              } else {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  for (var data
                                                      in workExperienceDataList) {
                                                    // Add education data to the GlobalController
                                                    Get.find<GlobalController>()
                                                        .addWorkExperienceData(
                                                            data);
                                                  }
                                                  final globalController = Get
                                                      .find<GlobalController>();
                                                  print("noting");
                                                  for (var woekExperienceData
                                                      in globalController
                                                          .workExperienceDataList) {
                                                    print(
                                                        'Position: ${woekExperienceData.positionTitle}');
                                                    print(
                                                        'Company naem: ${woekExperienceData.companyName}');
                                                    print(
                                                        'location: ${woekExperienceData.location}');
                                                    print(
                                                        'End date: ${woekExperienceData.endDate}');
                                                    print(
                                                        'start date: ${woekExperienceData.startDate}');
                                                    print(
                                                        'work summary: ${woekExperienceData.workSummary}');
                                                    // Print other education data fields as needed
                                                  }
                                                  // Navigate to the next screen
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return UserSkills(
                                                        code: "create",image: widget.image, snap: widget.snap, category: widget.category
                                                      );
                                                    },
                                                  ));
                                                }
                                              }
                                            },
                                            child: Card(
                                              elevation: 8,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff6AC9CF),
                                                      Color(0xffE9F7F8),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 50,
                                                  vertical: 8,
                                                ),
                                                child: widget.code == "update"
                                                    ? Text("Update")
                                                    : Text("Next"),
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
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UserSkills(
                                              code: "create",image: widget.image, snap: widget.snap
                                          );
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
            readOnly: title == "Start Date:" || title == "End Date:",
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
            validator: validator,
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}
