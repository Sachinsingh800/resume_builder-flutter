import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:http/http.dart' as http;
import 'package:resume_builder/models/get_all_skills.dart';
import 'package:resume_builder/screen/UserInformation/UserInternship.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserSkills extends StatefulWidget {
  final code;
  final String? resumeId; // Make it an optional parameter
  final String? category; // Make it an optional parameter
  File? image;
  final snap;
  UserSkills({required this.code, this.resumeId, this.image, this.snap, this.category});



  @override
  _UserSkillsState createState() => _UserSkillsState();
}
String codeToDelete = "update";

// class SkillData {
//   String skill = '';
//   String proficiencyLevel = 'Beginner';
//   String? skillId = '';
//
//
//   Map<String, dynamic> toJson() {
//     if(codeToDelete == "delete"){
//       return {
//         'skills': skill,
//         'level': proficiencyLevel,
//         '_id':   skillId,
//       };
//     }else{
//       return {
//         'skills': skill,
//         'level': proficiencyLevel,
//       };
//     }
//
//   }
// }
class SkillData {
  String? skill = '';
  String? proficiencyLevel = 'Beginner';
  String? skillId;

  // Constructor with optional parameters
  SkillData({ this.skill,  this.proficiencyLevel, this.skillId});

  // Named constructor for creating an instance from JSON
  SkillData.fromJson(Map<String, dynamic> json)
      : skill = json['skills'] ?? '',
        proficiencyLevel = json['level'] ?? 'Beginner',
        skillId = json['_id'];

  // Map the object to JSON
  Map<String, dynamic> toJson() {
    if (codeToDelete == "delete") {
      return {
        'skills': skill,
        'level': proficiencyLevel,
        '_id': skillId,
      };
    } else {
      return {
        'skills': skill,
        'level': proficiencyLevel,
      };
    }
  }
}


class _UserSkillsState extends State<UserSkills> {
  int skillsCount = 0;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final List<SkillData> skillsDataList = [SkillData()]; // Initial entry
  final List<SkillData> existingSkillsDataList = []; // Store existing skills


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

