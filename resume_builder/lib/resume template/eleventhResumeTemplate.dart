import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:resume_builder/controller/postResume.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../screen/PDFFormat.dart';
import '../widget/pannel_widget.dart';

class ElevethResumeTemplate extends StatefulWidget {
  File? image;
   ElevethResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  _ElevethResumeTemplateState createState() => _ElevethResumeTemplateState();
}

class _ElevethResumeTemplateState extends State<ElevethResumeTemplate> {
  // String? imagePath;
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
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
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
                display: grid;
                grid-template-columns: 1fr 2fr;
            }
    
            .Left_container {
                display: flex;
                flex-direction: column;
                background-color: grey;
                color: white;
                height: 1130px;
            }
    
            .objectiveHeader {
                padding: 1rem;
            }
    
            .person_name {
                color: white;
                font-family: 'YourFont', sans-serif;
              
            }
    
            .objectiveText {
                font-size: 18px;
            }
    
            .info_box {
                padding: 1rem;
            }
    
            .contactInfo {
                display: flex;
                gap: 0.5rem;
                margin-bottom: 0.5rem;
            }
    
            label {
                font-weight: bold;
                margin-right: 0.5rem;
                font-size: .8rem;
            }
    
            .skillsHeader {
                padding: 1rem;
            }
    
            ul {
                list-style: none;
                padding: 0;
            }
    
            li {
                margin-bottom: 0.5rem;
            }
    
            .ProgressBar {
                background-color: orange;
                height: 5px;
            }
    
            .skillsHeader2 {
                padding: 1rem;
            }
    
            .professionalSkillsHeader {
                padding: 1rem;
            }
    
            .work_des {
                padding: 1rem;
            }
    
            .education {
                list-style: none;
                padding: 0;
            }
            .objectiveHeader h1,p{
                margin:0rem;
            }
            .exp-ul{
                margin-top:-1rem;
            }
            .edu-ul h4,span{
                margin:0rem;
            }
            .edu-ul {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap:1rem;
            }
            .work_des h4,h5,p{
              margin:0rem;
            }

        </style>
        <title>Your Page Title</title>
    </head>
    
    <body>
        <div class="main">
            <div class="Left_container">
                <div class="objectiveHeader">
                    <h1 class="person_name">John Doe</h1>
                    <p class="objectiveText">Front-end Developer</p>
                </div>
                <div class="info_box">
                    <h3>Personal info</h3>
                    <div class="contactInfo">
                        <label>Mail</label>
                        <p class="email">john.doe@example.com</p>
                    </div>
                    <div class="contactInfo">
                        <label>Phone</label>
                        <p class="email">+1 123 456 7890</p>
                    </div>
                    <div class="contactInfo">
                        <label>Address</label>
                        <p class="email">123 Main St, 56789</p>
                    </div>
                </div>
                <div class="skillsHeader">
                    <h3>Additional Skills</h3>
                    <ul>
                        <li>
                            <span>JavaScript</span>
                            <p class="ProgressBar"></p>
                        </li>
                        <li>
                            <span>React</span>
                            <p class="ProgressBar"></p>
                        </li>
                        <li>
                            <span>HTML5</span>
                            <p class="ProgressBar"></p>
                        </li>
                    </ul>
                </div>
                <div class="skillsHeader">
                    <h3>LANGUAGES</h3>
                    <ul>
                        <li>
                            <span>English</span>
                            <p class="ProgressBar"></p>
                        </li>
                        <li>
                            <span>Spanish</span>
                            <p class="ProgressBar"></p>
                        </li>
                        <li>
                            <span>French</span>
                            <p class="ProgressBar"></p>
                        </li>
                    </ul>
                </div>
            </div>
            <div>
                <div class="skillsHeader2">
                    <h3>Skills Summary</h3>
                    <p>Experienced web developer with expertise in JavaScript and React, seeking challenging projects to
                        contribute my skills and experience.</p>
                </div>
                <div class="professionalSkillsHeader">
                    <div>
                        <h3>EXPERIENCE</h3>
                    </div>
                    <ul class="exp-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Front-end Developer</h4>
                                <h5 class="company_name">
                                    <span>XYZ Company - New York</span>
                                    <span>Jan 2022 - Present</span>
                                </h5>
                                <p>Worked on developing user interfaces, implementing new features, and maintaining web
                                    applications.</p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Junior Developer</h4>
                                <h5 class="company_name">
                                    <span>ABC Agency - San Francisco</span>
                                    <span>Jun 2019 - Dec 2021</span>
                                </h5>
                                <p>Assisted in the development of web applications, participated in code reviews, and
                                    collaborated with the team.</p>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="skillsHeader2">
                    <h3>Education</h3>
                    <ul class="edu-ul">
                        <li>
                            <h4>Bachelor's in Computer Science</h4>
                            <span>2015 - 2019</span>
                            <span>University of Demo</span>
                        </li>
                        <li>
                            <h4>Master's in Web Development</h4>
                            <span>2020 - 2022</span>
                            <span>Tech Institute</span>
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
            setState(() {
              _isLoading = false;
            });
          }
        },
        child: _isLoading ? CircularProgressIndicator(color: Colors.white,):Icon(Icons.arrow_downward),
      ),

      body: SafeArea(
        top: true,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://picsum.photos/seed/502/600',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.63,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Color(0xEFCCCCCC),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ramesh',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            Text(
                              'GARCIA',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 25,
                                  ),
                            ),
                            Text(
                              'WEB DESIGNER & DEVELOPER',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CONTACT',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                      size: 13,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      '0955606586',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.mail,
                                      color: Colors.black,
                                      size: 13,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'ereef@gmail.com',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 13,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Delhi ,220542',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'EDUCATION',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                            Text(
                              '- 2015-2016',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              'masrer Degree',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'communiation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Text(
                              'aieorha iniveryt',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              child: Text(
                                '- 2015-2016',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            Text(
                              'masrer Degree',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'communiation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Text(
                              'communiation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'HOBBIES',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: Text(
                                '- Cycling',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: Text(
                                '- swimming',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'SKILLS',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: Text(
                                '- self motivated',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: Text(
                                '- self motivated',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: Text(
                                '- self motivated',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: Text(
                                '- self motivated',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'AWARDS',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                            Text(
                              '- masrer Degree OF THE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'communiation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Text(
                              '- masrer Degree OF THE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'communiation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width:MediaQuery.of(context).size.width*0.6,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ABOUT ME',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'lorem imporiem sin iae  eiorej eorje ieorj joier eroij ioer  fnweijrqo fqenfiqrjowr qoie ioaewrjowejr iorqwjrie eoirjqiw ioerj ioejrio ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 8,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'EXPERIENCE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Text(
                            '- 2015-2016',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'Heatd of ritier eor',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'lorem imporiem sin iae  eiorej eorje ieorj joier eroij ioer  fnweijrqo fqenfiqrjowr qoie ioaewrjowejr iorqwjrie eoirjqiw ioerj ioejrio ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 8,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- eiurhqiwr or  rkrpoer',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- KJHER HIOiro',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- jehriwh oeiwr oeiwru ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              '- 2015-2016',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Text(
                            'Heatd of ritier eor',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'lorem imporiem sin iae  eiorej eorje ieorj joier eroij ioer  fnweijrqo fqenfiqrjowr qoie ioaewrjowejr iorqwjrie eoirjqiw ioerj ioejrio ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 8,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- eiurhqiwr or  rkrpoer',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- KJHER HIOiro',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- jehriwh oeiwr oeiwru ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              '- 2015-2016',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Text(
                            'Heatd of ritier eor',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'lorem imporiem sin iae  eiorej eorje ieorj joier eroij ioer  fnweijrqo fqenfiqrjowr qoie ioaewrjowejr iorqwjrie eoirjqiw ioerj ioejrio ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 8,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          'KNOWWLEDGE',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- Web design',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- jehriwh Gewrnael',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- Graphics desing',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          'LANGUAGE',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- ENGLISH',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- HINDI',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- GERMAN',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          'SOFTWARE',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- AI',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- PS',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          '- ID',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
