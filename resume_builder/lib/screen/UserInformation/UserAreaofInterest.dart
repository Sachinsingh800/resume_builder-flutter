import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/screen/UserInformation/UserReferences.dart';

import '../../models/get_all_area_intrest.dart';

class UserAreaOfInterest extends StatefulWidget {
  File? image;
  final snap;
  String? category;
  UserAreaOfInterest({Key? key, this.image, this.snap, this.category}) : super(key: key);

  @override
  State<UserAreaOfInterest> createState() => _UserAreaOfInterestState();
}

class AreaOfInterestData {
  String? interest = '';

  AreaOfInterestData({this.interest});

  Map<String, dynamic> toJson() {
    return {
      "interest": interest
    };
  }
}

class _UserAreaOfInterestState extends State<UserAreaOfInterest> {
  final _formKey = GlobalKey<FormState>();
  final List<AreaOfInterestData> areaOfInterestDataList = [
    AreaOfInterestData()
  ]; // Initial entry

  int interestCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // Other fields have already been set in your code
      // Set skills data
      final interest = widget.snap['data'][0]['areaOfInterest'];
      if (interest != null && interest.isNotEmpty) {
        interestCount = interest.length;

        // Clear the skills data list and existing skills data list
        areaOfInterestDataList.clear();

        for (var projectEntry in interest) {
          final interestData = AreaOfInterestData();

          interestData.interest = projectEntry['interest'] ?? 'No interest';

          // Add skill data to the existingSkillsDataList and skillsDataList
          areaOfInterestDataList.add(interestData);

        }
      } else {
        // Handle the case when there are no skills in the API response
      }
    });
  }
  void updateUi(){
    setState(() {

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Area of Interest",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MontserratBold",
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _showCustomDialog(context, widget.category!, areaOfInterestDataList, updateUi);
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
                            index < areaOfInterestDataList.length;
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
                                            areaOfInterestDataList
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
                                    title: "Area of Interest:",
                                    controller: TextEditingController(
                                      text: areaOfInterestDataList[index]
                                          .interest,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an area of interest';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      areaOfInterestDataList[index].interest =
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
                                    areaOfInterestDataList.insert(0,
                                        AreaOfInterestData()); // Add a new entry
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
                                    for (var data in areaOfInterestDataList) {
                                      // Add education data to the GlobalController
                                      Get.find<GlobalController>()
                                          .addUserAreofInterestData(data);
                                    }

                                    // Navigate to the next screen
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return UserReference(image: widget.image, snap: widget.snap);
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
                                return UserReference(image: widget.image, snap: widget.snap);
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
Future<void> _showCustomDialog(BuildContext context,String category,List<AreaOfInterestData> areaDataList, VoidCallback updateUi) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: StadiumBorder(),
          content: CoverDialog(category: category,
              areaDataList: areaDataList,
              updateUi: updateUi),
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
class CoverDialog extends StatefulWidget {
  final String category;
  final List<AreaOfInterestData> areaDataList; // Add this line
  final VoidCallback updateUi; // Add this line
  const CoverDialog({
    super.key, required this.category, required this.areaDataList, required this.updateUi,
  });
  @override
  State<CoverDialog> createState() => _CoverDialogState();
}

class _CoverDialogState extends State<CoverDialog> {
  bool _isLoading = false;
  List<GetAllArea> areaList = [];

  late Future<List<GetAllArea>> bioListFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the Future in initState
    bioListFuture = getAllArea();
  }

  Future<List<GetAllArea>> getAllArea() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final Uri uri = Uri.parse(
          "https://lizmyresume.onrender.com/user/public/areaOfInterest");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<
            dynamic> data = responseData['data']; // Assuming 'data' contains the list

        String targetCategory = widget.category; // Specify the category you want

        areaList = data
            .where((json) => json['category'] == targetCategory)
            .map((json) => GetAllArea.fromJson(json))
            .toList();


        setState(() {
          _isLoading = false;
        });
        return areaList;
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
      return List<GetAllArea>.empty(); // or return an appropriate default value
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
                builder: (context, AsyncSnapshot<List<GetAllArea>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while data is being fetched
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Display an error message if there's an error
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // Display the data when it's available
                    List<GetAllArea> areaList = snapshot.data!;
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
                            itemCount: areaList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    Navigator.pop(context);
                                    setState(() {
                                      widget.areaDataList.insert(
                                          0, AreaOfInterestData(interest: areaList[index].interestName));
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
                                          "${areaList[index].interestName}",
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
