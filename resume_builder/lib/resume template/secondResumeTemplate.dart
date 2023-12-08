import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/global_controller.dart';
import '../controller/postResume.dart';
import '../pdf_viewer_screen.dart';
import '../screen/PDFFormat.dart';
import 'package:http/http.dart' as http;

import '../widget/pannel_widget.dart';

class SecondResumeTemplate extends StatefulWidget {
  File? image;
  final String? code;
  final String? resumeId;
   SecondResumeTemplate({Key? key, this.image, this.code, this.resumeId}) : super(key: key);

  @override
  _SecondResumeTemplateState createState() => _SecondResumeTemplateState();
}

class _SecondResumeTemplateState extends State<SecondResumeTemplate> {
  final GlobalKey genKey = GlobalKey();
  final screenshotController = ScreenshotController();
  final pdf = pw.Document();
  bool _isLoading = false;

  Future<void> _saveAndOpenPdf(String pdfBytes) async {
    print("working");
    Directory? directory;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // if platform is android
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          print("No download directory");
          directory = await getExternalStorageDirectory();
          String tempPath = directory!.path;
          File file = File('$tempPath/$timestamp.pdf');
          await file.writeAsBytes(pdfBytes.codeUnits, flush: true);
          final String filePath = file.absolute.path;
          final Uri uri = Uri.file(filePath);
        } else {
          print("Download directory exists");
          String tempPath = directory.path;
          File file = File('$tempPath/$timestamp.pdf');
          await file.writeAsBytes(pdfBytes.codeUnits, flush: true);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PDFViewerScreen(
                    file: file,
                  )));
        }
      }
    } catch (error) {
      print('Error saving and opening PDF: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving and opening PDF: $error'),
        ),
      );
      // Handle the error (e.g., show an error message)
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.code == "allResume"){
      GlobalController globalController = Get.find();
      fetchData().then((data) {
        // Update the text fields with data from the API response
        setState(() {
          globalController.name.value = data['data']['name'] ?? 'no name';
          // addressController.text = data['data']['address']['address'] ?? 'no email';
          // cityController.text = data['data']['address']['city'] ?? 'no email';
          // postcodeController.text = data['data']['address']['postalCode'] ?? 'no email';
          // stateController.text = data['data']['address']['state'] ?? 'no email';
          // countryController.text = data['data']['address']['country'] ?? 'no email';
          // jobTitleController.text = data['data']['jobTitle'] ?? 'no jobTitle';
          // bioController.text = data['data']['summary'] ?? 'no summary';
          // dateOfBirthController.text = data['data']['dob'] ?? 'no dob';
          // genderController.text = data['data']['gender'] ?? 'no gender';
          // url = data['data']['profilePicture']['url'] ?? '';
          // phoneController.text = data['data']['contact']['phone'] ?? 'no email';
          // emailController.text = data['data']['contact']['email'] ?? 'no email';

        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch data from API ${error.toString()}"),
          ),
        );
      });
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    GlobalController globalController = Get.find();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    GlobalController globalController = Get.find();
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
                  decoration: BoxDecoration(
                    color: Color(globalController.color.value),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: widget.image  != null?
                          Image.file(
                            widget.image!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ):
                          Image.asset(
                            "assets/images/person.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                      Text(
                        globalController.email.value,
                        style: TextStyle(
                          color: Color(0xff68768f),
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.phone,
                            size: 15,
                          ),
                        ),
                      ),
                      Text(
                        globalController.phone.value,
                        style: TextStyle(
                          color: Color(0xff68768f),
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.location_on,
                            size: 15,
                          ),
                        ),
                      ),
                      Text(
                        '${globalController.state.value} ${globalController.country.value} ${globalController.postalCode.value}',
                        style: TextStyle(
                          color: Color(0xff68768f),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'EDUCATION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: globalController.fontWeight.value,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child:
                                ListView.builder(
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
                                            Text(
                                              education.schoolName,
                                              style: TextStyle(
                                                  fontSize: 13, fontWeight: globalController.fontWeight.value),
                                            ),
                                            Wrap(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 5),
                                                  child: Text(
                                                    education.schoolLocation,
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                                Text(
                                                  education.startDateController.text,
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                                Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                                Text(
                                                  education.endDateController.text,
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                              ],
                                            )
                                          ]),
                                    );
                                  },
                                ),
                              //   Text(
                              //     'Associate of applied science medical assisting',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              //   child: Text(
                              //     'Ohio Business College',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.w900,
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              //   child: Text(
                              //     'Elyufia, OH',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //     ),
                              //   ),
                              // ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color(0xFFA5C5C5),
                        ),
                        alignment: AlignmentDirectional(-1.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            globalController.name.value,
                            style: TextStyle(
                              color: Color(0xFF729085),
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 20, 0, 0),
                        child: Text(
                          'CERTIFICATIONS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: globalController.fontWeight.value,
                          ),
                        ),
                      ),

                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Get.find<GlobalController>()
                              .certificationDataList
                              .length,
                          itemBuilder: (context, index) {
                            final certificate = Get.find<GlobalController>()
                                .certificationDataList[index];
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      '${certificate.title} ${certificate.issuingOrganization} ${certificate.dateController.text}',
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                        ),
                      ),

                      Divider(
                        thickness: 1,
                        indent: 8,
                        endIndent: 10,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 10, 0, 10),
                        child: Text(
                          'SKILLS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: globalController.fontWeight.value,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                        child: Container(
                          width: 250,
                          height: 60,
                          decoration: BoxDecoration(),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Set the number of items in a row
                              crossAxisSpacing: 10.0, // Add horizontal spacing between items
                              mainAxisSpacing: 10.0, // Add vertical spacing between items
                            ),
                            itemCount: Get.find<GlobalController>().skillDataList.length,
                            itemBuilder: (context, index) {
                              final skill = Get.find<GlobalController>().skillDataList[index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      skill.skill!,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      skill.proficiencyLevel!,
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ),
                      ),
                      Divider(
                          thickness: 1,
                          indent: 8,
                          endIndent: 10,
                          color: Colors.black),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 12, 0, 0),
                        child: Text(
                          'PROFESSIONAL SKILLS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: globalController.fontWeight.value,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 8, 12, 0),
                        child: Text(
                          '${globalController.bio.value}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 7,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                        indent: 8,
                        endIndent: 8,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 10, 0, 0),
                        child: Text(
                          'WORK HISTORY',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: globalController.fontWeight.value,
                          ),
                        ),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 4, 8, 0),
                                    child: Text(
                                      '${work.startDateController.text} - ${work.endDateController.text}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                                    child: RichText(
                                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${work.companyName} ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 6,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${work.positionTitle} ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: globalController.fontWeight.value,
                                              fontSize: 6,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${work.workSummary} ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 7.5,
                                            ),
                                          )
                                        ],
                                        style: TextStyle(
                                          fontSize: 6,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 2, 0, 0),
                                    child: Text(
                                      '- ${work.workSummary} ',
                                      style: TextStyle(
                                        fontSize: 7,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 2, 0, 0),
                                    child: Text(
                                      '- ${work.workSummary}.',
                                      style: TextStyle(
                                        fontSize: 7,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                ]);
                          },
                        ),
                      ),

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
    <link rel="stylesheet" href="styles.css"> <!-- You may link your stylesheet if you have one -->
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
    gap: 1rem;
    height: 1210px;
}
  
