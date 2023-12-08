import 'package:flutter/material.dart';
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

class NineTeenResumeTemplate extends StatefulWidget {
  File? image;
   NineTeenResumeTemplate({Key? key,  this.image}) : super(key: key);

  @override
  _NineTeenResumeTemplateState createState() =>
      _NineTeenResumeTemplateState();
}

class _NineTeenResumeTemplateState
    extends State<NineTeenResumeTemplate> {
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
        <link rel="stylesheet" href="your-style.css">
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
        
.container{
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
  padding: 2rem 1rem;
  gap: 2rem;
  text-align: left;
  border-left:1px black solid ;
  margin: .5rem 0rem;
  height: 1000px;
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
 height: 1000px;
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
.header{
 background-color: rgb(215, 213, 213);
  height: 8rem;
  display: flex;
align-items: center;
  justify-content: space-between;
  padding: 0rem 1rem;
}
.img_box{
   border-radius: 50%;
  margin-left: 2rem;
}
.section{
  display: flex;
  flex-direction: column;
  gap: .5rem;
  border-bottom: 1px black solid;
  padding-bottom:.5rem ;
}
.work_entry{
  display: grid;
  grid-template-columns: 1fr;
  margin-top:-1rem;
  gap:.5rem;
}
.section_title{
   display: flex;
   align-items: center;
   gap: 2.7rem;

}
.title_{
   display: flex;
   justify-content: space-between;
   width: 90%;
}
.description{
   width: 25rem;
}
.contact_value{
   display: flex;
   align-items: center;
   gap: .2rem;

}
.name_box{
   width: 75%;
}

.contact_label{
   font-size: small;
}
.contact_info{
 display: flex;
 flex-direction: column;
 gap: .5rem;
}
.skills_list{
display: flex;
flex-direction: column;
gap: .5rem;
padding-top: 1rem;
}
.name_box h1,h5{
  margin:0;
}
.divider{
margin-left:-1rem;
margin-top:-1.5rem;
}
.work_entry p,h4{
  margin:0;
}
.contact_value p{
  margin:0rem;
}
.skills_list{
  margin-left:-2.5rem;
margin-top:-1.5rem;
}
.section-content{
  margin-top:-1rem;
}
.work_expe{
  display: grid;
  grid-template-columns: 1fr;
  margin-top:-1rem;
}
.work-info p{
  margin:0rem;
}
.icon{
  height:1rem;
  width:1rem;
}
        </style>
       
    </head>
    
    <body>
        <div class="main">
            <div class="header">
                <div class="name_box">
                    <h1 class="name">JESSICA CLAIRE</h1>
                    <h5 class="name">Frontend Developer</h5>
                </div>
            </div>
            <div class="container">
                <div class="right_section">
                    <div class="section">
                        <h3 class="section_title">EDUCATION</h3>
                        <div class="work_entry">
                            <p class="date">2019.08 - 2023.09</p>
                            <div>
                                <h4 class="degree">Masters in Data Science</h4>
                                <p class="university">ABC College</p>
                            </div>
                        </div>
                    </div>
                    <div class="section">
                        <h3 class="section-title">CONTACTS</h3>
                        <div class="contact_info">
                            <div class="contact_value">
                                 <span class="icon">
          <img class="icon" src="" alt="dp" />
          </span>
                                <p class="contact-value">+91 9503942697</p>
                            </div>
                            <div class="contact_value">
                                 <span class="icon">
          <img class="icon" src="" alt="dp" />
          </span>
                                <p class="contact-value">ss20010126@gmail.com</p>
                            </div>
                            <div class="contact_value">
                                 <span class="icon">
          <img class="icon" src="" alt="dp" />
          </span>
                                <p class="contact-value">linkedin.com/en/5hubzzz</p>
                            </div>
                            <div class="contact_value">
                                 <span class="icon">
          <img class="icon" src="" alt="dp" />
          </span>
                                <p class="contact-value">Enter Your Address here</p>
                            </div>
                        </div>
                    </div>
                    <div class="section">
                        <h3 class="section-title">SKILLS</h3>
                        <ul class="skills_list">
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                        </ul>
                    </div>
                    <div class="section">
                        <h3 class="section-title">LANGUAGE</h3>
                        <ul class="skills_list">
                            <li>Hindi</li>
                            <li>English</li>
                            <li>Urdu</li>
                        </ul>
                    </div>
                    <div class="section">
                        <h3 class="section-title">INTEREST</h3>
                        <ul class="skills_list">
                            <li>Hindi</li>
                            <li>English</li>
                            <li>Urdu</li>
                        </ul>
                    </div>
                </div>
                <div class="left_section">
                    <div class="section">
                        <h3 class="section-title">PROFILE</h3>
                        <p class="section-content">
                            Lorem Ipsum is simply dummy text of scrambled it to make a ty It was popularised in the
                            1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more.
                        </p>
                    </div>
                    <div class="section">
                        <h3 class="section_title">EXPERIENCE</h3>
                        <div class="work_entry">
                        <div>
                        <div class="title_">
                                <h4 class="position">Software Engineer</h4>
                                <p class="date">2019.08 - Present</p>
                            </div>
                            <p class="company">ABC Company</p>
                            <p class="description">
                                Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker including
                                versions of Lorem Ipsum.
                            </p>
                        </div>
                        <div>
                        <div class="title_">
                                <h4 class="position">Software Engineer</h4>
                                <p class="date">2019.08 - Present</p>
                            </div>
                            <p class="company">ABC Company</p>
                            <p class="description">
                                Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker including
                                versions of Lorem Ipsum.
                            </p>
                        </div>
                        <div>
                        <div class="title_">
                                <h4 class="position">Software Engineer</h4>
                                <p class="date">2019.08 - Present</p>
                            </div>
                            <p class="company">ABC Company</p>
                            <p class="description">
                                Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker including
                                versions of Lorem Ipsum.
                            </p>
                        </div>
                            
                        </div>
                        <!-- Repeat the above block for each work entry -->
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
          body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'TASIANA UKURA',
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
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Text(
                    'WORK EXPERIENCE',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mar 2015 - current',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              'Senior Sales associate',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Bed botth & beion',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              'San Franciso',
                              style: TextStyle(
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
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mar 2015 - current',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              'Senior Sales associate',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Bed botth & beion',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              'San Franciso',
                              style: TextStyle(
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
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mar 2015 - current',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              'Senior Sales associate',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Bed botth & beion',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                            Text(
                              'San Franciso',
                              style: TextStyle(
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
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'E Discovery',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              Text(
                                'san franciso',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              Text(
                                '- peramnuet aojriej eoijrioer eior oierjqio irjioqjrq oiio ioj4rio ',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 9,
                                    ),
                              ),
                              Text(
                                '- peramnuet aojriej eoijrioer eior oierjqio irjioqjrq oiio ioj4rio ',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 9,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'E Discovery',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              Text(
                                'san franciso',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              Text(
                                '- peramnuet aojriej eoijrioer eior oierjqio irjioqjrq oiio ioj4rio ',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 9,
                                    ),
                              ),
                              Text(
                                '- peramnuet aojriej eoijrioer eior oierjqio irjioqjrq oiio ioj4rio ',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 9,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Text(
                    'SKILLS',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Container(
                  decoration: BoxDecoration(),
                  alignment: AlignmentDirectional(-1.00, 0.00),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Text(
                    'pythonm javam c++, html, css, javascript, flutter, dart ,pythonm javam c++, html, css, javascript, flutter, dart ,pythonm javam c++, html, css, javascript, flutter, dart ',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 9,
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
