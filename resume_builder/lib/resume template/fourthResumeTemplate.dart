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

class FourthResumeTemplate extends StatefulWidget {
  File? image;
   FourthResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FourthResumeTemplateState createState() => _FourthResumeTemplateState();
}

class _FourthResumeTemplateState extends State<FourthResumeTemplate> {

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
            body: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  decoration:  BoxDecoration(
                    color: Color(globalController.color.value),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/person.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                        child: Text(
                          'CONTACT',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 6,
                        endIndent: 10,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                       Text(
                        '${globalController.email.value}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.lightBlue),
                          child: const Icon(
                            Icons.phone,
                            size: 15,
                          ),
                        ),
                      ),
                       Text(
                        '${globalController.phone.value}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on,
                            size: 15,
                          ),
                        ),
                      ),
                       Text(
                        '${globalController.address.value} ${globalController.state.value} ${globalController.country.value} ${globalController.postalCode.value}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          'HARD SKILLS',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 6,
                        endIndent: 10,
                        color: Colors.white,
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                          itemCount:
                          Get.find<GlobalController>().skillDataList.length,
                          itemBuilder: (context, index) {
                            final skill =
                            Get.find<GlobalController>().skillDataList[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                      child: Text(
                                        '${skill.skill}',
                                        style: TextStyle(fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                      child: Container(
                                        width: 70.0,
                                        height: 10.0,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.lightBlue,
                                              Colors.lightBlue,
                                              Colors.white,
                                              Colors.white
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
                      ),






                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Text(
                          'SOFT SKILLS',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 6,
                        endIndent: 10,
                        color: Colors.white,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ListView.builder(
                          itemCount:
                          Get.find<GlobalController>().skillDataList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final skill =
                            Get.find<GlobalController>().skillDataList[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                      child: Text(
                                        '${skill.skill}',
                                        style: TextStyle(fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                      child: Container(
                                        width: 70.0,
                                        height: 10.0,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.lightBlue,
                                              Colors.lightBlue,
                                              Colors.white,
                                              Colors.white
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
                      ),



                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: const AlignmentDirectional(-1.00, 0.00),
                        child:  Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 30, 0, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${globalController.name.value}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${globalController.bio.value}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 15, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.account_box_outlined,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                                width:
                                    10.0), // Add some space between the icon and text
                            Text(
                              'PROFILE',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 8,
                        endIndent: 10,
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                        child: Text(
                          'HIghly motivated and committed medical assistant with proven history of superior performance at individual, uses and organizational levels. Strong ability to multitask and prioritize workloads with little or no supervision, detail-oriented deadline driven environmen',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 15, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.group,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                                width:
                                    10.0), // Add some space between the icon and text
                            Text(
                              'WORKING EXPERIENCE',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 8,
                        endIndent: 10,
                        color: Colors.black,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
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

                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      '${work.positionTitle}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      '${work.startDateController.text} - ${work.endDateController.text}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      '${work.workSummary} ${work.location} ',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                        ),
                      ),



                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
        <title>Your Resume</title>
        <!-- Include any necessary stylesheets or meta tags here -->
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
            grid-template-columns: 2fr 1fr;
        }
        .img_box{
          height: 7rem;
          width: 7rem;
          overflow: hidden;
          display: flex;
          align-items: center;
          justify-content: center;
          border-radius: 50%;
      }
      .img_box img{
          height: 100%;
          width: 100%;
      }
      .left_section{
          display: flex;
          flex-direction: column;
          padding: 2rem 1rem;
          gap: 2rem;
          text-align: left;
      }
      
      .info_box{
          width: 100%;
          display: flex;
          flex-direction: column;
          gap: 1rem;
          padding: 1rem 1rem;
      }
      .education{
          width: 100%;
          display: flex;
          flex-direction: column;
          gap: 1rem;
          padding: 1rem 1rem;
      }
      .img_container{
          display: flex;
          align-items: center;
          justify-content: center;
      }
      .right_section{
          display: flex;
          flex-direction: column;
          gap: .5rem;
         padding: 2rem 1rem;
      }
      .right_section p{
          width: 95%!important;
          display: flex;
          flex-direction: column;
          text-align: left;
          list-style: none;
         
      }
      .right_section ul li{
          margin-left:1.5rem ;
         
      }
      .right_section ul li {
          width: 95%!important;
      }
      .work_history{
          display: flex;
          flex-direction: column;
          gap: 1rem;
      }
      .heading{
          background-color: aliceblue;
          padding: 3rem 1rem;
          
      }
      .certifications{
        padding: 1rem;
        display: flex;
        flex-direction: column;
        gap: .5rem;
      }
      .skills{
          padding: 1rem;
          display: flex;
          flex-direction: column;
          gap: .5rem;
      
      }
      .skills ul{
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 1rem;
      }
      .professional_summary{
          padding: 1rem;
          display: flex;
          flex-direction: column;
          gap: .5rem;
      }
      .work{
          padding: 1rem;
          display: flex;
          flex-direction: column;
          gap: .5rem;
      }
      hr{
          margin-left: 1rem;
      }
      .info_box p{
          display: flex;
          gap: .5rem;
          align-items: center;
      }
      .certifications ul{
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 1rem;
      }
      .li{
          list-style: none;
      }
      .work  h5,h4,p{
        margin:.1rem;

      }
      .work {
        margin-left:-2.5rem;
      }
      .section-title{
        padding-left: 1rem;
      }
      .para{
      
        padding-left: 1rem;
      }
      .name-box{
        padding-left: 1rem;
      }
      .name-box h1{
        margin:.1rem;
      }
  
      .skill_ul li{
        margin-left:-1rem!important;
      }
      .contact-entry{
        display:flex;
        flex-direction: column;
        gap:.5rem;
      }
      .ul{
        margin-top:-1rem;
      }
      .divider{
        margin-top:-1rem;
      }
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="left_section">
            <div class="name-box">
            <h1 class="name">John Doe</h1>
            <p>Software Developer</p>
            </div>
                <div class="section">
                    <hr class="divider" />
                    <p class="para">
                        Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.
                    </p>
                </div>
                <div class="section">
                    <h2 class="section-title">WORK HISTORY</h2>
                    <hr class="divider" />
                    <ul class="ul">
                        <li class="li">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                                <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                            </div>
                        </li>
                        <!-- Add more work experiences as needed -->
                    </ul>
                </div>
                <div class="section">
                    <h2 class="section-title">EDUCATION</h2>
                    <hr class="divider" />
                    <ul class="ul">
                        <li class="li">
                            <div class="work">
                                <h4 class="customerService">Bachelor of Science in Computer Science</h3>
                                <h5 class="company_name"><span>University of Cityville - Cityville</span> <span>2016 - 2020</span></h5>
                                <p>Studied computer science with a focus on software development and problem-solving.</p>
                            </div>
                        </li>
                        <!-- Add more education details as needed -->
                    </ul>
                </div>
            </div>
            <div class="right_section" style="background-color: grey; color: white;   height: 1146px;">
                <div class="contact-info">
                    <div class="contact-entry">


                    <div>
                    <h4 class="contact-label">Address</h4>
                    <p class="contact-value">123 Main St, Cityville</p>
                    </div>
                     

                    <div>
                    <h4 class="contact-label">Phone</h4>
                    <p class="contact-value">123-456-7890</p>
                    </div>
                      

                    <div>
                    <h4 class="contact-label">E-mail</h4>
                    <p class="contact-value">john.doe@example.com</p>
                    </div>
                       
                    </div>
                </div>
            
                <div >
                    <h2 class="section-title">SKILLS</h2>
                    <hr class="divider" />
                    <ul class="skill_ul" >
                        <li>JavaScript</li>
                        <!-- Add more skills as needed -->
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
        <title>Your Resume</title>
        <!-- Include any necessary stylesheets or meta tags here -->
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
            grid-template-columns: 2fr 1fr;
        }
        .img_box{
          height: 7rem;
          width: 7rem;
          overflow: hidden;
          display: flex;
          align-items: center;
          justify-content: center;
          border-radius: 50%;
      }
      .img_box img{
          height: 100%;
          width: 100%;
      }
      .left_section{
          display: flex;
          flex-direction: column;
          padding: 2rem 1rem;
          gap: 2rem;
          text-align: left;
      }
      
      .info_box{
          width: 100%;
          display: flex;
          flex-direction: column;
          gap: 1rem;
          padding: 1rem 1rem;
      }
      .education{
          width: 100%;
          display: flex;
          flex-direction: column;
          gap: 1rem;
          padding: 1rem 1rem;
      }
      .img_container{
          display: flex;
          align-items: center;
          justify-content: center;
      }
      .right_section{
          display: flex;
          flex-direction: column;
          gap: .5rem;
         padding: 2rem 1rem;
      }
      .right_section p{
          width: 95%!important;
          display: flex;
          flex-direction: column;
          text-align: left;
          list-style: none;
         
      }
      .right_section ul li{
          margin-left:1.5rem ;
         
      }
      .right_section ul li {
          width: 95%!important;
      }
      .work_history{
          display: flex;
          flex-direction: column;
          gap: 1rem;
      }
      .heading{
          background-color: aliceblue;
          padding: 3rem 1rem;
          
      }
      .certifications{
        padding: 1rem;
        display: flex;
        flex-direction: column;
        gap: .5rem;
      }
      .skills{
          padding: 1rem;
          display: flex;
          flex-direction: column;
          gap: .5rem;
      
      }
      .skills ul{
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 1rem;
      }
      .professional_summary{
          padding: 1rem;
          display: flex;
          flex-direction: column;
          gap: .5rem;
      }
      .work{
          padding: 1rem;
          display: flex;
          flex-direction: column;
          gap: .5rem;
      }
      hr{
          margin-left: 1rem;
      }
      .info_box p{
          display: flex;
          gap: .5rem;
          align-items: center;
      }
      .certifications ul{
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 1rem;
      }
      .li{
          list-style: none;
      }
      .work  h5,h4,p{
        margin:.1rem;

      }
      .work {
        margin-left:-2.5rem;
      }
      .section-title{
        padding-left: 1rem;
      }
      .para{
      
        padding-left: 1rem;
      }
      .name-box{
        padding-left: 1rem;
      }
      .name-box h1{
        margin:.1rem;
      }
  
      .skill_ul li{
        margin-left:-1rem!important;
      }
      .contact-entry{
        display:flex;
        flex-direction: column;
        gap:.5rem;
      }
      .ul{
        margin-top:-1rem;
      }
      .divider{
        margin-top:-1rem;
      }
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="left_section">
            <div class="name-box">
            <h1 class="name">John Doe</h1>
            <p>Software Developer</p>
            </div>
                <div class="section">
                    <hr class="divider" />
                    <p class="para">
                        Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.
                    </p>
                </div>
                <div class="section">
                    <h2 class="section-title">WORK HISTORY</h2>
                    <hr class="divider" />
                    <ul class="ul">
                        <li class="li">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                                <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                            </div>
                        </li>
                        <!-- Add more work experiences as needed -->
                    </ul>
                </div>
                <div class="section">
                    <h2 class="section-title">EDUCATION</h2>
                    <hr class="divider" />
                    <ul class="ul">
                        <li class="li">
                            <div class="work">
                                <h4 class="customerService">Bachelor of Science in Computer Science</h3>
                                <h5 class="company_name"><span>University of Cityville - Cityville</span> <span>2016 - 2020</span></h5>
                                <p>Studied computer science with a focus on software development and problem-solving.</p>
                            </div>
                        </li>
                        <!-- Add more education details as needed -->
                    </ul>
                </div>
            </div>
            <div class="right_section" style="background-color: grey; color: white;   height: 1146px;">
                <div class="contact-info">
                    <div class="contact-entry">


                    <div>
                    <h4 class="contact-label">Address</h4>
                    <p class="contact-value">123 Main St, Cityville</p>
                    </div>
                     

                    <div>
                    <h4 class="contact-label">Phone</h4>
                    <p class="contact-value">123-456-7890</p>
                    </div>
                      

                    <div>
                    <h4 class="contact-label">E-mail</h4>
                    <p class="contact-value">john.doe@example.com</p>
                    </div>
                       
                    </div>
                </div>
            
                <div >
                    <h2 class="section-title">SKILLS</h2>
                    <hr class="divider" />
                    <ul class="skill_ul" >
                        <li>JavaScript</li>
                        <!-- Add more skills as needed -->
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
