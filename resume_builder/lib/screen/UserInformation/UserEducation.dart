import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/screen/UserInformation/UserWorkExperience.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserEducation extends StatefulWidget {
  final code;
  final String? resumeId;
  final String? caregory;
  File? image;
  final snap;
  UserEducation({required this.code,  this.resumeId, this.image, this.snap,  this.caregory});

  @override
  State<UserEducation> createState() => _UserEducationState();
}
String codeToDelete = "update";
class EducationData {
  String schoolName = '';
  String schoolLocation = '';
  String degree = '';
  String fieldOfStudy = '';
  DateTime? startDate;
  DateTime? endDate;
  String? educationId = '';
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  Map<String, dynamic> toJson() {
    if(codeToDelete == "delete"){
      return {
        'collegeName': schoolName,
        'city': schoolLocation,
        '_id': educationId,
        'degree': degree,
        'stream': fieldOfStudy,
        'startYear': startDate!.toIso8601String(),
        'endYear': endDate!.toIso8601String(),
      };
    }else{
      return {
        'collegeName': schoolName,
        'city': schoolLocation,
        'degree': degree,
        'stream': fieldOfStudy,
        'startYear': startDate!.toIso8601String(),
        'endYear': endDate!.toIso8601String(),
      };
    }

  }
}

