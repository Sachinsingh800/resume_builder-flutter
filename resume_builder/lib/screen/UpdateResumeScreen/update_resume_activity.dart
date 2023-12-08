import 'package:flutter/material.dart';
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

class UpdateResumeScreen extends StatefulWidget {
  final String resumeId;
  final String tempId;
  const UpdateResumeScreen({ required this.resumeId, required this.tempId,});

  @override
  State<UpdateResumeScreen> createState() => _UpdateResumeScreenState();
}

class _UpdateResumeScreenState extends State<UpdateResumeScreen> {

  @override
  Widget build(BuildContext context) {

    Widget? selectedTemplate;

    if (widget.tempId == "template0") {
      selectedTemplate = FirstResumeTemplate(code: "allResume", resumeId: widget.resumeId,);
    } else if (widget.tempId == "template1") {
      selectedTemplate = SecondResumeTemplate(code: "allResume", resumeId: widget.resumeId,);
    } else if (widget.tempId == "template2") {
      selectedTemplate = ThirdResumeTemplate(code: "allResume", resumeId: widget.resumeId,);
    } else if (widget.tempId == "template3") {
      selectedTemplate = FourthResumeTemplate();
    } else if (widget.tempId == "template4") {
      selectedTemplate = FifthResumeTemplate();
    } else if (widget.tempId == "template5") {
      selectedTemplate = SixthResumeTemplate();
    } else if (widget.tempId == "template6") {
      selectedTemplate = SeventhResumeTemplate();
    } else if (widget.tempId == "template7") {
      selectedTemplate = EighthResumeTemplate();
    } else if (widget.tempId == "template8") {
      selectedTemplate = NinthResumeTemplate();
    } else if (widget.tempId == "template9") {
      selectedTemplate = TenthResumeTemplate();
    } else if (widget.tempId == "template10") {
      selectedTemplate = ElevethResumeTemplate();
    } else if (widget.tempId == "template11") {
      selectedTemplate = TwelthResumeTemplate();
    } else if (widget.tempId == "template12") {
      selectedTemplate = ThirteenResumeTemplate();
    } else if (widget.tempId == "template13") {
      selectedTemplate = ForteenResumeTemplate();
    } else if (widget.tempId == "template14") {
      selectedTemplate = FifteenREsumeTemplate();
    } else if (widget.tempId == "template15") {
      selectedTemplate = SixteenResumeTemplate();
    } else if (widget.tempId == "template16") {
      selectedTemplate = SeventeenthResumeTemplate();
    } else if (widget.tempId == "template17") {
      selectedTemplate = EighteenResumeTemplate();
    } else if (widget.tempId == "template18") {
      selectedTemplate = NineTeenResumeTemplate();
    } else if (widget.tempId == "template19") {
      selectedTemplate = TwentyResumeTemplate();
    } else if (widget.tempId == "template20") {
      selectedTemplate = TwentyOneResumeTemplate();
    } else if (widget.tempId == "template21") {
      selectedTemplate = TwentyTwoResumeTemplate();
    } else if (widget.tempId == "template22") {
      selectedTemplate = TwentyThreeResumeTemplate();
    } else if (widget.tempId == "template23") {
      selectedTemplate = TwentyFourResumeTemplate();
    } else if (widget.tempId == "template24") {
      selectedTemplate = TwentythFiveResumeTemplate();
    } else if (widget.tempId == "template25") {
      selectedTemplate = TwentySixResumeTemplate();
    } else if (widget.tempId == "template26") {
      selectedTemplate = TwentySevenResumeTemplateWidget();
    } else if (widget.tempId == "template27") {
      selectedTemplate = TwentySevenResumeTemplateWidget();
    } else if (widget.tempId == "template28") {
      selectedTemplate = TwentySevenResumeTemplateWidget();
    } else {
      // Default to a placeholder widget or some error handling if needed
      selectedTemplate = Text("Template not found");
    }

    return Scaffold(
      body: selectedTemplate, // Display the selected template
    );
  }
}
