import 'dart:io';

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

class ThirteenResumeTemplate extends StatefulWidget {
  File? image;
   ThirteenResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  _ThirteenResumeTemplateState createState() =>
      _ThirteenResumeTemplateState();
}

class _ThirteenResumeTemplateState
    extends State<ThirteenResumeTemplate> {
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
        <title>Your Resume</title>
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
            }
    
            .container {
                display: grid;
                grid-template-columns: 1fr 2fr;
            }
    
            .img_box {
                height: 7rem;
                width: 7rem;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                margin-right: 2rem;
            }
    
            .img_box img {
                height: 100%;
                width: 100%;
          
            }
    
            .left_section {
                display: flex;
                flex-direction: column;
                padding: 2rem 1rem;
                gap: 2rem;
                text-align: left;
            }
    
            .info_box,
            .education {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: 1rem;
                padding: 1rem 1rem;
            }
    
            .right_section {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding: 2rem 1rem;
                height: 1130px;
            }
    
            .right_section p {
                width: 95%!important;
                display: flex;
                flex-direction: column;
                text-align: left;
                list-style: none;
            }
    
            .right_section ul li {
                margin-left: 1.5rem;
            }
    
            .work_history {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }
    
            .heading {
                padding: 3rem 1rem;
            }
    
            .certifications,
            .skills,
            .professional_summary,
            .work,
            .contact_info,
            .skills_list {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
            .skills ul,
            .certifications ul {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }
    
            .header {
                height: 8rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0rem 1rem;
                overflow: hidden;
                background-color:grey;
            }
    
            .img_box {
                border-radius: 50%;
            }
    
         
    
            .contact_label {
                border:1px grey solid;
                height: 1.2rem;
                width: 1.2rem;
                display: flex;
                align-items: center;
                border-radius: 5px;
                justify-content: center;
            }
    
            .name_box {
                width: 70%;
                height: 100%;
                padding: .5rem ;
                display: flex;
                display: flex;
                flex-direction: column;
                color:white;
            }

    
            .section {
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
            .work_entry {
                display: grid;
                grid-template-columns: 1fr;
            }
    
            .inner_div {
                border-left: 1px rgb(0, 0, 0) solid;
                padding:  .5rem;
                margin-left: -1rem;
            }
    
            .section_title {
                display: flex;
                align-items: center;
                gap: 2.7rem;
            }
    
            .description {
                width: 25rem;
            }
    
            .contact_value {
                display: flex;
                align-items: center;
                gap: .2rem;
            }
    
            .contact_label {
                font-size: small;
            }
    
            .contact_info {
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
            .skills_list {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding-top: 1rem;
            }
    
            .contact_value {
                display: flex;
                align-items: center;
            }
    
            .contact_value span,
            p {
                margin: 0;
            }
    
            .contact_label {
                font-size: small;
            }
    
            .contact_info {
                display: flex;
                flex-direction: column;
                margin: 0;
                list-style: none;
                gap: .5rem;
                margin-left:-1rem;
            }
    
            .skills_list {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding-top: 1rem;
            }
    
            .name {
                margin: 0rem;
            }
    
            .work-info h3,
            p {
                margin: 0rem;
            }
    
            .ul {
                margin-top: -1rem;
            }
    
            .ul li {
                margin-left: -1rem;
            }
            .ul-skill{
              margin-top: -1rem;
              margin-left: -2rem;
            }
         
    
            .name_box {
                margin-top: 3.5rem;
            }
    
            .contact_value {
                margin-left: 0rem;
            }
    
            .icon {
                height: 1rem;
                width: 1rem;
            }
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="header">
             
                  
                    <div class="name_box">
                        <h1 class="name" style="font-weight: 100;">JESSICA CLAIR </h1>
                        <p class="name">frontend Developer</p>
                    </div>
             
                <div>
                
                </div>
            </div>
            <div class="container">
                <div class="right_section">
                    <h3 class="section-title">CONTACTS</h2>
                    <div class="contact_info">
                        <div class="contact_value">
                            <span class="contact_label">
                            <img class="icon" src="" alt="dp" />
                            </span>
                            <p class="contact-value">+91 9503942697</p>
                        </div>
                        <div class="contact_value">
                            <span class="contact_label">
                            <img class="icon" src="" alt="dp" />
                            </span>
                            <p class="contact-value">ss20010126@gmail.com</p>
                        </div>
                        <div class="contact_value">
                            <span class="contact_label">
                            <img class="icon" src="" alt="dp" />
                            </span>
                            <p class="contact-value">linkedin.com/en/5hubzzz</p>
                        </div>
                        <div class="contact_value">
                            <span class="contact_label">
                            <img class="icon" src="" alt="dp" />
                            </span>
                            <p class="contact-value">Enter Your Address here</p>
                        </div>
                    </div>
    
                    <h3 class="section_title">EDUCATION</h2>
                    <ul class="ul-skill">
                        <li>
                            <div class="work_entry">
                                <p class="date">2019.08 - 2023.09</p>
                                <div>
                                    <h3 class="degree">Masters in Data Science</h3>
                                    <p class="university">ABC College</p>
                                </div>
                            </div>
                        </li>
                    </ul>
    
                    <h3 class="section-title">SKILLS</h2>
                    <ul class="ul-skill">
                        <li>javascript </li>
                        <li>javascript </li>
                        <li>javascript </li>
                        <li>javascript </li>
                        <li>javascript </li>
                        <li>javascript </li>
                    </ul>
    
                    <h3 class="section-title">LANGUAGE</h2>
                    <ul class="ul-skill">
                        <li>Hindi</li>
                        <li>English</li>
                        <li>Urdu</li>
                    </ul>
    
                    <h3 class="section-title">AWARDS</h2>
                    <ul class="ul-skill">
                        <li>Hindi</li>
                        <li>English</li>
                        <li>Urdu</li>
                    </ul>
                </div>
    
                <div class="left_section">
                    <div class="section">
                        <h3 class="section-title">ABOUT ME</h2>
                        <p class="section-content">
                            Lorem Ipsum is simply dummy text of scrambled it to make a ty It was popularised in the 1960s with
                            the release of Letraset sheets containing Lorem Ipsum passages, and more.
                        </p>
                    </div>
    
                    <div class="section">
                        <h3 class="section_title">EXPERIENCE</h2>
                        <ul class="ul">
                            <li>
                                <div class="work_entry">
                                    <p class="date">2019.08 - Present</p>
                                    <div class="inner_div">
                                        <h3 class="position">Software Engineer</h3>
                                        <p class="company">ABC Company</p>
                                        <p class="description">
                                            Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                            including versions of Lorem Ipsum.
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="work_entry">
                                    <p class="date">2019.08 - Present</p>
                                    <div class="inner_div">
                                        <h3 class="position">Software Engineer</h3>
                                        <p class="company">ABC Company</p>
                                        <p class="description">
                                            Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                            including versions of Lorem Ipsum.
                                        </p>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
    
                    <div class="section">
                        <h3 class="section_title">PROJECTS</h2>
                        <ul class="ul">
                            <li>
                                <div class="work_entry">
                                    <p class="date">2019.08 - Present</p>
                                    <div class="inner_div">
                                        <h3 class="position">Software Engineer</h3>
                                        <p class="company">ABC Company</p>
                                        <p class="description">
                                            Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                            including versions of Lorem Ipsum.
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="work_entry">
                                    <p class="date">2019.08 - Present</p>
                                    <div class="inner_div">
                                        <h3 class="position">Software Engineer</h3>
                                        <p class="company">ABC Company</p>
                                        <p class="description">
                                            Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                            including versions of Lorem Ipsum.
                                        </p>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
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
          body:
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'JESSI CLARIE',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'fnew@gmail.com',
                        style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 12,
                            ),
                      ),
                      Container(
                        width: 1,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '59306560650',
                        style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 12,
                            ),
                      ),
                      Container(
                        width: 1,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'San Fransico, CA 94105',
                        style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFF807C7C),
                    ),
                    child: Text(
                      'PERSONAL SUMMARY',
                      style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 13, 0, 0),
                  child: Text(
                    'Highly mainetains associated with entenwsinvecuswotmers serviee and sales experience. outgoing sales proffesionwith track redcord of drving increased sales. Improving buying experience and elevation company',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 9,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFF807C7C),
                    ),
                    child: Text(
                      'SKILLS',
                      style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Wrap(
                      spacing: 100,
                      runSpacing: 0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        Text(
                          '-Guest Service',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            '- Loss preventation',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Text(
                          '- imventory control',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                        Text(
                          '-Guest Service',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                        Text(
                          '-Guest Service',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            '- Product promotions',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFF807C7C),
                    ),
                    child: Text(
                      'WORK HISTORY',
                      style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mar 2015 - current',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'Senior Sales associate',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Bed botth & beion',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'San Franciso',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mar 2015 - current',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'Senior Sales associate',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Bed botth & beion',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'San Franciso',
                            style:TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(),
                            child: Text(
                              '- Adfhao erioeriwio eioruq eiorqio eioqrhqi qoir ijroiq ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFF807C7C),
                    ),
                    child: Text(
                      'EDUCATION',
                      style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2012',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                        Text(
                          'rwo ierjq Scjpp; School',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'San Franciso',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