class _UserEducationState extends State<UserEducation> {
  int educationCount = 0;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final List<EducationData> educationDataList = [
    EducationData()
  ]; // Initial entry
  final List<EducationData> existingEducationDataList = [

  ];

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      EducationData educationData,
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
      if (controller == educationData.startDateController) {
        educationData.startDate = picked;
      } else if (controller == educationData.endDateController) {
        educationData.endDate = picked;
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
  Future<Map<String, dynamic>> fetchEditData() async {
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
          'https://lizmyresume.onrender.com/user/resume/getLatestResume'),
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
    if(widget.code == "update"){
      fetchData().then((data) {
        print(data);
        setState(() {
          // Other fields have already been set in your code
          // Set skills data
          final education = data['data']['education'];
          if (education != null && education.isNotEmpty) {
            educationCount = education.length;

            // Clear the existing skillsDataList and add the skills from the API
            educationDataList.clear();
            existingEducationDataList.clear();

            for (var educationEntry in education) {
              final educationData = EducationData();

              educationData.degree = educationEntry['degree'] ?? 'No degree';
              educationData.schoolName = educationEntry['collegeName'] ?? 'No name';
              educationData.fieldOfStudy = educationEntry['stream'] ?? 'No stream';
              educationData.schoolLocation = educationEntry['city'] ?? 'No city';
              educationData.educationId = educationEntry['_id'] ?? 'null';
              educationData.startDateController.text = educationEntry['startYear'] ?? 'No date';
              educationData.endDateController.text = educationEntry['endYear'] ?? 'No date';

              educationDataList.add(educationData);
              existingEducationDataList.add(educationData);
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
    }else if(widget.code == "edit"){
      fetchEditData().then((data) {
        print(data);
        setState(() {
          // Other fields have already been set in your code
          // Set skills data
          final education = data['data']['education'];
          if (education != null && education.isNotEmpty) {
            educationCount = education.length;

            // Clear the existing skillsDataList and add the skills from the API
            educationDataList.clear();
            existingEducationDataList.clear();

            for (var educationEntry in education) {
              final educationData = EducationData();

              educationData.degree = educationEntry['degree'] ?? 'No degree';
              educationData.schoolName = educationEntry['collegeName'] ?? 'No name';
              educationData.fieldOfStudy = educationEntry['stream'] ?? 'No stream';
              educationData.schoolLocation = educationEntry['city'] ?? 'No city';
              educationData.educationId = educationEntry['_id'] ?? 'null';
              educationData.startDateController.text = educationEntry['startYear'] ?? 'No date';
              educationData.endDateController.text = educationEntry['endYear'] ?? 'No date';

              educationDataList.add(educationData);
              existingEducationDataList.add(educationData);
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
    }else if(widget.code == "create"){
      setState(() {

        final education = widget.snap['data'][0]['education'];
        educationCount = education.length;

        // Clear the existing skillsDataList and add the skills from the API
        educationDataList.clear();
        existingEducationDataList.clear();

        for (var educationEntry in education) {
          final educationData = EducationData();

          educationData.degree = educationEntry['degree'] ?? 'No degree';
          educationData.schoolName = educationEntry['collegeName'] ?? 'No name';
          educationData.fieldOfStudy = educationEntry['stream'] ?? 'No stream';
          educationData.schoolLocation = educationEntry['city'] ?? 'No city';

          educationData.startDateController.text = educationEntry['startYear'] ?? 'No date';
          educationData.endDateController.text = educationEntry['endYear'] ?? 'No date';

          final endYearString = educationEntry['endYear'];
          if (endYearString != null) {
            try {
              // Specify the format of the date string, e.g., 'yyyy-MM-dd'
              final format = DateFormat('yyyy-MM-dd');
              final endDate = format.parseStrict(endYearString);
              educationData.endDate = endDate;
            } catch (e) {
              // Handle parsing errors, e.g., set a default date or handle as needed
              educationData.endDate = DateTime.now(); // Set it to the current date as an example.
            }
          } else {
            // Handle the case where 'endYear' is null or empty.
            // You can assign a default date or handle it according to your requirements.
            educationData.endDate = DateTime.now(); // For example, set it to the current date.
          }

          // Assuming that educationEntry['startYear'] is a date string in a specific format, e.g., 'yyyy-MM-dd'.
          final startYearString = educationEntry['startYear'];
          if (startYearString != null) {
            try {
              // Specify the format of the date string, e.g., 'yyyy-MM-dd'
              final format = DateFormat('yyyy-MM-dd');
              final startDate = format.parseStrict(startYearString);
              educationData.startDate = startDate;
            } catch (e) {
              // Handle parsing errors, e.g., set a default date or handle as needed
              educationData.startDate = DateTime.now(); // Set it to the current date as an example.
            }
          } else {
            // Handle the case where 'startYear' is null or empty.
            // You can assign a default date or handle it according to your requirements.
            educationData.startDate = DateTime.now(); // For example, set it to the current date.
          }

          educationDataList.add(educationData);
          existingEducationDataList.add(educationData);
          print(educationData);

        }
      });
    }
  }

  Future<void> updateEducation() async {
    final url = 'https://lizmyresume.onrender.com/user/updateEducation/${widget.resumeId}';
    GlobalController globalController = Get.find();

    // Create a list to store the updated skills data
    final updatedEducationDataList = <EducationData>[];

    if (widget.code == "update") {
      // If it's an update, add existing skills data to the updatedSkillsDataList
      updatedEducationDataList.addAll(educationDataList);
    }

    // Add only the new skills data from the global controller to the updatedSkillsDataList


    final requestBody = {
      'education': updatedEducationDataList
          .where((collegeName) => !existingEducationDataList.contains(collegeName))
          .map((education) => education.toJson())
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
        educationDataList.clear();
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

  Future<String> deleteSkills(String educationId) async {
    final url = 'https://lizmyresume.onrender.com/user/deleteEducation/${widget.resumeId}/${educationId}';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // Request was successful, and you can handle the response here.
        print("Education Deleted");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Education Deleted"),
          ),
        );
        return "Success";
      } else {
        // Request failed, handle the error here.
        print("Education delete failed");
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
                      children: const [
                        Text(
                          "Education",
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
                        index < educationDataList.length;
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
                                            )),
                                        GestureDetector(
                                            onTap: () { widget.code == "update"?
                                            setState(() async{
                                              String message = await deleteSkills(educationDataList[index].educationId!);
                                              (message == "Success")?
                                              educationDataList.removeAt(index):null;
                                            })
                                                :
                                              setState(() {
                                                educationDataList
                                                    .removeAt(index);
                                              });
                                            },
                                            child: Container(
                                                width: 30,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all()),
                                                child: Text(
                                                  "-",
                                                  style:
                                                  TextStyle(fontSize: 50),
                                                ))),
                                      ],
                                    )),
                              Row(
                                children: [
                                  CustomTextFormField(
                                    title: "School Name:",
                                    controller: TextEditingController(text: educationDataList[index].schoolName),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your school name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      educationDataList[index].schoolName =
                                      value!;
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomTextFormField(
                                    title: "School Location",
                                    controller: TextEditingController(
                                        text: educationDataList[index]
                                            .schoolLocation),

                                    onSaved: (value) {
                                      educationDataList[index].schoolLocation =
                                      value!;
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
                                        width: MediaQuery.of(context).size.width * 0.46,
                                        child:
                                        TextFormField(
                                          controller: educationDataList[index]
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
                                              onTap: () => _selectDate(
                                                  context,
                                                  educationDataList[index].startDateController,
                                                  educationDataList[index]),
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
                                            controller: educationDataList[index]
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
                                                    educationDataList[index]
                                                        .endDateController,
                                                    educationDataList[index]),
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
                              Row(
                                children: [
                                  CustomTextFormField(
                                    title: "Degree:",
                                    controller: TextEditingController(
                                        text: educationDataList[index].degree),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your degree';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      educationDataList[index].degree = value!;
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomTextFormField(
                                    title: "Field Of Study:",
                                    controller: TextEditingController(
                                        text: educationDataList[index]
                                            .fieldOfStudy),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your study field';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      educationDataList[index].fieldOfStudy =
                                      value!;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Row(
                        children: [
                          Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.black.withOpacity(0.2),
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  educationDataList.insert(
                                      0, EducationData()); // Add a new entry
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all()),
                                  child: Icon(Icons.add))),
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  (widget.code == "edit")?SizedBox():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (widget.code == "update")?SizedBox():
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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
                                horizontal: 38, vertical: 8),
                            child: Text("Previous"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: GestureDetector(
                          onTap: () {
                            if(widget.code == "update"){
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                for (var data in educationDataList) {
                                  // Add education data to the GlobalController
                                  Get.find<GlobalController>().addEducationData(data);
                                }
                                final globalController = Get.find<GlobalController>();
                                updateEducation();
                              }
                            }else{
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                for (var data in educationDataList) {
                                  // Add education data to the GlobalController
                                  Get.find<GlobalController>()
                                      .addEducationData(data);
                                }
                                final globalController =
                                Get.find<GlobalController>();
                                print("noting");
                                for (var educationData
                                in globalController.educationDataList) {
                                  print(
                                      'School Name: ${educationData.schoolName}');
                                  print(
                                      'School Location: ${educationData.schoolLocation}');
                                  print('Start date: ${educationData.startDate}');
                                  print('End date: ${educationData.endDate}');
                                  print('degree: ${educationData.degree}');
                                  print(
                                      'Field of study: ${educationData.fieldOfStudy}');
                                  // Print other education data fields as needed
                                }

                                // Navigate to the next screen
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return UserWorkExperience(code: "create", image: widget.image, snap:widget.snap, category: widget.caregory);
                                  },
                                ));
                              }
                            }

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
                              child:  widget.code == "update"?
                              Text("Update"):Text("Next"),
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
                          return UserWorkExperience(code: "create", image: widget.image, snap:widget.snap);
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