    if(widget.code == "update"){

      final response = await http.get(
        Uri.parse(
            'https://lizmyresume.onrender.com/user/getParticularResume/${widget.resumeId}'),
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
    }else{
      final response = await http.get(Uri.parse('https://lizmyresume.onrender.com/user/resume/getLatestResume'),
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

  }

  @override
  void initState() {
    super.initState();
    if (widget.code == "edit" || widget.code == "update") {
      fetchData().then((data) {
        print(data);
        setState(() {
          // Other fields have already been set in your code
          // Set skills data
          final skillsAndLevel = data['data']['skillsAndLevel'];
          if (skillsAndLevel != null && skillsAndLevel.isNotEmpty) {
            skillsCount = skillsAndLevel.length;

            // Clear the skills data list and existing skills data list
            skillsDataList.clear();
            existingSkillsDataList.clear();

            for (var skillEntry in skillsAndLevel) {
              final skillData = SkillData();

              skillData.skill = skillEntry['skills'] ?? 'No skill';
              skillData.proficiencyLevel = skillEntry['level'] ?? 'Beginner';
              skillData.skillId = skillEntry['_id'] ?? 'null';

              // Add skill data to the existingSkillsDataList and skillsDataList
              existingSkillsDataList.add(skillData);
              skillsDataList.add(skillData);
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
        final skillsAndLevel = widget.snap['data'][0]['skillsAndLevel'];
        if (skillsAndLevel != null && skillsAndLevel.isNotEmpty) {
          skillsCount = skillsAndLevel.length;

          // Clear the skills data list and existing skills data list
          skillsDataList.clear();
          existingSkillsDataList.clear();

          for (var skillEntry in skillsAndLevel) {
            final skillData = SkillData();

            skillData.skill = skillEntry['skills'] ?? 'No skill';
            skillData.proficiencyLevel = skillEntry['level'] ?? 'Beginner';
            skillData.skillId = skillEntry['_id'] ?? 'null';

            // Add skill data to the existingSkillsDataList and skillsDataList
            existingSkillsDataList.add(skillData);
            skillsDataList.add(skillData);


          }
        } else {
          // Handle the case when there are no skills in the API response
        }
      });
    }
  }

  Future<void> updateSkills() async {
    final url = 'https://lizmyresume.onrender.com/user/updateSkills/${widget.resumeId}';
    GlobalController globalController = Get.find();

    // Create a list to store the updated skills data
    final updatedSkillsDataList = <SkillData>[];

    if (widget.code == "update") {
      // If it's an update, add existing skills data to the updatedSkillsDataList
      updatedSkillsDataList.addAll(skillsDataList);
    }

    // Add only the new skills data from the global controller to the updatedSkillsDataList


    final requestBody = {
      'skillsAndLevel': updatedSkillsDataList
          .where((skill) => !existingSkillsDataList.contains(skill))
          .map((skills) => skills.toJson())
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

        globalController.skillDataList.clear();
        skillsDataList.clear();
        existingSkillsDataList.clear();
        updatedSkillsDataList.clear();
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
  Future<String> deleteSkills(String skillId) async {
    final url = 'https://lizmyresume.onrender.com/user/deleteSkills/${widget.resumeId}/${skillId}';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // Request was successful, and you can handle the response here.
        print("Skill Deleted");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Skill Deleted"),
          ),
        );
        return "Success";
      } else {
        // Request failed, handle the error here.
        print("Skill delete failed");
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


  void updateUi(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:   _isLoading ? Center(child: CircularProgressIndicator(strokeWidth: 2,)):
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Skills",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: "MontserratBold",
                      ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _showCustomDialog(context, widget.category!, skillsDataList, updateUi);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 26.0),
                            child: Container(
                              width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle
                                ),
                                child: Icon(Icons.add, color: Colors.white, size: 24,)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        for (var index = 0;
                      index < skillsDataList.length;
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
                                        onTap: () async{
                                          widget.code == "update"?
                                          setState(() async{
                                            String message = await deleteSkills(skillsDataList[index].skillId!);
                                            (message == "Success")?
                                            skillsDataList.removeAt(index):null;
                                          })
                                              :
                                          setState(() {
                                            skillsDataList.removeAt(index);
                                          });
                                        },
                                        child: Container(
                                          width: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(),
                                          ),
                                          child:
                                              widget.code == "update"?
                                          Icon((Icons.delete)
                                          ):Text(
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
                                    title: "Add Skills:",
                                    controller: TextEditingController(text: skillsDataList[index]?.skill ?? ''),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your skill name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      print('onSaved is called with value: $value');
                                      if (index >= skillsDataList.length) {
                                        // If index is greater than or equal to the current skills list length,
                                        // it means this is a new skill field, so add it to the list.
                                        skillsDataList.add(SkillData()..skill = value!);
                                      } else {
                                        // If index is within the current skills list length, update the existing skill.
                                        skillsDataList[index].skill = value!;
                                      }
                                    },
                                    onChanged: (value) {
                                      // Update the skillsDataList in real-time
                                      if (index >= skillsDataList.length) {
                                        skillsDataList.add(SkillData()..skill = value!);
                                      } else {
                                        skillsDataList[index].skill = value!;
                                      }
                                    },
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  CustomTextFormField(
                                    title: "Proficiency Level:",
                                    controller: TextEditingController(
                                      text: skillsDataList[index].proficiencyLevel,
                                    ),
                                    readOnly: true,

                                    onTap: () {
                                      widget.code == "edit"?
                                      (){}:_selectProficiencyLevel(context, index);
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
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              skillsDataList.insert(
                                  0, SkillData()); // Add a new entry
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xff6AC9CF),
                                Color(0xffE9F7F8)
                              ]),
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
                            if(widget.code == "update"){
                              for (var data in existingSkillsDataList) {
                                // Add education data to the GlobalController
                                Get.find<GlobalController>()
                                    .addSkillseData(data);
                              }
                              final globalController =
                              Get.find<GlobalController>();
                              for (var skillsData
                              in globalController.skillDataList) {

                              }
                              updateSkills();
                            }else{
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                for (var data in skillsDataList) {
                                  // Add education data to the GlobalController
                                  Get.find<GlobalController>()
                                      .addSkillseData(data);
                                }
                                final globalController =
                                Get.find<GlobalController>();
                                print("noting");
                                for (var skillsData
                                in globalController.skillDataList) {
                                  print('Skills: ${skillsData.skill}');
                                  print(
                                      'Company naem: ${skillsData.proficiencyLevel}');
                                  // Print other education data fields as needed
                                }
                                // Navigate to the next screen
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return UserInternship(image: widget.image, snap:widget.snap, category: widget.category);
                                  },
                                ));
                              }
                            }

                          },
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xff6AC9CF),
                                  Color(0xffE9F7F8)
                                ]),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 8,
                              ),
                              child:
                              widget.code == "update"?
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
                          return UserInternship(image: widget.image, snap:widget.snap);
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
        ),
      ),
    );

  }

  Future<void> _selectProficiencyLevel(BuildContext context, int index) async {
    final String? selectedProficiency = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Proficiency Level"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Beginner"),
                onTap: () {
                  Navigator.pop(context, "Beginner");
                },
              ),
              ListTile(
                title: Text("Intermediate"),
                onTap: () {
                  Navigator.pop(context, "Intermediate");
                },
              ),
              ListTile(
                title: Text("Advanced"),
                onTap: () {
                  Navigator.pop(context, "Advanced");
                },
              ),
            ],
          ),
        );
      },
    );

    if (selectedProficiency != null) {
      setState(() {
        if (widget.code == "update") {
          // If it's an update, update proficiency level in existingSkillsDataList
          skillsDataList[index].proficiencyLevel = selectedProficiency;
        } else {
          // If it's not an update, update proficiency level in skillsDataList
          skillsDataList[index].proficiencyLevel = selectedProficiency;
        }
      });
    }
  }


}

