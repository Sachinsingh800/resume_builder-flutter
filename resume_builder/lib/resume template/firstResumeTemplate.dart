import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/controller/postResume.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../pdf_viewer_screen.dart';
import '../screen/PDFFormat.dart';
import '../screen/UserInformation/UserEducation.dart';
import '../widget/pannel_widget.dart';

class FirstResumeTemplate extends StatefulWidget {
  File? image;
  final String? code;
  final String? resumeId;
  FirstResumeTemplate({Key? key, this.image,  this.code, this.resumeId}) : super(key: key);

  @override
  _FirstResumeTemplateState createState() => _FirstResumeTemplateState();
}

class _FirstResumeTemplateState extends State<FirstResumeTemplate> {
  // String? imagePath;
  final GlobalKey genKey = GlobalKey();
  final screenshotController = ScreenshotController();
  final pdf = pw.Document();
  bool _isLoading = false;


  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }
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
          globalController.address.value = data['data']['address']['address'] ?? 'no email';
          globalController.city.value = data['data']['address']['city'] ?? 'no email';
          globalController.postalCode.value = data['data']['address']['postalCode'] ?? 'no email';
          globalController.state.value = data['data']['address']['state'] ?? 'no email';
          globalController.country.value = data['data']['address']['country'] ?? 'no email';
          globalController.jobTitle.value = data['data']['jobTitle'] ?? 'no jobTitle';
          globalController.bio.value = data['data']['summary'] ?? 'no summary';
          globalController.dob.value = data['data']['dob'] ?? 'no dob';
          globalController.gender.value = data['data']['gender'] ?? 'no gender';
          globalController.phone.value = data['data']['contact']['phone'] ?? 'no email';
          globalController.email.value = data['data']['contact']['email'] ?? 'no email';


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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          top: true,
          child: Screenshot(
              key: genKey,
              controller: screenshotController,
              child: SlidingUpPanel(
                minHeight: MediaQuery.of(context).size.height * 0.02,
                maxHeight: MediaQuery.of(context).size.height * 0.3,
                parallaxEnabled: true,
                parallaxOffset: 0.5,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                body: Container(
                  child:
                  ResumeImage(),
                ),
                panelBuilder: (controller)=> PanelWidget(
                  controller: controller,
                  globalController: globalController,
                  callBack: (){
                    voidCallBack();
                  },
                ),
              ))),
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
padding: 3rem 1rem;
height: 1112px;
text-align: left;

}

.info_box{
width: 100%;
display: flex;
flex-direction: column;

padding: 1rem 1rem;
}
.education{
width: 100%;
display: flex;
flex-direction: column;

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
margin:0rem;
}
.certifications ul{
display: grid;
grid-template-columns: 1fr 1fr;

}
.edu{
flex-direction: column;
display: flex;
gap:.5rem;
}
.edu h4,p{
margin:0rem; 
}
.certi-ul {
margin-top:-1rem;
margin-left:-2.7rem;
flex-direction: column;
display: flex;
gap:.5rem;
}
.certi-ul li h5,p{
margin:0rem; 
}
.skill-ul{
margin-top:-1rem;
margin-left:-2.7rem;
}
.line{
margin-top:-1rem;
width:98%;
}
.work-ul{

margin-top:-1rem;
margin-left:-2.7rem;
flex-direction: column;
display: flex;
gap:.5rem;

}
.work-ul li h4,p{
margin:0rem;  
}
    </style>
    <title>Your Page Title</title>
</head>

<body>
    <div class="main">
        <div class="left_section" style="background-color: #3498db; color: white;">
            <div>
                <div class="img_container">
                    <div class="img_box" style="height: 150px; width: 150px;">
                        <!-- Replace the image source with your actual 
                        image URL -->
                        <img src="" alt="dp" />
                    </div>
                </div>

                <div class="info_box">
                    <p>
                        <span>Email: </span>
                        john.doe@example.com
                    </p>
                    <p>
                        <span>Phone: </span>
                        123-456-7890
                    </p>
                    <p>
                        <span>Location: </span>
                        123 Main Street, 56789
                    </p>
                </div>
            </div>
           <div><hr /></div> 
            <div class="education">
                <h3>Education</h3>
                <div class="edu" id="Edu">
                  <div>
                    <h4>University of Example</h4>
                    <p>Master's Degree</p>
                    <p>2015 - 2019</p>
                  </div>
                </div>
                <!-- Add more education items as needed -->
            </div>
        </div>

        <div class="right_section">
            <div class="heading" style="background-color:#3498db;">
                <h1 style="color: white; font-family: 'Arial', sans-serif; ">
                    John Doe
                </h1>
            </div>

            <div class="certifications">
                <h3>Certifications</h3>
                <ul class="certi-ul">
                    <li>
                        <h5>Example Certification</h5>
                        <p>Organization: Certification Organization</p>
                    </li>
                    <li>
                        <h5>Example Certification</h5>
                        <p>Organization: Certification Organization</p>
                    </li>
                    <li>
                        <h5>Example Certification</h5>
                        <p>Organization: Certification Organization</p>
                    </li>
                    <!-- Add more certification items as needed -->
                </ul>
            </div>

         <div class="line"> <hr /></div>  

            <div class="skills">
                <h3>Skills</h3>
                <ul class="skill-ul">
                    <li>Skill 1</li>
                    <li>Skill 2</li>
                    <!-- Add more skills as needed -->
                </ul>
            </div>

            <div class="line"> <hr /></div>  

            <div class="professional_summary">
                <h3>Professional Summary</h3>
                <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                </p>
            </div>

            <div class="line"> <hr /></div>  

            <div class="work">
                <h3>Work History</h3>
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
        </div>
    </div>
