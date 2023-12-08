import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/resume%20template/SixthResumeTemplate.dart';
import 'package:resume_builder/resume%20template/TwentyFiveResumeTemplate.dart';
import 'package:resume_builder/resume%20template/TwentyThreeResumeTemplate.dart';
import 'package:resume_builder/resume%20template/eightResumeTemplate.dart';
import 'package:resume_builder/resume%20template/eighteenResumeTemplate.dart';
import 'package:resume_builder/resume%20template/eleventhResumeTemplate.dart';
import 'package:resume_builder/resume%20template/fifteenResumeTemplate.dart';
import 'package:resume_builder/resume%20template/fifthResumeResumeTemplate.dart';
import 'package:resume_builder/resume%20template/firstResumeTemplate.dart';
import 'package:resume_builder/resume%20template/forteenResumeTemplate.dart';
import 'package:resume_builder/resume%20template/fourthResumeTemplate.dart';
import 'package:resume_builder/resume%20template/ninteenResumeTemplate.dart';
import 'package:resume_builder/resume%20template/secondResumeTemplate.dart';
import 'package:resume_builder/resume%20template/seventeenResumeTemplate.dart';
import 'package:resume_builder/resume%20template/seventhResumeTemplate.dart';
import 'package:resume_builder/resume%20template/sixteenResumeTemplate.dart';
import 'package:resume_builder/resume%20template/tenthResume.dart';
import 'package:resume_builder/resume%20template/thirdResumeTemplate.dart';
import 'package:resume_builder/resume%20template/thirteenResume.dart';
import 'package:resume_builder/resume%20template/twelthResumeTemplate.dart';
import 'package:resume_builder/resume%20template/twentyFourResumeTemplate.dart';
import 'package:resume_builder/resume%20template/twentyResumeTemplate.dart';
import 'package:resume_builder/resume%20template/twentySevenResumeTemplate.dart';
import 'package:resume_builder/resume%20template/twentySixResumeTemplate.dart';
import 'package:resume_builder/resume%20template/twentyTwoResumeTemplate.dart';
import 'package:resume_builder/resume%20template/twentyoneResumeTemplate.dart';
import '../../resume template/ninthResumeTemplate.dart';

class UserInterested extends StatefulWidget {
  File? image;

  UserInterested({Key? key, this.image}) : super(key: key);

  @override
  State<UserInterested> createState() => _UserInterestedState();
}

class _UserInterestedState extends State<UserInterested> {
  final _formKey = GlobalKey<FormState>();
  final GlobalController globalController = Get.find();

  FontWeight jobFontWeight = FontWeight.bold;
  FontWeight internFontWeight = FontWeight.normal;

