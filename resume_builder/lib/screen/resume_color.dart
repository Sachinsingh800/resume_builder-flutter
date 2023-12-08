import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:resume_builder/coverLetter/10CoverLetter.dart';
import 'package:resume_builder/coverLetter/1coverLetter.dart';
import 'package:resume_builder/coverLetter/2coverLetter.dart';
import 'package:resume_builder/coverLetter/3coverLetter.dart';
import 'package:resume_builder/coverLetter/4coverLetter.dart';
import 'package:resume_builder/coverLetter/5coverLetter.dart';
import 'package:resume_builder/coverLetter/6Coverletter.dart';
import 'package:resume_builder/coverLetter/7CoverLetter.dart';
import 'package:resume_builder/coverLetter/8CoverLetter.dart';
import 'package:resume_builder/coverLetter/9CoverLetter.dart';
import 'package:resume_builder/resume%20template/firstResumeTemplate.dart';
import 'package:resume_builder/screen/UserInformation/UserPersonalnfo.dart';
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

import '../controller/global_controller.dart';

class ResumeColorScreen extends StatefulWidget {
  final String url;
  final String uniqueId;
  final String category;
  final String code;
  bool? press;

   ResumeColorScreen(
      {Key? key,
      required this.url,
      required this.uniqueId,
      required this.category,
      required this.code, required this.press})
      : super(key: key);

  @override
  State<ResumeColorScreen> createState() => _ResumeColorScreenState();
}

class _ResumeColorScreenState extends State<ResumeColorScreen> {
  final GlobalController globalController = Get.find();

  void getResume(){
    if(widget.uniqueId == "template0"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return FirstResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template1"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SecondResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template2"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ThirdResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template3"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return FourthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template4"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return FifthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template5"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SixthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template6"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SeventhResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template7"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EighthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template8"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return NinthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template9"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TenthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template10"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ElevethResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template11"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwelthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template12"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ThirteenResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template13"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ForteenResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template14"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return FifteenREsumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template15"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SixteenResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template16"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SeventeenthResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template17"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EighteenResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template18"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return NineTeenResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template19"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentyResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template20"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentyOneResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template21"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentyTwoResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template22"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentyThreeResumeTemplate();
        },
      ));
    }
    else if(widget.uniqueId == "template23"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentyFourResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template24"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentythFiveResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template25"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentySixResumeTemplate();
        },
      ));
    }else if(widget.uniqueId == "template26"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentySevenResumeTemplateWidget();
        },
      ));
    }
    else if(widget.uniqueId == "template27"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentySevenResumeTemplateWidget();
        },
      ));
    }
    else if(widget.uniqueId == "template28"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentySevenResumeTemplateWidget();
        },
      ));
    }
    else if(widget.uniqueId == "template29"){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TwentySevenResumeTemplateWidget();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset("assets/icon/Group 208.png")),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Card(elevation: 10, child: Image.asset(widget.url)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: GestureDetector(
                    onTap: () {
                      //mark this globalController.tempId
                      globalController.tempId.value = widget.uniqueId;

                      widget.code == "cover"
                          ? setState(() {
                              if (widget.uniqueId == "cover0") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return FirstCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover1") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return SecondCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover2") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ThirdCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover3") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return FourthCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover4") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return FifthCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover5") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return SixthCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover6") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return NinthCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover7") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {

                                    return TenthCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover8") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {

                                    return SeventhCoverLetter(code: "create",);
                                  },
                                ));
                              } else if (widget.uniqueId == "cover9") {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return EighthCoverLetter(code: "create",);
                                  },
                                ));
                              }
                            })
                          : setState(() {
                              widget.press = true;
                            });
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xff6AC9CF), Color(0xffE9F7F8)]),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                        child: Text("Continue"),
                      ),
                    ),
                  ),
                ),
              ]),
              widget.press == true
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.3)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 154,
                                  height: 98,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomRight: Radius.circular(40))),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Create Resume For",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "FRESHER",
                                          style: TextStyle(
                                              color: Color(0xff009AA4),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the form submission here
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserPersonalInfo(
                                                  code: "create",
                                                  category: widget.category,
                                                )));
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 35,
                                        vertical: 8,
                                      ),
                                      child: Text("Get Started"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 154,
                                  height: 98,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomLeft: Radius.circular(40))),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Create Resume For",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "PROFESSIONAL",
                                          style: TextStyle(
                                              color: Color(0xff009AA4),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle the form submission here
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             UserPersonalInfo()));
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 35,
                                        vertical: 8,
                                      ),
                                      child: Text("Get Started"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
