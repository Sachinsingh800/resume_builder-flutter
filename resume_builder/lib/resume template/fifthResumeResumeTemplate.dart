// ignore: file_names
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

class FifthResumeTemplate extends StatefulWidget {
  File? image;

   FifthResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FifthResumeTemplateState createState() => _FifthResumeTemplateState();
}

class _FifthResumeTemplateState extends State<FifthResumeTemplate> {
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
          right: true,
          left: true,
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
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration:  BoxDecoration(
                            color: Color(globalController.color.value),
                          ),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 40, 0),
                                  child: Text(
                                    '${globalController.name.value}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 2.0),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 110, 10),
                                  child: Text(
                                    '${globalController.jobTitle.value}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      //fontWeight: FontWeight.w700
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 130, 5),
                                  child: Text(
                                    'E-mail',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      //fontWeight: FontWeight.w700
                                    ),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 35, 10),
                                  child: Text(
                                    '${globalController.email.value}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      //fontWeight: FontWeight.w700
                                    ),
                                  ))
                            ],
                          )),
                      Container(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: const BoxDecoration(
                            color: Color(0xff363c48),
                          ),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      80, 0, 0, 0),
                                  child: Image.asset(
                                    "assets/images/person.png",
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  //),
                                ),
                              ]))
                    ]),
                    Expanded(
                        child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.75,
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text(
                                      '${globalController.bio.value}',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 10, 0, 0),
                                    child: Text(
                                      'Skills',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    indent: 6,
                                    endIndent: 10,
                                    color: Color(0xff363c48),
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width ,
                                    child: ListView.builder(
                                      itemCount:
                                      Get.find<GlobalController>().skillDataList.length,
                                      itemBuilder: (context, index) {
                                        final skill =
                                        Get.find<GlobalController>().skillDataList[index];
                                        return Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '\u2022 ${skill.skill}',
                                                style: TextStyle(
                                                    color: Color(0xff363c48),
                                                    fontSize: 12),
                                              ),
                                            ]);
                                      },
                                    ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 10, 0, 0),
                                    child: Text(
                                      'Work History',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    indent: 6,
                                    endIndent: 10,
                                    color: Color(0xff363c48),
                                  ),


                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: Get.find<GlobalController>()
                                          .workExperienceDataList
                                          .length,
                                      itemBuilder: (context, index) {
                                        final work = Get.find<GlobalController>()
                                            .workExperienceDataList[index];
                                        return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.fromLTRB(6, 4, 0, 0),
                                                      child: Text(
                                                        '${work.startDateController.text} - ${work.endDateController.text}',
                                                        style: TextStyle(
                                                          color: Color(0xff363c48),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Center(
                                                          child: Padding(
                                                              padding: EdgeInsets.fromLTRB(
                                                                  30, 0, 6, 0),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    '${work.positionTitle} ',
                                                                    style: TextStyle(
                                                                      color: Color(0xff363c48),
                                                                      fontSize: 16,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${work.companyName}',
                                                                    //textAlign: TextAlign.left,
                                                                    style: TextStyle(
                                                                      color: Color(0xff363c48),
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '\u2022 ${work.workSummary}',
                                                                    style: TextStyle(
                                                                        color: Color(0xff363c48),
                                                                        fontSize: 12),
                                                                  ),
                                                                  Text(
                                                                    '\u2022 ${work.workSummary}',
                                                                    style: TextStyle(
                                                                        color: Color(0xff363c48),
                                                                        fontSize: 12),
                                                                  ),
                                                                  Text(
                                                                    '\u2022 ${work.workSummary}',
                                                                    style: TextStyle(
                                                                        color: Color(0xff363c48),
                                                                        fontSize: 12),
                                                                  ),
                                                                  Text(
                                                                    '\u2022 ${work.workSummary}',
                                                                    style: TextStyle(
                                                                        color: Color(0xff363c48),
                                                                        fontSize: 12),
                                                                  ),
                                                                ],
                                                              )),
                                                        ))
                                                  ]),
                                              SizedBox(height: 15),
                                            ]);
                                      },
                                    ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 10, 0, 0),
                                    child: Text(
                                      'Education',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    indent: 6,
                                    endIndent: 10,
                                    color: Color(0xff363c48),
                                  ),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                      Get.find<GlobalController>().educationDataList.length,
                                      itemBuilder: (context, index) {
                                        final education =
                                        Get.find<GlobalController>().educationDataList[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.fromLTRB(6, 4, 0, 0),
                                                        child: Expanded(
                                                            child: Text(
                                                              '${education.startDateController.text} - ${education.endDateController.text} ',
                                                              style: TextStyle(
                                                                color: Color(0xff363c48),
                                                                fontSize: 12,
                                                              ),
                                                            )),
                                                      ),
                                                      Expanded(
                                                          child: Center(
                                                            child: Padding(
                                                                padding: EdgeInsets.fromLTRB(
                                                                    28, 0, 6, 0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      '${education.degree}',
                                                                      style: TextStyle(
                                                                        color: Color(0xff363c48),
                                                                        fontSize: 16,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${education.schoolName}',
                                                                      //textAlign: TextAlign.left,
                                                                      style: TextStyle(
                                                                        color: Color(0xff363c48),
                                                                        fontSize: 14,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '\u2022  ${education.fieldOfStudy}',
                                                                      style: TextStyle(
                                                                          color: Color(0xff363c48),
                                                                          fontSize: 12),
                                                                    ),
                                                                    Text(
                                                                      '\u2022 ${education.schoolLocation}',
                                                                      style: TextStyle(
                                                                          color: Color(0xff363c48),
                                                                          fontSize: 12),
                                                                    ),
                                                                    Text(
                                                                      '\u2022 ${education.fieldOfStudy}',
                                                                      style: TextStyle(
                                                                          color: Color(0xff363c48),
                                                                          fontSize: 12),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ))
                                                    ]),
                                              ]),
                                        );
                                      },
                                    ),
                                  )




                                ])))
                  ]),
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
        <link rel="stylesheet" href="styles.css"> 
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
        