.name_container{
    display: flex;
    flex-direction: column;
    gap: 1rem;
    padding: 1.5rem;
    background-color: #c2c3c4;
    height: 14rem;
}
  .container {
    padding: 13px 0 0 0;
  }
  
  .name {
    color: white;
  }
  
  .hr {
    margin-left: 2px;
    margin-right: 30px;
    color: #A2A2A2;
    margin-top:-1rem;
  }
  
  .iconContainer {
    width: 20px;
    height: 20px;
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
    gap: .5rem;

  }
  .skillsHeader {
    padding: 0rem 1.5rem;
  }


  .skillsHeader ul{
   margin-left: -1.2rem;
    

  }

  .skillsHeader2 ul{
    margin-left: -1.5rem;
  }
  .professionalSkillsHeader ul{
    margin-left: 1.5rem;
  }

  .info_box{
    display: flex;
    flex-direction: column;
    gap:.5rem;
  }
  
  .educationHeader{
    padding: 1.5rem;
  }
  .objectiveHeader{
    padding: 1rem;
   height: max-content;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
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
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .work_history{
    list-style: none;
    padding: 0rem 1rem;
  }
  .Projects{
    list-style: none;
    padding: 0rem 1rem;
  }
  .project_title{
    display:flex ;
    justify-content: space-between;
  }
  .contactInfo p{
      margin:0rem;
  }
  .edu-ul h4,p{
    margin:0rem; 
  }
  .work-ul li h4,p{
    margin:0rem; 
  } 
  .work-ul {
      margin:-1rem;
      flex-direction: column;
      display: flex;
      gap:.5rem;
  }
    .edu-ul{
        flex-direction: column;
        display: flex;
        gap:.5rem;
    }
  .Projects-ul li h4,p{
    margin:0rem; 
  }

  .Projects-ul{
      margin-top:-1rem;
      flex-direction: column;
      display: flex;
      gap:.5rem;
  }
  .icon{
    height:1rem;
    width:1rem;
  
  }

    </style>
    <title>Your Page Title</title>
</head>

<body>
    <div class="main">
        <div class="Left_container" style="background-color: grey; color:white;">
            <div class="name_container">
                <h1 class="name">
                    John Doe
                </h1>
                <hr class="hr" />
                <div class="info_box">
                    <div class="contactInfo">
                    <div class="iconContainer" style="color: black;">
                    <img class="icon" src="" alt="dp" />
                    </div>
                        <p class="email">
                            john.doe@example.com
                        </p>
                    </div>
                    <div class="contactInfo">
                    <div class="iconContainer" style="color: black;">
                    <img class="icon" src="" alt="dp" />
                    </div>
                        <p class="email">
                            123-456-7890
                        </p>
                    </div>
                    <div class="contactInfo">
                    <div class="iconContainer" style="color: black;">
                    <img class="icon" src="" alt="dp" />
                    </div>
                        <p class="email">
                            123 Main Street, 56789
                        </p>
                    </div>
                </div>
            </div>
            <div class="skillsHeader">
                <h3>SKILLS</h3>
                <ul>
                    <li>JavaScript</li>
                    <li>React</li>
                    <!-- Add more skills as needed -->
                </ul>
            </div>
            <div class="educationHeader">
                <h3>EDUCATION</h3>
                <div class="edu-ul">
                    <h4>University of Example</h4>
                    <p>Master's Degree</p>
                    <p>2015 - 2019</p>
                </div>
                <div class="edu-ul">
                    <h4>University of Example</h4>
                    <p>Master's Degree</p>
                    <p>2015 - 2019</p>
                </div>
                <div class="edu-ul">
                    <h4>University of Example</h4>
                    <p>Master's Degree</p>
                    <p>2015 - 2019</p>
                </div>
                <!-- Add more education items as needed -->
            </div>
        </div>
        <div>
            <div class="objectiveHeader" style="background-color: #E5E5E5;">
                <h3>CAREER OBJECTIVE</h3>
                <p class="objectiveText">
                    Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                    Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                    Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                </p>
            </div>
            <div class="workHeader">
                <h3>WORK HISTORY</h3>
                <ul class="work-ul">
                    <li>
                        <h4>Front-End Developer</h4>
                        <p>Example Company, New York</p>
                        <p>Responsible for developing and maintaining user interfaces...</p>
                    </li>
                    <li>
                        <h4>Front-End Developer</h4>
                        <p>Example Company, New York</p>
                        <p>Responsible for developing and maintaining user interfaces...</p>
                    </li>
                    <li>
                        <h4>Front-End Developer</h4>
                        <p>Example Company, New York</p>
                        <p>Responsible for developing and maintaining user interfaces...</p>
                    </li>
                    <!-- Add more work history items as needed -->
                </ul>
            </div>
            <div class="workHeader">
                <h3>Projects</h3>
                <ul class="Projects-ul">
                    <li>
                        <h4 class="project_title">
                            <span>Project A</span> <span>2022</span>
                        </h4>
                        <p>Project link</p>
                        <p>Project description</p>
                    </li>
                    <li>
                        <h4 class="project_title">
                            <span>Project A</span> <span>2022</span>
                        </h4>
                        <p>Project link</p>
                        <p>Project description</p>
                    </li>
                    <li>
                        <h4 class="project_title">
                            <span>Project A</span> <span>2022</span>
                        </h4>
                        <p>Project link</p>
                        <p>Project description</p>
                    </li>
                    <!-- Add more project items as needed -->
                </ul>
            </div>
        </div>
    </div>
</body>

</html>
      """);
              await _saveAndOpenPdf(pdfBytes);
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
    <link rel="stylesheet" href="styles.css"> <!-- You may link your stylesheet if you have one -->
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
    gap: 1rem;
    height: 1210px;
}
  
.name_container{
    display: flex;
    flex-direction: column;
    gap: 1rem;
    padding: 1.5rem;
    background-color: #c2c3c4;
    height: 14rem;
}
  .container {
    padding: 13px 0 0 0;
  }
  
  .name {
    color: white;
  }
  
  .hr {
    margin-left: 2px;
    margin-right: 30px;
    color: #A2A2A2;
    margin-top:-1rem;
  }
  
  .iconContainer {
    width: 20px;
    height: 20px;
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
    gap: .5rem;

  }
  .skillsHeader {
    padding: 0rem 1.5rem;
  }


  .skillsHeader ul{
   margin-left: -1.2rem;
    

  }

  .skillsHeader2 ul{
    margin-left: -1.5rem;
  }
  .professionalSkillsHeader ul{
    margin-left: 1.5rem;
  }

  .info_box{
    display: flex;
    flex-direction: column;
    gap:.5rem;
  }
  
  .educationHeader{
    padding: 1.5rem;
  }
  .objectiveHeader{
    padding: 1rem;
   height: max-content;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
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
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .work_history{
    list-style: none;
    padding: 0rem 1rem;
  }
  .Projects{
    list-style: none;
    padding: 0rem 1rem;
  }
  .project_title{
    display:flex ;
    justify-content: space-between;
  }
  .contactInfo p{
      margin:0rem;
  }
  .edu-ul h4,p{
    margin:0rem; 
  }
  .work-ul li h4,p{
    margin:0rem; 
  } 
  .work-ul {
      margin:-1rem;
      flex-direction: column;
      display: flex;
      gap:.5rem;
  }
    .edu-ul{
        flex-direction: column;
        display: flex;
        gap:.5rem;
    }
  .Projects-ul li h4,p{
    margin:0rem; 
  }

  .Projects-ul{
      margin-top:-1rem;
      flex-direction: column;
      display: flex;
      gap:.5rem;
  }
  .icon{
    height:1rem;
    width:1rem;
  
  }

    </style>
    <title>Your Page Title</title>
</head>

<body>
    <div class="main">
        <div class="Left_container" style="background-color: grey; color:white;">
            <div class="name_container">
                <h1 class="name">
                    John Doe
                </h1>
                <hr class="hr" />
                <div class="info_box">
                    <div class="contactInfo">
                    <div class="iconContainer" style="color: black;">
                    <img class="icon" src="" alt="dp" />
                    </div>
                        <p class="email">
                            john.doe@example.com
                        </p>
                    </div>
                    <div class="contactInfo">
                    <div class="iconContainer" style="color: black;">
                    <img class="icon" src="" alt="dp" />
                    </div>
                        <p class="email">
                            123-456-7890
                        </p>
                    </div>
                    <div class="contactInfo">
                    <div class="iconContainer" style="color: black;">
                    <img class="icon" src="" alt="dp" />
                    </div>
                        <p class="email">
                            123 Main Street, 56789
                        </p>
                    </div>
                </div>
            </div>
            <div class="skillsHeader">
                <h3>SKILLS</h3>
                <ul>
                    <li>JavaScript</li>
                    <li>React</li>
                    <!-- Add more skills as needed -->
                </ul>
            </div>
            <div class="educationHeader">
                <h3>EDUCATION</h3>
                <div class="edu-ul">
                    <h4>University of Example</h4>
                    <p>Master's Degree</p>
                    <p>2015 - 2019</p>
                </div>
                <div class="edu-ul">
                    <h4>University of Example</h4>
                    <p>Master's Degree</p>
                    <p>2015 - 2019</p>
                </div>
                <div class="edu-ul">
                    <h4>University of Example</h4>
                    <p>Master's Degree</p>
                    <p>2015 - 2019</p>
                </div>
                <!-- Add more education items as needed -->
            </div>
        </div>
        <div>
            <div class="objectiveHeader" style="background-color: #E5E5E5;">
                <h3>CAREER OBJECTIVE</h3>
                <p class="objectiveText">
                    Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                    Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                    Experienced web developer with expertise in JavaScript and React, seeking challenging projects to contribute my skills and experience.
                </p>
            </div>
            <div class="workHeader">
                <h3>WORK HISTORY</h3>
                <ul class="work-ul">
                    <li>
                        <h4>Front-End Developer</h4>
                        <p>Example Company, New York</p>
                        <p>Responsible for developing and maintaining user interfaces...</p>
                    </li>
                    <li>
                        <h4>Front-End Developer</h4>
                        <p>Example Company, New York</p>
                        <p>Responsible for developing and maintaining user interfaces...</p>
                    </li>
                    <li>
                        <h4>Front-End Developer</h4>
                        <p>Example Company, New York</p>
                        <p>Responsible for developing and maintaining user interfaces...</p>
                    </li>
                    <!-- Add more work history items as needed -->
                </ul>
            </div>
            <div class="workHeader">
                <h3>Projects</h3>
                <ul class="Projects-ul">
                    <li>
                        <h4 class="project_title">
                            <span>Project A</span> <span>2022</span>
                        </h4>
                        <p>Project link</p>
                        <p>Project description</p>
                    </li>
                    <li>
                        <h4 class="project_title">
                            <span>Project A</span> <span>2022</span>
                        </h4>
                        <p>Project link</p>
                        <p>Project description</p>
                    </li>
                    <li>
                        <h4 class="project_title">
                            <span>Project A</span> <span>2022</span>
                        </h4>
                        <p>Project link</p>
                        <p>Project description</p>
                    </li>
                    <!-- Add more project items as needed -->
                </ul>
            </div>
        </div>
    </div>
</body>

</html>
      """);
              await _saveAndOpenPdf(pdfBytes);
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
