import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/global_controller.dart';
import '../controller/postResume.dart';
import '../screen/PDFFormat.dart';
import '../widget/pannel_widget.dart';

class SixthResumeTemplate extends StatefulWidget {
  File? image;
   SixthResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SixthResumeTemplateState createState() => _SixthResumeTemplateState();
}

class _SixthResumeTemplateState extends State<SixthResumeTemplate> {
  final GlobalKey genKey = GlobalKey();
  final screenshotController = ScreenshotController();
  final pdf = pw.Document();
  bool _isLoading = false;

  void saveScreenAsPDF() async {
    final Uint8List? image = await screenshotController.capture();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    if (image != null) {
      PostResume().clearControllerValue();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PDFFormat(
                  image: image,
                  name: time,
                )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to capture the screen as an image.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.find();
    void voidCallBack(){
      setState(() {

      });
    }
    return Scaffold(
      body: SafeArea(
          top: true,
          child: Screenshot(
            controller: screenshotController,
            child: SlidingUpPanel(
              minHeight: MediaQuery.of(context).size.height * 0.02,
              maxHeight: MediaQuery.of(context).size.height * 0.3,
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              panelBuilder: (controller)=> PanelWidget(
                controller: controller,
                globalController: globalController,
                callBack: (){
                  voidCallBack();
                },
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.18,
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration:  BoxDecoration(
                              color: Color(globalController.color.value),
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                    child: Text(
                                      globalController.name.value,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xfffefefe),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0),
                                    )),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(6, 15, 0, 0),
                                  child: Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Icon(
                                            Icons.email,
                                            size: 20,
                                            color: Color(0xff939ca3),
                                          ),
                                          SizedBox(width: 10.0),
                                          // Add some space between the icon and text
                                          Text(
                                            globalController.email.value,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color(0xff939ca3)),
                                          ),
                                        ]),
                                        Row(children: [
                                          Icon(
                                            Icons.phone,
                                            size: 20,
                                            color: Color(0xff939ca3),
                                          ),
                                          SizedBox(width: 10.0),
                                          // Add some space between the icon and text
                                          Text(
                                            globalController.phone.value,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color(0xff939ca3)),
                                          ),
                                        ]),
                                        Row(children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 20,
                                            color: Color(0xff939ca3),
                                          ),
                                          SizedBox(width: 10.0),
                                          // Add some space between the icon and text
                                          Text(
                                            '${globalController.state.value} ${globalController.country.value}',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color(0xff939ca3)),
                                          ),
                                        ])
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: MediaQuery.sizeOf(context).height * 0.769,
                                width: MediaQuery.sizeOf(context).width * 0.59,
                                decoration:
                                    const BoxDecoration(color: Color(0xfffefefe)),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                        child: Text(
                                          'Summary',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff303845),
                                              // fontWeight: FontWeight.w700,
                                              letterSpacing: 1.0),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(8, 10, 2, 0),
                                        child: Text(
                                            globalController.bio.value,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff303845),
                                              // fontWeight: FontWeight.w700,
                                              //letterSpacing: 1.0),
                                            ))),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                        child: Text(
                                          'Work Experience',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff303845),
                                              // fontWeight: FontWeight.w700,
                                              letterSpacing: 1.0),
                                        )),

                                    ListView.builder(
                                      itemCount:
                                      Get.find<GlobalController>().workExperienceDataList.length,
                                      itemBuilder: (context, index) {
                                        final skill =
                                        Get.find<GlobalController>().workExperienceDataList[index];
                                        return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                                  child: Text(
                                                    skill.positionTitle,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Color(0xff303845),
                                                        fontWeight: FontWeight.w700,
                                                        letterSpacing: 1.0),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                  child: Text(
                                                    skill.companyName,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xff303845),
                                                        // fontWeight: FontWeight.w700,
                                                        letterSpacing: 1.0),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                  child: Text(
                                                    '${skill.startDateController} - ${skill.endDateController}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xff303845),
                                                        // fontWeight: FontWeight.w700,
                                                        letterSpacing: 1.0),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '\u2022 ${skill.workSummary}',
                                                        style: TextStyle(
                                                            color: Color(0xff363c48),
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        '\u2022  ${skill.location}',
                                                        style: TextStyle(
                                                            color: Color(0xff363c48),
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  )),
                                            ]);
                                      },
                                    ),

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                        child: Text(
                                          'Education',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff303845),
                                              // fontWeight: FontWeight.w700,
                                              letterSpacing: 1.0),
                                        )),
                                    ListView.builder(
                                      itemCount:
                                      Get.find<GlobalController>().educationDataList.length,
                                      itemBuilder: (context, index) {
                                        final skill =
                                        Get.find<GlobalController>().educationDataList[index];
                                        return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                                  child: Text(
                                                    skill.schoolName,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Color(0xff303845),
                                                        fontWeight: FontWeight.w700,
                                                        letterSpacing: 1.0),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                  child: Text(
                                                    skill.fieldOfStudy,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xff303845),
                                                        // fontWeight: FontWeight.w700,
                                                        letterSpacing: 1.0),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                  child: Text(
                                                    '${skill.startDateController} - ${skill.endDateController}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xff303845),
                                                        // fontWeight: FontWeight.w700,
                                                        letterSpacing: 1.0),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '\u2022 ${skill.degree}',
                                                        style: TextStyle(
                                                            color: Color(0xff363c48),
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        '\u2022  ${skill.schoolLocation}',
                                                        style: TextStyle(
                                                            color: Color(0xff363c48),
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  )),
                                            ]);
                                      },
                                    ),
                                  ],
                                )),
                            Container(
                                height: MediaQuery.sizeOf(context).height * 0.769,
                                color: Colors.black,
                                width: 1),
                            Container(
                                height: MediaQuery.sizeOf(context).height * 0.769,
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                decoration: const BoxDecoration(
                                  color: Color(0xfffefefe),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                        child: Text(
                                          'Personal Details',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff303845),
                                              // fontWeight: FontWeight.w700,
                                              letterSpacing: 1.0),
                                        )),
                                    const Padding(
                                        padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                        child: Text('LinkedIn',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff303845),
                                              // fontWeight: FontWeight.w700,
                                              //letterSpacing: 1.0),
                                            ))),
                                     Padding(
                                        padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                        child: Text(globalController.linkedin.value,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff303845),
                                              // fontWeight: FontWeight.w700,
                                              //letterSpacing: 1.0),
                                            ))),
                                    const Divider(
                                      thickness: 1,
                                      indent: 6,
                                      endIndent: 10,
                                      color: Color(0xff303845),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Text(
                                        'Hard Skills',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xff303845),
                                          fontSize: 18,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount:
                                      Get.find<GlobalController>().skillDataList.length,
                                      itemBuilder: (context, index) {
                                        final skill =
                                        Get.find<GlobalController>().skillDataList[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                 Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                                  child: Text(
                                                    skill.skill!,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xff303845)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                                  child: Container(
                                                    height: 5,
                                                    width: MediaQuery.sizeOf(context).width *
                                                        0.4,
                                                    decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                        colors: [
                                                          Color(0xff303845),
                                                          Color(0xff303845),
                                                          Color(0xfffefefe),
                                                          Color(0xfffefefe),
                                                        ],
                                                        stops: [
                                                          0.7,
                                                          0.0,
                                                          0.0,
                                                          1.0
                                                        ], // Adjust the stop values to control the filling level
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        );
                                      },
                                    ),



                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                      child: Text(
                                        'Soft Skills',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xff303845),
                                          fontSize: 18,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount:
                                      Get.find<GlobalController>().skillDataList.length,
                                      itemBuilder: (context, index) {
                                        final skill =
                                        Get.find<GlobalController>().skillDataList[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                                  child: Text(
                                                    skill.skill!,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xff303845)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                                  child: Container(
                                                    height: 5,
                                                    width: MediaQuery.sizeOf(context).width *
                                                        0.4,
                                                    decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                        colors: [
                                                          Color(0xff303845),
                                                          Color(0xff303845),
                                                          Color(0xfffefefe),
                                                          Color(0xfffefefe),
                                                        ],
                                                        stops: [
                                                          0.7,
                                                          0.0,
                                                          0.0,
                                                          1.0
                                                        ], // Adjust the stop values to control the filling level
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        );
                                      },
                                    ),


                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                      child: Text(
                                        'Languages',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xff303845),
                                          fontSize: 18,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount:
                                      Get.find<GlobalController>().knowLanguageDataList.length,
                                      itemBuilder: (context, index) {
                                        final skill =
                                        Get.find<GlobalController>().knowLanguageDataList[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                                  child: Text(
                                                    skill.lang,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xff303845)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                                  child: Container(
                                                    height: 5,
                                                    width: MediaQuery.sizeOf(context).width *
                                                        0.4,
                                                    decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                        colors: [
                                                          Color(0xff303845),
                                                          Color(0xff303845),
                                                          Color(0xfffefefe),
                                                          Color(0xfffefefe),
                                                        ],
                                                        stops: [
                                                          0.7,
                                                          0.0,
                                                          0.0,
                                                          1.0
                                                        ], // Adjust the stop values to control the filling level
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ])
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          if(widget.image == null){
            //Resume with no image
            String message = await PostResume().createResume(globalController);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$message'),
              ),
            );
            if(message == "Data Posted"){
              String pdfBytes = await PostResume().generatePdf("""
       <!DOCTYPE html>
    <html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f0f0f0;
                box-sizing: border-box;
                background-color: white;
            }
    
            .main {
                width: 850px;
                height: 1130px;
                background-color: white;
                display: grid;
                grid-template-columns: 1fr 2fr;
            }
    
            .Left_container {
                display: flex;
                flex-direction: column;
                height: 1210px;
            }
    
            .container {
                padding: 13px 0 0 0;
            }
    
            .name {
                color: white;
            }
    
            .hr {
                margin-left: 0.5rem;
                /* 0.5rem */
                margin-right: 4.375rem;
                /* 4.375rem */
                color: white;
            }
    
            .iconContainer {
                width: 1.5625rem;
                /* 1.5625rem */
                height: 1.5625rem;
                /* 1.5625rem */
                background-color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
    
            .icon {
                color: black;
            }
    
            .email {
                color: white;
            }
    
            .phoneIcon {
                font-size: 12px;
            }
    
            .contactInfo {
                display: flex;
                gap: 1rem;
                padding: .2rem;
            }
    
            .skillsHeader {
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
      
    
            .skillsHeader ul {
                list-style: none;
             
                flex-direction: column;
                display: flex;
                gap:.2rem;
                margin-top:-.5rem;
            }
    
            .skillsHeader ul li {
                display: grid;
                grid-template-columns: 1fr 1fr;
                padding: 0rem 1rem;
                width:100%;
                margin-left:-2.4rem;
             
               
            }
       
    
            .skillsHeader2 {
                padding: 1.5rem;
            }
    
            .skillsHeader2 h2 {
                display: flex;
                align-items: center;
                gap: .5rem;
            }
    
            .skillsHeader2 ul {
                margin-left: 1.5rem;
            }
    
            .professionalSkillsHeader ul {
                margin-left: 1.5rem;
            }
    
            .info_box {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding: 0rem 2rem;
            }
    
            .info_box h3 {
                margin-left: .5rem;
            }
    
            .educationHeader {
                padding: 1.5rem;
            }
    
            .objectiveHeader {
                padding: 1rem;
                height: 13rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: .5rem;
            }
    
            .workHeader {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: .5rem;
            }
    
            .skillsHeader2 {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: .5rem;
            }
    
            .professionalSkillsHeader {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: 1rem;
            }
    
            .professionalSkillsHeader h2 {
                display: flex;
                align-items: center;
                gap: .5rem;
            }
    
            .img_container {
                padding: .4rem;
                display: flex;
                align-items: center;
                justify-content: center;
                
            }
    
            .img_box {
                height: 10rem;
                width: 10rem;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
            }
    
            .img_box img {
              height: 10rem;
              width: 10rem;
                border-radius: 50%;
            }
    
            .person_name {
                font-size: 3rem;
            }
    
            .person_name span {
                color: #2e89ba;
            }
    
            .company_name {
                display: flex;
                justify-content: space-between;
                color: #2e89ba;
            }
    
            .work_des {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding: 0rem 1rem;
            }
    
            .img_container {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 10rem;
            }
            .objectiveHeader h1,p{
              margin:0rem;
            }
            .line {
              margin-top:-2rem;
            }
            .work_des h4,h5,p{
              margin:0rem;
            }
            .exp-ul{
            
              margin-top:-1rem;
              margin-left:-1rem!important;
              flex-direction: column;
              display: flex;
              gap:1rem;
            }
            .exp-line{
              margin-top:-.9rem;
            }
            .ProgressBar{
              margin-top:.4rem;
            }
            .edu-ul li h4,h5,p{
              margin:0rem;
              font-weight: 100;
            }
            .edu-ul{
              display: grid;
              grid-template-columns: 1fr 1fr;
              gap:1rem;
              margin-left:-1rem!important;
            }
        </style>
        <title>Your Page Title</title>
    </head>
    
    <body>
        <div class="main">
            <div class="Left_container" style="background-color: grey; color: white;">
                <div class="img_container">
                    <div class="img_box" style="height: 200px; width: 200px;">
                        <img src=""
                            alt="dp">
                    </div>
                </div>
                <div class="skillsHeader2">
                    <h3>
                        PROFILE
                    </h3>
                   
                   <div class="line"><hr " /></div> 
                    <p>
                        Experienced web developer with expertise in JavaScript and React, seeking challenging projects to
                        contribute my skills and experience.
                    </p>
                </div>
                <div class="info_box">
                    <h3 ">CONTACT ME</h3>
                   
                  <div class="line"><hr " /></div> 
                    <div class="contactInfo">
                        <p ">
                            <span>Mail</span>
                            demo@mail.com
                        </p>
                    </div>
                    <div class="contactInfo">
                        <p class="email" ">
                            <span>Phone</span>
                            +1 123 456 7890
                        </p>
                    </div>
                    <div class="contactInfo">
                        <p ">
                            <span>Location</span>
                            Demo Address, 12345
                        </p>
                    </div>
                </div>
                <div class="skillsHeader">
                    <h3 ">PERSONAL SKILLS</h3>
                   
                       <div class="line"><hr " /></div> 
                    <ul>
                        <li ">
                            <span>HTML</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                        <li ">
                            <span>CSS</span>
                            <div class="ProgressBar" style="background-color: orange; width: 80%; height: 5px;"></div>
                        </li>
                        <li ">
                            <span>JavaScript</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                    </ul>
                </div>
                <div class="skillsHeader">
                    <h3 ">LANGUAGES</h3>
                   
                       <div class="line"><hr " /></div> 
                    <ul>
                        <li ">
                            <span>English</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                        <li>
                            <span>Spanish</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                        <li>
                            <span>French</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                    </ul>
                </div>
            </div>
            <div>
                <div class="objectiveHeader" style="background-color: #3498db;">
                    <h1 class="person_name" style="font-family: 'YourFont', sans-serif;  color: white;">
                        John Doe
                    </h1>
                    <p class="objectiveText">
                        Front-end Developer
                    </p>
                </div>
                <div class="skillsHeader2">
                    <h3 ">EDUCATION</h2>
                   
                       <div class="edu-line"><hr  /></div> 
                    <ul  class="edu-ul">
                        <li >
                            <h4>Computer Science </h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Demo</p>
                        </li>
                        <li >
                            <h4>Computer Science </h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Demo</p>
                        </li>
                        <li >
                            <h4>Computer Science </h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Demo</p>
                        </li>
                       
                    </ul>
                </div>
                <div class="professionalSkillsHeader">
                    <div>
                        <h3 ">EXPERIENCE</h3>
                       
                       
                           <div class="exp-line"><hr " /></div> 
                    </div>
                    <ul class="exp-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-end Developer</h4>
                                <h5 class="company_name">
                                    <span>XYZ Company - New York</span>
                                    <span>Jan 2022 - Present</span>
                                </h5>
                                <p>
                                    Worked on developing user interfaces, implementing new features, and maintaining web
                                    applications.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Junior Developer</h4>
                                <h5 class="company_name">
                                    <span>ABC Agency - San Francisco</span>
                                    <span>Jun 2019 - Dec 2021</span>
                                </h5>
                                <p>
                                    Assisted in the development of web applications, participated in code reviews, and
                                    collaborated with the team.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Junior Developer</h4>
                                <h5 class="company_name">
                                    <span>ABC Agency - San Francisco</span>
                                    <span>Jun 2019 - Dec 2021</span>
                                </h5>
                                <p>
                                    Assisted in the development of web applications, participated in code reviews, and
                                    collaborated with the team.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Junior Developer</h4>
                                <h5 class="company_name">
                                    <span>ABC Agency - San Francisco</span>
                                    <span>Jun 2019 - Dec 2021</span>
                                </h5>
                                <p>
                                    Assisted in the development of web applications, participated in code reviews, and
                                    collaborated with the team.
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
    
    </html>
      """);
              await PostResume().saveAndOpenPdf(pdfBytes, context);
              setState(() {
                _isLoading = false;
              });
            }else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$message'),
                ),
              );
              setState(() {
                _isLoading = false;
              });
            }
          }else{

            String message = await PostResume().makePostRequest(widget.image!);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$message'),
              ),
            );
            if(message == "Resume Created"){
              String pdfBytes = await PostResume().generatePdf("""
       <!DOCTYPE html>
    <html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f0f0f0;
                box-sizing: border-box;
                background-color: white;
            }
    
            .main {
                width: 850px;
                height: 1130px;
                background-color: white;
                display: grid;
                grid-template-columns: 1fr 2fr;
            }
    
            .Left_container {
                display: flex;
                flex-direction: column;
                height: 1210px;
            }
    
            .container {
                padding: 13px 0 0 0;
            }
    
            .name {
                color: white;
            }
    
            .hr {
                margin-left: 0.5rem;
                /* 0.5rem */
                margin-right: 4.375rem;
                /* 4.375rem */
                color: white;
            }
    
            .iconContainer {
                width: 1.5625rem;
                /* 1.5625rem */
                height: 1.5625rem;
                /* 1.5625rem */
                background-color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
    
            .icon {
                color: black;
            }
    
            .email {
                color: white;
            }
    
            .phoneIcon {
                font-size: 12px;
            }
    
            .contactInfo {
                display: flex;
                gap: 1rem;
                padding: .2rem;
            }
    
            .skillsHeader {
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
      
    
            .skillsHeader ul {
                list-style: none;
             
                flex-direction: column;
                display: flex;
                gap:.2rem;
                margin-top:-.5rem;
            }
    
            .skillsHeader ul li {
                display: grid;
                grid-template-columns: 1fr 1fr;
                padding: 0rem 1rem;
                width:100%;
                margin-left:-2.4rem;
             
               
            }
       
    
            .skillsHeader2 {
                padding: 1.5rem;
            }
    
            .skillsHeader2 h2 {
                display: flex;
                align-items: center;
                gap: .5rem;
            }
    
            .skillsHeader2 ul {
                margin-left: 1.5rem;
            }
    
            .professionalSkillsHeader ul {
                margin-left: 1.5rem;
            }
    
            .info_box {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding: 0rem 2rem;
            }
    
            .info_box h3 {
                margin-left: .5rem;
            }
    
            .educationHeader {
                padding: 1.5rem;
            }
    
            .objectiveHeader {
                padding: 1rem;
                height: 13rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: .5rem;
            }
    
            .workHeader {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: .5rem;
            }
    
            .skillsHeader2 {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: .5rem;
            }
    
            .professionalSkillsHeader {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: 1rem;
            }
    
            .professionalSkillsHeader h2 {
                display: flex;
                align-items: center;
                gap: .5rem;
            }
    
            .img_container {
                padding: .4rem;
                display: flex;
                align-items: center;
                justify-content: center;
                
            }
    
            .img_box {
                height: 10rem;
                width: 10rem;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
            }
    
            .img_box img {
              height: 10rem;
              width: 10rem;
                border-radius: 50%;
            }
    
            .person_name {
                font-size: 3rem;
            }
    
            .person_name span {
                color: #2e89ba;
            }
    
            .company_name {
                display: flex;
                justify-content: space-between;
                color: #2e89ba;
            }
    
            .work_des {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding: 0rem 1rem;
            }
    
            .img_container {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 10rem;
            }
            .objectiveHeader h1,p{
              margin:0rem;
            }
            .line {
              margin-top:-2rem;
            }
            .work_des h4,h5,p{
              margin:0rem;
            }
            .exp-ul{
            
              margin-top:-1rem;
              margin-left:-1rem!important;
              flex-direction: column;
              display: flex;
              gap:1rem;
            }
            .exp-line{
              margin-top:-.9rem;
            }
            .ProgressBar{
              margin-top:.4rem;
            }
            .edu-ul li h4,h5,p{
              margin:0rem;
              font-weight: 100;
            }
            .edu-ul{
              display: grid;
              grid-template-columns: 1fr 1fr;
              gap:1rem;
              margin-left:-1rem!important;
            }
        </style>
        <title>Your Page Title</title>
    </head>
    
    <body>
        <div class="main">
            <div class="Left_container" style="background-color: grey; color: white;">
                <div class="img_container">
                    <div class="img_box" style="height: 200px; width: 200px;">
                        <img src=""
                            alt="dp">
                    </div>
                </div>
                <div class="skillsHeader2">
                    <h3>
                        PROFILE
                    </h3>
                   
                   <div class="line"><hr " /></div> 
                    <p>
                        Experienced web developer with expertise in JavaScript and React, seeking challenging projects to
                        contribute my skills and experience.
                    </p>
                </div>
                <div class="info_box">
                    <h3 ">CONTACT ME</h3>
                   
                  <div class="line"><hr " /></div> 
                    <div class="contactInfo">
                        <p ">
                            <span>Mail</span>
                            demo@mail.com
                        </p>
                    </div>
                    <div class="contactInfo">
                        <p class="email" ">
                            <span>Phone</span>
                            +1 123 456 7890
                        </p>
                    </div>
                    <div class="contactInfo">
                        <p ">
                            <span>Location</span>
                            Demo Address, 12345
                        </p>
                    </div>
                </div>
                <div class="skillsHeader">
                    <h3 ">PERSONAL SKILLS</h3>
                   
                       <div class="line"><hr " /></div> 
                    <ul>
                        <li ">
                            <span>HTML</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                        <li ">
                            <span>CSS</span>
                            <div class="ProgressBar" style="background-color: orange; width: 80%; height: 5px;"></div>
                        </li>
                        <li ">
                            <span>JavaScript</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                    </ul>
                </div>
                <div class="skillsHeader">
                    <h3 ">LANGUAGES</h3>
                   
                       <div class="line"><hr " /></div> 
                    <ul>
                        <li ">
                            <span>English</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                        <li>
                            <span>Spanish</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                        <li>
                            <span>French</span>
                            <div class="ProgressBar" style="background-color: orange; width: 40%; height: 5px;"></div>
                        </li>
                    </ul>
                </div>
            </div>
            <div>
                <div class="objectiveHeader" style="background-color: #3498db;">
                    <h1 class="person_name" style="font-family: 'YourFont', sans-serif;  color: white;">
                        John Doe
                    </h1>
                    <p class="objectiveText">
                        Front-end Developer
                    </p>
                </div>
                <div class="skillsHeader2">
                    <h3 ">EDUCATION</h2>
                   
                       <div class="edu-line"><hr  /></div> 
                    <ul  class="edu-ul">
                        <li >
                            <h4>Computer Science </h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Demo</p>
                        </li>
                        <li >
                            <h4>Computer Science </h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Demo</p>
                        </li>
                        <li >
                            <h4>Computer Science </h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Demo</p>
                        </li>
                       
                    </ul>
                </div>
                <div class="professionalSkillsHeader">
                    <div>
                        <h3 ">EXPERIENCE</h3>
                       
                       
                           <div class="exp-line"><hr " /></div> 
                    </div>
                    <ul class="exp-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-end Developer</h4>
                                <h5 class="company_name">
                                    <span>XYZ Company - New York</span>
                                    <span>Jan 2022 - Present</span>
                                </h5>
                                <p>
                                    Worked on developing user interfaces, implementing new features, and maintaining web
                                    applications.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Junior Developer</h4>
                                <h5 class="company_name">
                                    <span>ABC Agency - San Francisco</span>
                                    <span>Jun 2019 - Dec 2021</span>
                                </h5>
                                <p>
                                    Assisted in the development of web applications, participated in code reviews, and
                                    collaborated with the team.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Junior Developer</h4>
                                <h5 class="company_name">
                                    <span>ABC Agency - San Francisco</span>
                                    <span>Jun 2019 - Dec 2021</span>
                                </h5>
                                <p>
                                    Assisted in the development of web applications, participated in code reviews, and
                                    collaborated with the team.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Junior Developer</h4>
                                <h5 class="company_name">
                                    <span>ABC Agency - San Francisco</span>
                                    <span>Jun 2019 - Dec 2021</span>
                                </h5>
                                <p>
                                    Assisted in the development of web applications, participated in code reviews, and
                                    collaborated with the team.
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
    
    </html>
      """);
              await PostResume().saveAndOpenPdf(pdfBytes, context);
              setState(() {
                _isLoading = false;
              });
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$message'),
                ),
              );
              setState(() {
                _isLoading = false;
              });
            }
          }
        },
        child: _isLoading ? CircularProgressIndicator(color: Colors.white,):Icon(Icons.arrow_downward),
      ),
    );
  }
}
