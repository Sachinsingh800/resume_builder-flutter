// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/global_controller.dart';
import '../controller/postResume.dart';
import '../screen/PDFFormat.dart';
import '../widget/pannel_widget.dart';

class ThirdResumeTemplate extends StatefulWidget {
  File? image;
  final String? code;
  final String? resumeId;
   ThirdResumeTemplate({Key? key, this.image, this.code, this.resumeId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ThirdResumeTemplateState createState() => _ThirdResumeTemplateState();
}

class _ThirdResumeTemplateState extends State<ThirdResumeTemplate> {

  final GlobalKey genKey = GlobalKey();
  final screenshotController = ScreenshotController();
  final pdf = pw.Document();
  bool _isLoading = false;



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
                        height: 20,
                      ),
                       Text(
                        'PROFILE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: globalController.fontWeight.value,
                          letterSpacing: 2.0,
                        ),
                      ),
                       Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 0),
                        child: Text(
                          "${globalController.bio.value}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                        indent: 8,
                        endIndent: 10,
                        color: Colors.black,
                      ),
                       Text(
                        'INTEREST',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: globalController.fontWeight.value,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.photo_camera_outlined,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.pedal_bike_outlined,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.pool_outlined,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.scuba_diving_outlined,
                                  color: Colors.black,
                                ),
                              ])),
                      const Divider(
                        thickness: 1,
                        indent: 8,
                        endIndent: 10,
                        color: Colors.black,
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                       Text(
                        'REFERENCE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: globalController.fontWeight.value,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                          Get.find<GlobalController>().referenceDataList.length,
                          itemBuilder: (context, index) {
                            final reference =
                            Get.find<GlobalController>().referenceDataList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      '${reference.name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: globalController.fontWeight.value,
                                      ),
                                    ),
                                     Text(
                                      '${reference.position}, ${reference.company}, ph: ${reference.phone}, email: ${reference.email}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 1,
                        indent: 8,
                        endIndent: 10,
                        color: Colors.black,
                      ),
                       Text(
                        'CONTACT ME',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 2.0,
                          fontSize: 18,
                          fontWeight: globalController.fontWeight.value,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFFd3e9e7),
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
                          color: Color(0xff68768f),
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFd3e9e7)),
                          child: const Icon(
                            Icons.phone,
                            size: 15,
                          ),
                        ),
                      ),
                       Text(
                        '${globalController.phone.value}',
                        style: TextStyle(
                          color: Color(0xff68768f),
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xFFd3e9e7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on,
                            size: 15,
                          ),
                        ),
                      ),
                       Text(
                        '${globalController.address.value} ${globalController.state.value} ${globalController.country.value} ${globalController.phone.value}',
                        style: TextStyle(
                          color: Color(0xff68768f),
                          fontSize: 12,
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
                      const SizedBox(height: 27),
                       Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 22, 0, 0),
                        child: Text(
                          'EDUCATION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontSize: 18,
                            fontWeight: globalController.fontWeight.value,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                          Get.find<GlobalController>().educationDataList.length,
                          itemBuilder: (context, index) {
                            final education =
                            Get.find<GlobalController>().educationDataList[index];
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      education.degree,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: globalController.fontWeight.value,
                                      ),
                                    ),
                                  ),
                                   Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      '${education.startDateController.text} - ${education.endDateController.text}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: globalController.fontWeight.value,
                                      ),
                                    ),
                                  ),
                                   Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      '${education.schoolName} ${education.schoolLocation} ${education.fieldOfStudy}',
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                        ),
                      ),




                      const SizedBox(height: 10),
                       Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 15, 0, 0),
                        child: Text(
                          'EXPERIENCE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontSize: 18,
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
                                              fontWeight: FontWeight.w600,
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
                                  ),



                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 0),
                                    child: Text(
                                      '${work.positionTitle} at ${work.companyName}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: globalController.fontWeight.value,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(6, 15, 0, 5),
                                    child: Text(
                                      '${work.startDateController.text} - ${work.endDateController.text} \n ${work.workSummary}',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                        ),
                      ),



                      const SizedBox(height: 10),
                       Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 10, 0, 0),
                        child: Text(
                          'MY PRO SKILL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontSize: 18,
                            fontWeight: globalController.fontWeight.value,
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // Set the number of items in a row
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
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(6, 10, 50, 0),
                                            child: Text(
                                              '${skill.skill}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: globalController.fontWeight.value,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(6, 10, 0, 0),
                                            child: Text(
                                              'PHOTOSHOP',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: globalController.fontWeight.value,
                                              ),
                                            ),
                                          ),
                                        ]),
                                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(6, 10, 35, 0),
                                        child: Container(
                                          width: 70.0,
                                          height: 10.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                                Color(0xFFd3e9e7),
                                                Color(0xFFd3e9e7)
                                              ],
                                              stops: [
                                                0.8,
                                                0.0,
                                                0.0,
                                                1.0
                                              ], // Adjust the stop values to control the filling level
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                        child: Container(
                                          width: 70.0,
                                          height: 10.0,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                                Color(0xFFd3e9e7),
                                                Color(0xFFd3e9e7)
                                              ],
                                              stops: [
                                                0.2,
                                                0.0,
                                                0.0,
                                                1.0
                                              ], // Adjust the stop values to control the filling level
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              );
                            },
                          )
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
  margin:0;
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
  
  .iconContainer {
    width: 1.5625rem ; /* 1.5625rem */
    height: 1.5625rem ; /* 1.5625rem */
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
    align-items:center;1

  }
  .skillsHeader {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: .5rem;
  }

  .skillsHeader h3{
    margin-left: .5rem;
  }
  .skill h3{
    margin-left: 2rem;
  }

  .skillsHeader ul{
   list-style: none;
  padding: 0rem 2rem 0rem 0rem;

  }
  .skillsHeader ul li{
  display: grid;
  grid-template-columns: 1fr 1fr;
  padding: 0rem 1rem;

  }
  .skillsHeader2{
    padding: 1.5rem;
  }
  .skillsHeader2 h2{
    display: flex;
    align-items: center;
    gap: .5rem;
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
    padding: 1rem;
    height: 13rem;
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
    margin-top:-4rem;
  }
  .professionalSkillsHeader{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 1rem;
  }
  .professionalSkillsHeader h2{
    display: flex;
    align-items: center;
    gap: .5rem;

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
    background-color: white;
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
.contactInfo p{
    margin:0rem;
}
.skill-info li h4,h5,p{
    margin:0rem;
}
.skill-info{
 display:grid;
 grid-template-columns: 1fr ;
gap:.8rem;
}

.divider{
    margin-top:-2rem;
    margin-left: .5rem;
}
.Profile-divider{
  margin-top:-2rem;
}
.work-divider{
    margin-top:-1rem;
}
.objectiveHeader p,h1{
    margin:0rem; 
}

.skill-list  li{
  width:100%;
  padding:.2rem;
  list-style:none;
}
.skill-divider{
  margin-top:-1rem;
  width:80%;
  margin-left: 2rem;
}
.work-ul{
  margin-top:-1rem;
  margin-left: -1rem!important;
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
            <div class="Left_container" style="background-color: #3498db; color: white;     height: 1210px;">
                <div class="img_container">
                    <div class="img_box" style="height: 150px; width: 150px;">
                        <img src="" alt="dp">
                    </div>
                </div>
    
                <div class="info_box">
                    <h3 >CONTACT</h3>
                   <div class="divider"><hr ></div> 
                    <div class="contactInfo">
                        <div class="iconContainer" style="color: black;">
                        <img class="icon" src="" alt="dp" />
                        </div>
                        <p class="email" >sample.email@example.com</p>
                    </div>
                    <div class="contactInfo">
                        <div class="iconContainer" style="color: black;">
                        <img class="icon" src="" alt="dp" />
                        </div>
                        <p class="email" >123-456-7890</p>
                    </div>
                    <div class="contactInfo">
                        <div class="iconContainer" style="color: black;">
                     
                        <img class="icon" src="" alt="dp" />
                 
                        </div>
                        <p class="email" >123 Address St, 56789</p>
                    </div>
                </div>
    
                <div class="skillsHeader">
                    <h3 >EDUCATION</h3>
                    <div class="divider"><hr ></div> 
                    <ul class="skill-info">
                        <li >
                            <h4>Master's Degree</h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Example</p>
                        </li>
                        <li >
                            <h4>Master's Degree</h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Example</p>
                        </li>
                        <li >
                            <h4>Master's Degree</h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Example</p>
                        </li>
                        <!-- Add more education items as needed -->
                    </ul>
                </div>
    
                <div class="skill">
                    <h3 >PERSONAL SKILLS</h3>
                    <div class="skill-divider"><hr ></div> 
                    <ul class="skill-list">
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                       
                        <!-- Add more skills as needed -->
                    </ul>
                </div>
    
                <div class="skillsHeader">
                    <h3 >LANGUAGES</h3>
                    <div class="divider"><hr ></div> 
                    <ul>
                        <li >
                            <span>English</span>
                            <!-- You may add a progress bar here -->
                        </li>
                        <!-- Add more languages as needed -->
                    </ul>
                </div>
            </div>
    
            <div>
                <div class="objectiveHeader">
                    <h1 class="person_name" style="color: #2980b9; font-family: 'Arial', sans-serif; ">
                        John Doe
                    </h1>
                    <p class="objectiveText">Web Developer</p>
                </div>
    
                <div class="skillsHeader2">
                    <h3>PROFILE</h3>
                    <div class="Profile-divider"><hr ></div> 
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius
                        bibendum.</p>
                </div>
    
                <div class="professionalSkillsHeader">
                    <div>
                        <h3>WORKING EXPERIENCE</h3>
                        <div class="work-divider"><hr ></div> 
                    </div>
                    <ul class="work-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name"><span>Example Corp - New York</span> <span>Jan 2018 - Dec 2020</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces, ensuring responsiveness,
                                    and collaborating with the back-end team to integrate with server-side logic.</p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name"><span>Example Corp - New York</span> <span>Jan 2018 - Dec 2020</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces, ensuring responsiveness,
                                    and collaborating with the back-end team to integrate with server-side logic.</p>
                            </div>
                        </li>
                        <!-- Add more work experience items as needed -->
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
  margin:0;
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
  
  .iconContainer {
    width: 1.5625rem ; /* 1.5625rem */
    height: 1.5625rem ; /* 1.5625rem */
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
    align-items:center;1

  }
  .skillsHeader {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: .5rem;
  }

  .skillsHeader h3{
    margin-left: .5rem;
  }
  .skill h3{
    margin-left: 2rem;
  }

  .skillsHeader ul{
   list-style: none;
  padding: 0rem 2rem 0rem 0rem;

  }
  .skillsHeader ul li{
  display: grid;
  grid-template-columns: 1fr 1fr;
  padding: 0rem 1rem;

  }
  .skillsHeader2{
    padding: 1.5rem;
  }
  .skillsHeader2 h2{
    display: flex;
    align-items: center;
    gap: .5rem;
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
    padding: 1rem;
    height: 13rem;
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
    margin-top:-4rem;
  }
  .professionalSkillsHeader{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 1rem;
  }
  .professionalSkillsHeader h2{
    display: flex;
    align-items: center;
    gap: .5rem;

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
    background-color: white;
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
.contactInfo p{
    margin:0rem;
}
.skill-info li h4,h5,p{
    margin:0rem;
}
.skill-info{
 display:grid;
 grid-template-columns: 1fr ;
gap:.8rem;
}

.divider{
    margin-top:-2rem;
    margin-left: .5rem;
}
.Profile-divider{
  margin-top:-2rem;
}
.work-divider{
    margin-top:-1rem;
}
.objectiveHeader p,h1{
    margin:0rem; 
}

.skill-list  li{
  width:100%;
  padding:.2rem;
  list-style:none;
}
.skill-divider{
  margin-top:-1rem;
  width:80%;
  margin-left: 2rem;
}
.work-ul{
  margin-top:-1rem;
  margin-left: -1rem!important;
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
            <div class="Left_container" style="background-color: #3498db; color: white;     height: 1210px;">
                <div class="img_container">
                    <div class="img_box" style="height: 150px; width: 150px;">
                        <img src="" alt="dp">
                    </div>
                </div>
    
                <div class="info_box">
                    <h3 >CONTACT</h3>
                   <div class="divider"><hr ></div> 
                    <div class="contactInfo">
                        <div class="iconContainer" style="color: black;">
                        <img class="icon" src="" alt="dp" />
                        </div>
                        <p class="email" >sample.email@example.com</p>
                    </div>
                    <div class="contactInfo">
                        <div class="iconContainer" style="color: black;">
                        <img class="icon" src="" alt="dp" />
                        </div>
                        <p class="email" >123-456-7890</p>
                    </div>
                    <div class="contactInfo">
                        <div class="iconContainer" style="color: black;">
                     
                        <img class="icon" src="" alt="dp" />
                 
                        </div>
                        <p class="email" >123 Address St, 56789</p>
                    </div>
                </div>
    
                <div class="skillsHeader">
                    <h3 >EDUCATION</h3>
                    <div class="divider"><hr ></div> 
                    <ul class="skill-info">
                        <li >
                            <h4>Master's Degree</h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Example</p>
                        </li>
                        <li >
                            <h4>Master's Degree</h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Example</p>
                        </li>
                        <li >
                            <h4>Master's Degree</h4>
                            <h5>2015 - 2019</h5>
                            <p>University of Example</p>
                        </li>
                        <!-- Add more education items as needed -->
                    </ul>
                </div>
    
                <div class="skill">
                    <h3 >PERSONAL SKILLS</h3>
                    <div class="skill-divider"><hr ></div> 
                    <ul class="skill-list">
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                        <li >
                            Web Development   
                        </li>
                       
                        <!-- Add more skills as needed -->
                    </ul>
                </div>
    
                <div class="skillsHeader">
                    <h3 >LANGUAGES</h3>
                    <div class="divider"><hr ></div> 
                    <ul>
                        <li >
                            <span>English</span>
                            <!-- You may add a progress bar here -->
                        </li>
                        <!-- Add more languages as needed -->
                    </ul>
                </div>
            </div>
    
            <div>
                <div class="objectiveHeader">
                    <h1 class="person_name" style="color: #2980b9; font-family: 'Arial', sans-serif; ">
                        John Doe
                    </h1>
                    <p class="objectiveText">Web Developer</p>
                </div>
    
                <div class="skillsHeader2">
                    <h3>PROFILE</h3>
                    <div class="Profile-divider"><hr ></div> 
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius
                        bibendum.</p>
                </div>
    
                <div class="professionalSkillsHeader">
                    <div>
                        <h3>WORKING EXPERIENCE</h3>
                        <div class="work-divider"><hr ></div> 
                    </div>
                    <ul class="work-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name"><span>Example Corp - New York</span> <span>Jan 2018 - Dec 2020</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces, ensuring responsiveness,
                                    and collaborating with the back-end team to integrate with server-side logic.</p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-End Developer</h4>
                                <h5 class="company_name"><span>Example Corp - New York</span> <span>Jan 2018 - Dec 2020</span>
                                </h5>
                                <p>Responsible for developing and maintaining user interfaces, ensuring responsiveness,
                                    and collaborating with the back-end team to integrate with server-side logic.</p>
                            </div>
                        </li>
                        <!-- Add more work experience items as needed -->
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
