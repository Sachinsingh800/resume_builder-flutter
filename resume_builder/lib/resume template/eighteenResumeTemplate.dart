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
class EighteenResumeTemplate extends StatefulWidget {
  File? image;
   EighteenResumeTemplate({Key? key,  this.image}) : super(key: key);

  @override
  _EighteenResumeTemplateState createState() =>
      _EighteenResumeTemplateState();
}

class _EighteenResumeTemplateState
    extends State<EighteenResumeTemplate> {
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
 height: 65.3rem;  /* 1240px / 16px = 77.5rem */
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
}
.work_entry{
  display: grid;
  grid-template-columns: 1fr;
}
.section_title{
   display: flex;
   align-items: center;
   gap: 2.7rem;

}
.title_{
   display: flex;
   justify-content: space-between;
   align-items: center;
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
list-style: none;
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
  margin-left:-3.6rem;
margin-top:-1.5rem;
}
.section-content{
  margin-top:-.5rem;
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
                <div>
                    <div class="img_box">
                        <img src="" alt="dp">
                    </div>
                </div>
                <div class="name_box">
                    <h1 class="name">JESSICA CLAIRE</h1>
                    <h5 class="name">Frontend Developer</h5>
                </div>
            </div>
            <div class="container">
                <div class="right_section">
                    <div class="section">
                        <h3 class="section_title">EDUCATION</h3>
                        <!-- Replace with your styling for Divider -->
                        <div class="divider"><hr/></div>
                        <div class="work_entry">
                            <p class="date">2019.08 - 2023.09</p>
                            <div>
                                <h4 class="degree">Masters in Data Science</h3>
                                <p class="university">ABC College</p>
                            </div>
                        </div>
                        <div class="work_entry">
                            <p class="date">2019.08 - 2023.09</p>
                            <div>
                                <h4 class="degree">Masters in Data Science</h3>
                                <p class="university">ABC College</p>
                            </div>
                        </div>
                    </div>
                    <h3 class="section-title">CONTACTS</h3>
                    <div class="divider"><hr/></div>
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
                    <div class="section">
                        <h3 class="section-title">SKILLS</h3>
                        <div class="divider"><hr/></div>
                        <ul class="skills_list">
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                        </ul>
                    </div>
                    <div class="section">
                        <h3 class="section-title">LANGUAGE</h3>
                        <div class="divider"><hr/></div>
                        <ul class="skills_list">
                            <li>Hindi</li>
                            <li>English</li>
                            <li>Urdu</li>
                        </ul>
                    </div>
                    <div class="section">
                        <h3 class="section-title">INTEREST</h3>
                        <div class="divider"><hr/></div>
                        <ul class="skills_list">
                            <li>Hindi</li>
                            <li>English</li>
                            <li>Urdu</li>
                        </ul>
                    </div>
                </div>
                <div class="left_section">
                    <div class="section">
                        <h3 class="section-title">SUMMARY</h3>
                        <div class="divider"><hr/></div>
                        <p class="section-content">
                            Lorem Ipsum is simply dummy text of scrambled it to make a ty It was popularised in the
                            1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more.
                        </p>
                    </div>
                    <div class="section">
                        <h3 class="section_title">EXPERIENCE</h3>
                        <div class="divider"><hr/></div>
                        <div class="work_expe">
                            <div class="work-info" >
                                <div class="title_">
                                    <h3 class="position">Software Engineer</h3>
                                    <p class="date">2019.08 - Present</p>
                                </div>
                                <p class="company">ABC Company</p>
                                <p class="description">
                                    Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                    including versions of Lorem Ipsum.
                                </p>
                            </div>
                           
                        </div>
                        <div class="work_expe">
                            <div class="work-info" >
                                <div class="title_">
                                    <h3 class="position">Software Engineer</h3>
                                    <p class="date">2019.08 - Present</p>
                                </div>
                                <p class="company">ABC Company</p>
                                <p class="description">
                                    Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                    including versions of Lorem Ipsum.
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
      backgroundColor: Colors.white,
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
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF363F48),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Frank Shelby',
                        style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'Master Electrician',
                        style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.65,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Aerjo erioj wejroi ejro ioewji ejroi jeoir ejoiwrj oewjroi jie jeirwjoi joiwerj reiwjroiew jeirj iijrie erfk nekjr  oirio ioerjeio jfoierjf iejo eoir jrioji jrioj ijroie erijr ieroj ',
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
                              'Experience',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Color(0xFF1C1B20),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '2013-presnet',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 170,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Master Electrician',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      'San Fransixo',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      'Key achievements',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '2013-presnet',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 170,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Master Electrician',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      'San Fransixo',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      'Key achievements',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '2013-presnet',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 170,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Master Electrician',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      'San Fransixo',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                    Text(
                                      '- Rtortj rjtprjt orpjtp jportj ej jekr jejr e',
                                      style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 10,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Education',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Color(0xFF1C1B20),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(),
                                child: Text(
                                  '2013-2015',
                                  style:TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                              Container(
                                width: 170,
                                decoration: BoxDecoration(),
                                child: Text(
                                  'Assocainton of tsocne scoole',
                                  style:TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    '2013-2015',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    'Assocainton of tsocne scoole',
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
                              'Certofocation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Color(0xFF1C1B20),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(),
                                child: Text(
                                  '2013-2015',
                                  style:TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                              Container(
                                width: 170,
                                decoration: BoxDecoration(),
                                child: Text(
                                  'Assocainton of tsocne scoole',
                                  style:TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    '2013-2015',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    'Assocainton of tsocne scoole',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
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
                  Container(
                    width: MediaQuery.of(context).size.width*0.35,
                    height: MediaQuery.of(context).size.height*0.87,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Personal info',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Color(0xFF1C1B20),
                          ),
                          Text(
                            'Address',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'gianjrie rjie r ij UsA',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Text(
                            '98923590595',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Text(
                            'frie@gmail.com',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Linkedin',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Text(
                            'LinkedinURl',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
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
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Color(0xFF1C1B20),
                          ),
                          Text(
                            'C++',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            'Advanced',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Java',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            'Beginner',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Html',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            'Intermediate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'CSS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            'Intermediate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'CSS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            'Intermediate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Language',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Color(0xFF1C1B20),
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 12,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Italian',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'French',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Germn',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'HIndi',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Interest',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Color(0xFF1C1B20),
                          ),
                          Text(
                            'Astronomy (Life-long subscrber of Sky And TElescope',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'Rock music (ACDoc, Black)',
                            style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