</body>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    // var educationData = ${globalController.educationDataList};
    var educationHTML = document.getElementById("Edu").innerHTML;

    for (var i = 0; i < 4; i++) {
      // var item = educationData[i];
      educationHTML +=
        `<div>
            <h4>Anurag</h4>
            <p>Kashyap</p>
        </div>`;
      console.log("Lavda");
    }

    // Update the content of the "Edu" element
    document.getElementById("Edu").innerHTML = educationHTML;
  });
</script>
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

class ResumeImage extends StatefulWidget {
  const ResumeImage({Key? key}) : super(key: key);

  @override
  State<ResumeImage> createState() => _ResumeImageState();
}

class _ResumeImageState extends State<ResumeImage> {
  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.find();
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            // height: double.infinity,
            decoration: BoxDecoration(
              color: Color(globalController.color.value),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                    color: Color(globalController.color.value),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                          child: Text(
                            globalController.name.value,
                            style: TextStyle(
                              color: Color(0xff68768f),
                              fontSize: 19,
                              fontWeight: globalController.fontWeight.value,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          indent: 8,
                          endIndent: 70,
                          color: Color(0xFFA2A2A2),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                globalController.email.value,
                                style: TextStyle(
                                  color: Color(0xff68768f),
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                  size: 12,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  globalController.phone.value,
                                  style: TextStyle(
                                    color: Color(0xff68768f),
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 11,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Container(
                                  width: 100,
                                  child: Wrap(
                                    children: [
                                      Text(
                                        globalController.state.value,
                                        style: TextStyle(
                                          color: Color(0xff68768f),
                                          fontSize: 8,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 2),
                                        child: Text(
                                          globalController.country.value,
                                          style: TextStyle(
                                            color: Color(0xff68768f),
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 2),
                                        child: Text(
                                          globalController.postalCode.value,
                                          style: TextStyle(
                                            color: Color(0xff68768f),
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                  child: Text(
                    'SKILLS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child:
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
                              Text(
                                skill.skill!,
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                skill.proficiencyLevel!,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ListView.builder(
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
                                    fontSize: 13, fontWeight: globalController.fontWeight.value,),
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                  child: Text(
                    'Interest',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.02,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Get.find<GlobalController>()
                        .areaOfInterestDataList
                        .length,
                    itemBuilder: (context, index) {
                      final interest = Get.find<GlobalController>()
                          .areaOfInterestDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          interest.interest!,
                          style: TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: double.infinity,
            decoration: BoxDecoration(
                // color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(globalController.color.value),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 30, 0, 0),
                        child: Text(
                          'CAREER OBJECTIVE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: globalController.fontWeight.value,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 5, 8, 0),
                        child: Text(
                          globalController.bio.value,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                  child: Text(
                    'WORK HISTORY',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ListView.builder(
                    itemCount: Get.find<GlobalController>()
                        .workExperienceDataList
                        .length,
                    itemBuilder: (context, index) {
                      final work = Get.find<GlobalController>()
                          .workExperienceDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                work.companyName,
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      work.location,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Text(
                                    work.startDateController.text,
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
                                    work.endDateController.text,
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                  child: Text(
                    'Certification',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ListView.builder(
                    itemCount: Get.find<GlobalController>()
                        .certificationDataList
                        .length,
                    itemBuilder: (context, index) {
                      final certificate = Get.find<GlobalController>()
                          .certificationDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                certificate.title,
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      certificate.issuingOrganization,
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    certificate.dateController.text,
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                  child: Text(
                    'Internship',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ListView.builder(
                    itemCount: Get.find<GlobalController>()
                        .userInternshipDataList
                        .length,
                    itemBuilder: (context, index) {
                      final internship = Get.find<GlobalController>()
                          .userInternshipDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                internship.companyName,
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      internship.location,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Text(
                                    internship.startDateController.text,
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
                                    internship.endDateController.text,
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                  child: Text(
                    'Awards',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ListView.builder(
                    itemCount:
                        Get.find<GlobalController>().awardDataList.length,
                    itemBuilder: (context, index) {
                      final award =
                          Get.find<GlobalController>().awardDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                award.title,
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      award.issuingOrganization,
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    award.dateController.text,
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                  child: Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ListView.builder(
                    itemCount:
                        Get.find<GlobalController>().projectDataList.length,
                    itemBuilder: (context, index) {
                      final project =
                          Get.find<GlobalController>().projectDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.title,
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      project.description,
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    project.year,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Text(
                                project.link,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                  child: Text(
                    'Languages',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.02,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Get.find<GlobalController>()
                        .knowLanguageDataList
                        .length,
                    itemBuilder: (context, index) {
                      final language = Get.find<GlobalController>()
                          .knowLanguageDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          language.lang,
                          style: TextStyle(
                              fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                  child: Text(
                    'Volunteer Experience',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: globalController.fontWeight.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ListView.builder(
                    itemCount: Get.find<GlobalController>()
                        .volunteerExperienceDataList
                        .length,
                    itemBuilder: (context, index) {
                      final volunteer = Get.find<GlobalController>()
                          .volunteerExperienceDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                volunteer.title,
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      volunteer.description,
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    volunteer.startDateController.text,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Text(
                                volunteer.endDateController.text,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal),
                              ),
                            ]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
