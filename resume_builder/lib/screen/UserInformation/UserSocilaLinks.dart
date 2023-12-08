import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/screen/UserInformation/UserKnowLanguages.dart';

class UserSocialLinks extends StatefulWidget {
  File? image;
  final snap;
  String? category;
  UserSocialLinks({Key? key, this.image, this.snap, this.category}) : super(key: key);

  @override
  State<UserSocialLinks> createState() => _UserSocialLinksState();
}

// class SocialLinksData {
//   String linkedin = '';
//   String github = '';
//   String portfolio = '';
// }

class _UserSocialLinksState extends State<UserSocialLinks> {
  final _formKey = GlobalKey<FormState>();
  final GlobalController globalController = Get.find();
  // final SocialLinksData socialLinksData = SocialLinksData();
  TextEditingController githubcontroller = TextEditingController();

  TextEditingController linkedinController = TextEditingController();

  TextEditingController protfolioController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      linkedinController.text = widget.snap['data'][0]['socialLinks']['linkedin'] ?? 'no email';
      githubcontroller.text = widget.snap['data'][0]['socialLinks']['github'] ?? 'no email';
      protfolioController.text = widget.snap['data'][0]['socialLinks']['portfolio'] ?? 'no email';

      globalController.usersociallinks(
        linkedin: linkedinController.text,
        github: githubcontroller.text,
        portfolio: protfolioController.text,
      );
    });
    super.initState();
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
                          "Social Links",
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
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 26,
                          ),
                          CustomTextFormField(
                            title: "LinkedIn:",
                            controller: linkedinController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your LinkedIn link';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              globalController.linkedin.value = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            title: "GitHub:",
                            controller: githubcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your GitHub link';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              globalController.github.value = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            title: "Portfolio:",
                            controller: protfolioController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Portfolio link';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              globalController.portfolio.value = value!;
                            },
                          ),
                          SizedBox(
                            height: 25,
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
                                      globalController.usersociallinks(
                                        linkedin: linkedinController.text,
                                        github: githubcontroller.text,
                                        portfolio: protfolioController.text,
                                      );
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return UserKnowLanguage(image: widget.image, snap: widget.snap, category:widget.category);
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
                                  return UserKnowLanguage(image: widget.image, snap: widget.snap,category:widget.category);
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
          width: MediaQuery.of(context).size.width,
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