  String selectedOption = "job";

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // You can also use SimpleDialog
          title: Text("Select an Option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Job", style: TextStyle(fontWeight: jobFontWeight),),
                onTap: () {
                  setState(() {
                    jobFontWeight = FontWeight.bold;
                    internFontWeight = FontWeight.normal;
                    Navigator.pop(context);
                    _showDialog();
                    selectedOption = "job";
                    globalController.userInterested(
                        interestedIN: selectedOption);
                  });
                },
              ),
              ListTile(
                title: Text("Intern", style: TextStyle(fontWeight: internFontWeight),),
                onTap: () {
                  setState(() {
                    jobFontWeight = FontWeight.normal;
                    internFontWeight = FontWeight.bold;
                    Navigator.pop(context);
                    _showDialog();
                    selectedOption = "intern";
                    globalController.userInterested(
                        interestedIN: selectedOption);
                  });
                },
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
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
                        vertical: 8,
                      ),
                      child: Center(child: Text("Previous")),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      // Handle the form submission here
                      print("anurag");
                        // if (await postResume.createResume())
                        if (globalController.tempId.value ==
                            "template0") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return FirstResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template1") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SecondResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template2") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ThirdResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template3") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return FourthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template4") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return FifthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template5") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SixthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template6") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SeventhResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template7") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return EighthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template8") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return NinthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template9") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TenthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template10") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ElevethResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template11") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwelthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template12") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ThirteenResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template13") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ForteenResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template14") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return FifteenREsumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template15") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SixteenResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template16") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SeventeenthResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template17") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return EighteenResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template18") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return NineTeenResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template19") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentyResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template20") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentyOneResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template21") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentyTwoResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template22") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentyThreeResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template23") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentyFourResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template24") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentythFiveResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template25") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentySixResumeTemplate(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template26") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentySevenResumeTemplateWidget(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template27") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentySevenResumeTemplateWidget(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template28") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentySevenResumeTemplateWidget(
                                  image: widget.image);
                            },
                          ));
                        } else if (globalController.tempId.value ==
                            "template29") {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TwentySevenResumeTemplateWidget(
                                  image: widget.image);
                            },
                          ));
                      }
                    },
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
                        vertical: 8,
                      ),
                      child: Center(child: Text("Next")),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      globalController.userInterested(interestedIN: selectedOption);
      _showDialog();
    });
  }




  @override
  Widget build(BuildContext context) {
    globalController.userInterested(interestedIN: selectedOption);
    print("Widget rebuilt");
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 15),
                  //       child: InkWell(
                  //         onTap: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: Image.asset("assets/icon/Group 208.png"),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Text(
                  //   "Create",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     color: Colors.black87,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: "MontserratBold",
                  //   ),
                  // ),
                  // Text(
                  //   "Your Resume Professional",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     color: Colors.black87,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: "MontserratBold",
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 33),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "Interested In",
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           color: Colors.black87,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: "MontserratBold",
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Form(
                  //   key: _formKey,
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         height: 25,
                  //       ),
                  //       CustomTextFormField(
                  //         title: "Interested In:",
                  //         controller:
                  //             TextEditingController(text: selectedOption),
                  //         readOnly: true,
                  //         onTap: _showDialog,
                  //       ),
                  //       SizedBox(
                  //         height: 25,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           GestureDetector(
                  //             onTap: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: Card(
                  //               elevation: 8,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(18.0),
                  //               ),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   gradient: LinearGradient(
                  //                     colors: [
                  //                       Color(0xff6AC9CF),
                  //                       Color(0xffE9F7F8),
                  //                     ],
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(18),
                  //                 ),
                  //                 padding: const EdgeInsets.symmetric(
                  //                   horizontal: 38,
                  //                   vertical: 8,
                  //                 ),
                  //                 child: Text("Previous"),
                  //               ),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(right: 25),
                  //             child: GestureDetector(
                  //               onTap: () async {
                  //                 // Handle the form submission here
                  //                 if (_formKey.currentState!.validate()) {
                  //                   _formKey.currentState!.save();
                  //                   // if (await postResume.createResume())
                  //                   if (globalController.tempId.value ==
                  //                       "template0") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return FirstResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template1") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return SecondResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template2") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return ThirdResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template3") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return FourthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template4") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return FifthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template5") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return SixthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template6") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return SeventhResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template7") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return EighthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template8") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return NinthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template9") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TenthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template10") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return ElevethResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template11") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwelthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template12") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return ThirteenResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template13") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return ForteenResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template14") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return FifteenREsumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template15") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return SixteenResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template16") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return SeventeenthResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template17") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return EighteenResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template18") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return NineTeenResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template19") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentyResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template20") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentyOneResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template21") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentyTwoResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template22") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentyThreeResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template23") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentyFourResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template24") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentythFiveResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template25") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentySixResumeTemplate(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template26") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentySevenResumeTemplateWidget(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template27") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentySevenResumeTemplateWidget(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template28") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentySevenResumeTemplateWidget(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   } else if (globalController.tempId.value ==
                  //                       "template29") {
                  //                     Navigator.push(context, MaterialPageRoute(
                  //                       builder: (context) {
                  //                         return TwentySevenResumeTemplateWidget(
                  //                             image: widget.image);
                  //                       },
                  //                     ));
                  //                   }
                  //                 }
                  //               },
                  //               child: Card(
                  //                 elevation: 8,
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(18.0),
                  //                 ),
                  //                 child: Container(
                  //                   decoration: BoxDecoration(
                  //                     gradient: LinearGradient(
                  //                       colors: [
                  //                         Color(0xff6AC9CF),
                  //                         Color(0xffE9F7F8),
                  //                       ],
                  //                     ),
                  //                     borderRadius: BorderRadius.circular(18),
                  //                   ),
                  //                   padding: const EdgeInsets.symmetric(
                  //                     horizontal: 50,
                  //                     vertical: 8,
                  //                   ),
                  //                   child: Text("Next"),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 50,
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextFormField({
    required this.title,
    required this.controller,
    this.validator,
    this.onSaved,
    this.onTap,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
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
            validator: validator,
            onSaved: onSaved,
            onTap: onTap,
            readOnly: readOnly,
          ),
        ),
      ],
    );
  }
}