.Left_container{
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
    margin-left: 0.5rem ; /* 0.5rem */
    margin-right: 4.375rem; /* 4.375rem */
    color:white;
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
    padding: .5rem;


  }
  .skillsHeader {
    
    display: flex;
    flex-direction: column;
    gap: .5rem;
  }

  .skillsHeader h3{
   padding: 0rem 1rem;
    background-color: aliceblue;
  }

  .skillsHeader ul{
   list-style: none;
  padding: 0rem 2rem 0rem 1rem;

  }
  .skillsHeader ul li{
display: flex;
flex-direction: column;

  }
  .skillsHeader2{
      padding: 0!important;
  }
  .skillsHeader2 p{
    margin: 1rem;
  }
  .skillsHeader2 h2{
    display: flex;
    align-items: center;
    gap: .5rem;
    padding: .5rem 2rem;
    font-weight: 400;
  }
  .skillsHeader2 ul{
    margin-left: 1.5rem;
  }
  .professionalSkillsHeader ul{
    margin-left: 1.5rem;
  }

  .info_box{
    display: flex;
    flex-direction: column;
    gap: .5rem;
    padding: 0rem 2rem;
  }
  .info_box h3{
    margin-left: .5rem;
  }
  
  .educationHeader{
    padding: 1.5rem;
  }
  .objectiveHeader{
    padding: 1.5rem;
    height: 10rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
   margin-bottom: 1rem;
  }
  .workHeader{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .skillsHeader2{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .professionalSkillsHeader{
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 1rem;
  }
  .professionalSkillsHeader h2{
    display: flex;
    align-items: center;
    gap: .5rem;
    padding: .5rem 2rem;
    font-weight: 400;
  }
  .img_container{
  padding: .4rem;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .img_box{
    height: 10rem;
    width: 10rem;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    background-color: orange;
    padding: .3rem;
}
.img_box img{
    height: 100%;
    width: 100%;
    border-radius: 50%;
}
.person_name{
  font-size: 3rem;
}
.person_name span{
  color: #2e89ba;
}
.company_name{
  display: flex;
  justify-content: space-between;
  color: #2e89ba;
}
.work_des{
  display: flex;
  flex-direction: column;
  gap:.5rem ;
  padding: 0rem 1rem;
}
.img_container{
  display: flex;
  align-items: center;
  justify-content: center;
  height: 10rem;
}
.skillsAndLevel{
  display: grid;
  grid-template-columns: 1fr 1fr ;
  gap: 1rem;
  padding: 1rem;
}
.skillsAndLevel li{

  overflow: hidden;
}

.design{
background-color: orange;
  width: 1rem;
  height: 100%;
}
.design2{
background-color: orange;
  width: 1rem;
  height: 4rem;
}
.design3{
background-color: orange;
  width: 1rem;
  height: 13rem;
  position: absolute;
  margin-left: -1.5rem;
}
.title_box{
  display: flex;
  width: 100%;
  background-color: white;
}
.title_box2{
  display: flex;
  width: 100%;
 align-items:center ;
 gap: .5rem;
}
.contactInfo p{
    margin:0rem;
}
.objectiveHeader h1,p{
    margin:0rem;
}
.work_des h4,h5,p{
    margin:0rem;
}
.work-ul  {
    margin-left:-.5rem!important;
    flex-direction: column;
    display: flex;
    gap:.8rem;
}

.contact-list  div{
  flex-direction: column;
  display: flex;
  gap:.1rem;
  padding:.2rem!important ;
  margin-left:.8rem;
}
        </style>
        
        <title>Your Page Title</title>
    </head>
    
    <body>
        <div class="main">
            <div class="Left_container" style="background-color: ; color: black;">
                <div class="img_container">
                    <div class="img_box" style="height: 150px; width: 150px;">
                        <!-- Use a placeholder image or replace the source with dynamic data -->
                        <img src="" alt="dp">
                    </div>
                </div>
                <div class="skillsHeader">
                    <div class="title_box">
                        <span class="design"> </span>
                        <h3 style="color: black;">EDUCATION</h3>
                    </div>
                    <ul >
                        <li style="color: black;">
                            <span>
                                Bachelor's Degree
                                <span>2016 - 2020</span>
                            </span>
                            <span>Example University</span>
                        </li>
                        <!-- Add more education items as needed -->
                    </ul>
                </div>
                <div class="skillsHeader">
                    <div class="title_box">
                        <span class="design"> </span>
                        <h3 style="color: black;">CONTACT</h3>
                    </div>
                   <div class="contact-list">
                   <div class="contactInfo">
                   <p class="email" style="color: black;">
                       john.doe@example.com
                   </p>
               </div>

               <div class="contactInfo">
                   <p style="color: black;" class="email">
                       123-456-7890
                   </p>
               </div>

               <div class="contactInfo">
                   <p class="email" style="color: black;">
                       123 Main Street, 56789
                   </p>
               </div>
                   </div>
                   

                </div>
                <div class="skillsHeader">
                    <div class="title_box">
                        <span class="design"> </span>
                        <h3 style="color: black;">REFERENCES</h3>
                    </div>
                    <ul>
                        <li style="color: black;">
                            <h4>Jane Doe</h4>
                            <span>Manager | Example Company</span>
                            <span>987-654-3210</span>
                        </li>
                        <!-- Add more references as needed -->
                    </ul>
                </div>
            </div>
            <div>
                <div class="objectiveHeader" style="background-color: ;">
                    <span class="design3"> &nbsp; </span>
                    <h1 class="person_name" style="font-family: 'YourFont', sans-serif;  color: black;">
                        John Doe
                    </h1>
                    <p class="objectiveText">
                        Web Developer
                    </p>
                </div>
                <div class="skillsHeader2">
                    <div class="title_box2" style="font-family: 'YourFont', sans-serif; background-color: ;">
                        <span class="design2"> &nbsp; </span>
                        <h3>About Me</h3>
                    </div>
                    <p>
                        Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                        Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                    </p>
                </div>
                <div class="professionalSkillsHeader">
                    <div class="title_box2" style="font-family: 'YourFont', sans-serif; background-color: ;">
                        <span class="design2"> &nbsp; </span>
                        <h3>WORKING EXPERIENCE</h3>
                    </div>
                    <ul class="work-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name">
                                    <span>Example Company - New York</span>
                                    <span>Jan 2020 - Present</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces...</p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name">
                                    <span>Example Company - New York</span>
                                    <span>Jan 2020 - Present</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces...</p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name">
                                    <span>Example Company - New York</span>
                                    <span>Jan 2020 - Present</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces...</p>
                            </div>
                        </li>
                        <!-- Add more work experience items as needed -->
                    </ul>
                </div>
                <br />
                <div class="professionalSkillsHeader">
                    <div class="title_box2" style="font-family: 'YourFont', sans-serif; background-color: ;">
                        <span class="design2"> &nbsp; </span>
                        <h3>SOFTWARE SKILL</h3>
                    </div>
                    <ul class="skillsAndLevel">
                        <li>
                            <span>JavaScript</span>
                            <span>
                                <!-- You may adjust the ProgressBar according to your design -->
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <li>
                            <span>JavaScript</span>
                            <span>
                                <!-- You may adjust the ProgressBar according to your design -->
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <li>
                            <span>JavaScript</span>
                            <span>
                              
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <li>
                            <span>JavaScript</span>
                            <span>
                                <!-- You may adjust the ProgressBar according to your design -->
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <!-- Add more software skills as needed -->
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
        <link rel="stylesheet" href="styles.css"> 
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
        
.Left_container{
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
    margin-left: 0.5rem ; /* 0.5rem */
    margin-right: 4.375rem; /* 4.375rem */
    color:white;
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
    padding: .5rem;


  }
  .skillsHeader {
    
    display: flex;
    flex-direction: column;
    gap: .5rem;
  }

  .skillsHeader h3{
   padding: 0rem 1rem;
    background-color: aliceblue;
  }

  .skillsHeader ul{
   list-style: none;
  padding: 0rem 2rem 0rem 1rem;

  }
  .skillsHeader ul li{
display: flex;
flex-direction: column;

  }
  .skillsHeader2{
      padding: 0!important;
  }
  .skillsHeader2 p{
    margin: 1rem;
  }
  .skillsHeader2 h2{
    display: flex;
    align-items: center;
    gap: .5rem;
    padding: .5rem 2rem;
    font-weight: 400;
  }
  .skillsHeader2 ul{
    margin-left: 1.5rem;
  }
  .professionalSkillsHeader ul{
    margin-left: 1.5rem;
  }

  .info_box{
    display: flex;
    flex-direction: column;
    gap: .5rem;
    padding: 0rem 2rem;
  }
  .info_box h3{
    margin-left: .5rem;
  }
  
  .educationHeader{
    padding: 1.5rem;
  }
  .objectiveHeader{
    padding: 1.5rem;
    height: 10rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
   margin-bottom: 1rem;
  }
  .workHeader{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .skillsHeader2{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .professionalSkillsHeader{
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 1rem;
  }
  .professionalSkillsHeader h2{
    display: flex;
    align-items: center;
    gap: .5rem;
    padding: .5rem 2rem;
    font-weight: 400;
  }
  .img_container{
  padding: .4rem;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .img_box{
    height: 10rem;
    width: 10rem;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    background-color: orange;
    padding: .3rem;
}
.img_box img{
    height: 100%;
    width: 100%;
    border-radius: 50%;
}
.person_name{
  font-size: 3rem;
}
.person_name span{
  color: #2e89ba;
}
.company_name{
  display: flex;
  justify-content: space-between;
  color: #2e89ba;
}
.work_des{
  display: flex;
  flex-direction: column;
  gap:.5rem ;
  padding: 0rem 1rem;
}
.img_container{
  display: flex;
  align-items: center;
  justify-content: center;
  height: 10rem;
}
.skillsAndLevel{
  display: grid;
  grid-template-columns: 1fr 1fr ;
  gap: 1rem;
  padding: 1rem;
}
.skillsAndLevel li{

  overflow: hidden;
}

.design{
background-color: orange;
  width: 1rem;
  height: 100%;
}
.design2{
background-color: orange;
  width: 1rem;
  height: 4rem;
}
.design3{
background-color: orange;
  width: 1rem;
  height: 13rem;
  position: absolute;
  margin-left: -1.5rem;
}
.title_box{
  display: flex;
  width: 100%;
  background-color: white;
}
.title_box2{
  display: flex;
  width: 100%;
 align-items:center ;
 gap: .5rem;
}
.contactInfo p{
    margin:0rem;
}
.objectiveHeader h1,p{
    margin:0rem;
}
.work_des h4,h5,p{
    margin:0rem;
}
.work-ul  {
    margin-left:-.5rem!important;
    flex-direction: column;
    display: flex;
    gap:.8rem;
}

.contact-list  div{
  flex-direction: column;
  display: flex;
  gap:.1rem;
  padding:.2rem!important ;
  margin-left:.8rem;
}
        </style>
        
        <title>Your Page Title</title>
    </head>
    
    <body>
        <div class="main">
            <div class="Left_container" style="background-color: ; color: black;">
                <div class="img_container">
                    <div class="img_box" style="height: 150px; width: 150px;">
                        <!-- Use a placeholder image or replace the source with dynamic data -->
                        <img src="" alt="dp">
                    </div>
                </div>
                <div class="skillsHeader">
                    <div class="title_box">
                        <span class="design"> </span>
                        <h3 style="color: black;">EDUCATION</h3>
                    </div>
                    <ul >
                        <li style="color: black;">
                            <span>
                                Bachelor's Degree
                                <span>2016 - 2020</span>
                            </span>
                            <span>Example University</span>
                        </li>
                        <!-- Add more education items as needed -->
                    </ul>
                </div>
                <div class="skillsHeader">
                    <div class="title_box">
                        <span class="design"> </span>
                        <h3 style="color: black;">CONTACT</h3>
                    </div>
                   <div class="contact-list">
                   <div class="contactInfo">
                   <p class="email" style="color: black;">
                       john.doe@example.com
                   </p>
               </div>

               <div class="contactInfo">
                   <p style="color: black;" class="email">
                       123-456-7890
                   </p>
               </div>

               <div class="contactInfo">
                   <p class="email" style="color: black;">
                       123 Main Street, 56789
                   </p>
               </div>
                   </div>
                   

                </div>
                <div class="skillsHeader">
                    <div class="title_box">
                        <span class="design"> </span>
                        <h3 style="color: black;">REFERENCES</h3>
                    </div>
                    <ul>
                        <li style="color: black;">
                            <h4>Jane Doe</h4>
                            <span>Manager | Example Company</span>
                            <span>987-654-3210</span>
                        </li>
                        <!-- Add more references as needed -->
                    </ul>
                </div>
            </div>
            <div>
                <div class="objectiveHeader" style="background-color: ;">
                    <span class="design3"> &nbsp; </span>
                    <h1 class="person_name" style="font-family: 'YourFont', sans-serif;  color: black;">
                        John Doe
                    </h1>
                    <p class="objectiveText">
                        Web Developer
                    </p>
                </div>
                <div class="skillsHeader2">
                    <div class="title_box2" style="font-family: 'YourFont', sans-serif; background-color: ;">
                        <span class="design2"> &nbsp; </span>
                        <h3>About Me</h3>
                    </div>
                    <p>
                        Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                        Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                    </p>
                </div>
                <div class="professionalSkillsHeader">
                    <div class="title_box2" style="font-family: 'YourFont', sans-serif; background-color: ;">
                        <span class="design2"> &nbsp; </span>
                        <h3>WORKING EXPERIENCE</h3>
                    </div>
                    <ul class="work-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name">
                                    <span>Example Company - New York</span>
                                    <span>Jan 2020 - Present</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces...</p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name">
                                    <span>Example Company - New York</span>
                                    <span>Jan 2020 - Present</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces...</p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name">
                                    <span>Example Company - New York</span>
                                    <span>Jan 2020 - Present</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces...</p>
                            </div>
                        </li>
                        <!-- Add more work experience items as needed -->
                    </ul>
                </div>
                <br />
                <div class="professionalSkillsHeader">
                    <div class="title_box2" style="font-family: 'YourFont', sans-serif; background-color: ;">
                        <span class="design2"> &nbsp; </span>
                        <h3>SOFTWARE SKILL</h3>
                    </div>
                    <ul class="skillsAndLevel">
                        <li>
                            <span>JavaScript</span>
                            <span>
                                <!-- You may adjust the ProgressBar according to your design -->
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <li>
                            <span>JavaScript</span>
                            <span>
                                <!-- You may adjust the ProgressBar according to your design -->
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <li>
                            <span>JavaScript</span>
                            <span>
                              
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <li>
                            <span>JavaScript</span>
                            <span>
                                <!-- You may adjust the ProgressBar according to your design -->
                                <div style="background-color: orange; width: 40%; height: 4px;"></div>
                            </span>
                        </li>
                        <!-- Add more software skills as needed -->
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