Future<void> _showCustomDialog(BuildContext context,String category,List<SkillData> skillDataList, VoidCallback updateUi) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: StadiumBorder(),
          content: CoverDialog(category: category, skillsDataList: skillDataList, updateUi: updateUi),
        ),
      );
    },
  );
}

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextFormField({
    required this.title,
    required this.controller,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
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
            readOnly: readOnly,
            onTap: onTap,
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
              suffixIcon: onTap != null
                  ? InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 24,
                ),
              )
                  : null,
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
            validator: validator,
            onSaved: onSaved,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}



class CoverDialog extends StatefulWidget {
  final String category;
  final List<SkillData> skillsDataList; // Add this line
  final VoidCallback updateUi; // Add this line
  const CoverDialog({
    super.key, required this.category, required this.skillsDataList, required this.updateUi,
  });
  @override
  State<CoverDialog> createState() => _CoverDialogState();
}

class _CoverDialogState extends State<CoverDialog> {
  bool _isLoading = false;
  List<GetAllSkills> skillList = [];

  late Future<List<GetAllSkills>> bioListFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the Future in initState
    bioListFuture = getAllBio();
  }

  Future<List<GetAllSkills>> getAllBio() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final Uri uri = Uri.parse(
          "https://lizmyresume.onrender.com/user/public/getSkills");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<
            dynamic> data = responseData['data']; // Assuming 'data' contains the list

        String targetCategory = widget.category; // Specify the category you want

        skillList = data
            .where((json) => json['category'] == targetCategory)
            .map((json) => GetAllSkills.fromJson(json))
            .toList();


        setState(() {
          _isLoading = false;
        });
        return skillList;
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
      return List<GetAllSkills>.empty(); // or return an appropriate default value
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
                builder: (context, AsyncSnapshot<List<GetAllSkills>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while data is being fetched
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Display an error message if there's an error
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // Display the data when it's available
                    List<GetAllSkills> bioList = snapshot.data!;
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
                                    setState(() {
                                      widget.skillsDataList.insert(
                                          0, SkillData(skill: bioList[index].skillName, proficiencyLevel: "Beginner"));
                                    });
                                    widget.updateUi();
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
                                          "${bioList[index].skillName}",
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
