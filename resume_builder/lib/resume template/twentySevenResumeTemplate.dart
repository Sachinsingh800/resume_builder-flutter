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

class TwentySevenResumeTemplateWidget extends StatefulWidget {
  File? image;
   TwentySevenResumeTemplateWidget({Key? key, this.image}) : super(key: key);

  @override
  _TwentySevenResumeTemplateWidgetState createState() =>
      _TwentySevenResumeTemplateWidgetState();
}

class _TwentySevenResumeTemplateWidgetState
    extends State<TwentySevenResumeTemplateWidget> {

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
      <title>JESSICA CLAIRE - Frontend Developer</title>
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
    padding-bottom:.5rem ;
 }
 .work_entry{
    display: grid;
    grid-template-columns: 1fr;
    gap:1rem;
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
    margin-top:-1rem;
    }
    .contact_value p,span{
        margin:0rem;
    }
    .work_entry p,h4{
       margin:0rem;  
    }
    .skills_list li{
        margin-left:-1rem!important;
    }
    .edu-ul{
       display: flex;
       flex-direction: column;
       gap: .5rem;
       margin-top:-1rem;
    }
    .section-content{
       margin-top:-1rem;  
    }
    .icon{
     height:1rem;
     width:1rem;
   
   }
   .edu-entry p,h4{
     margin:0rem;  
  }
  .name_box h1,h5{
    margin:0rem;  
  }
 }
                </style>
    </head>
    
    <body>
      <div id="main" class="main">
        <div class="header">
          <div class="name_box">
            <h1 class="name">JESSICA CLAIRE</h1>
            <h5 class="name">Frontend Developer</h5>
          </div>
          <div class="contact_info">
            <div class="contact_value">
            <img class="icon" src="" alt="dp" />
              <p class="contact-value">+91 9503942697</p>
            </div>
            <div class="contact_value">
            <img class="icon" src="" alt="dp" />
              <p class="contact-value">ss20010126@gmail.com</p>
            </div>
            <div class="contact_value">
            <img class="icon" src="" alt="dp" />
              <p class="contact-value">linkedin.com/en/5hubzzz</p>
            </div>
            <div class="contact_value">
            <img class="icon" src="" alt="dp" />
              <p class="contact-value">Enter Your Address here</p>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="right_section">
            <div class="section">
              <h3 class="section_title">EDUCATION</h3>
              <div class="edu-ul"> 

              <div  class="edu-entry">
              <p class="date">2019.08 - 2023.09</p>
              <div>
                <h4 class="degree">Masters in Data Science</h4>
                <p class="university">ABC College</p>
              </div>
            </div>
            
              <div  class="edu-entry">
              <p class="date">2019.08 - 2023.09</p>
              <div>
                <h4 class="degree">Masters in Data Science</h4>
                <p class="university">ABC College</p>
              </div>
            </div>
            
              
              </div>
            </div>
            <div class="section">
              <h3 class="section-title">SKILLS</h3>
              <ul class="skills_list">
                <li>JavaScript</li>
                <!-- Repeat similar blocks for other skills -->
              </ul>
            </div>
            <div class="section">
              <h3 class="section-title">LANGUAGE</h3>
              <ul class="skills_list">
                <li>Hindi</li>
                <li>English</li>
                <li>Urdu</li>
                <!-- Repeat similar blocks for other languages -->
              </ul>
            </div>
            <div class="section">
              <h3 class="section-title">INTEREST</h3>
              <ul class="skills_list">
                <li>Hiking</li>
                <li>Reading</li>
                <li>Traveling</li>
                <!-- Repeat similar blocks for other interests -->
              </ul>
            </div>
          </div>
          <div class="left_section">
            <div class="section">
              <h3 class="section-title">PROFILE</h3>
              <p class="section-content">
                Lorem Ipsum is simply dummy text of the printing and typesetting
                industry. Lorem Ipsum has been the industry's standard dummy text
                ever since the 1500s, when an unknown printer took a galley of type
                and scrambled it to make a type specimen book.
              </p>
            </div>
            <div class="section">
              <h3 class="section_title">WORK EXPERIENCE</h3>
             
              <div class="work_entry">

                <div>
                  <div class="title_">
                    <h4 class="position">Software Engineer</h4>
                    <p class="date">2019.08 - Present</p>
                  </div>
                  <p class="company">ABC Company</p>
                  <p class="description">
                    Lorem Ipsum is simply dummy text of the printing and typesetting
                    industry. Lorem Ipsum has been the industry's standard dummy text
                    ever since the 1500s, when an unknown printer took a galley of type
                    and scrambled it to make a type specimen book.
                  </p>
                </div>

                <div>
                  <div class="title_">
                    <h4 class="position">Software Engineer</h4>
                    <p class="date">2019.08 - Present</p>
                  </div>
                  <p class="company">ABC Company</p>
                  <p class="description">
                    Lorem Ipsum is simply dummy text of the printing and typesetting
                    industry. Lorem Ipsum has been the industry's standard dummy text
                    ever since the 1500s, when an unknown printer took a galley of type
                    and scrambled it to make a type specimen book.
                  </p>
                </div>

                <!-- Repeat similar blocks for other work experiences -->
              </div>
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
      body: SlidingUpPanel(
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
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2C),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(45, 0, 0, 15),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://picsum.photos/seed/352/600',
                            width: 300,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chery Pacoc',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              'Software Trainer',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
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
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.40,
                  height: MediaQuery.of(context).size.height*0.8,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEE7E1),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 25, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Details',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  '0955606586',
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  'ereef@gmail.com',
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  'ekrktjortj rjit tior jrit ',
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            'Education',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'Bachelor of science',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'Computer Science',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'Univerkrk erke oerk k ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            '2017-2021',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            'Skills',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            '- opkrto ktro ktrotkor ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            '- opkrto ktro ktrotkor ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            '- opkrto ktro ktrotkor ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            '- opkrto ktro ktrotkor ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                          child: Text(
                            '- opkrto ktro ktrotkor ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  height: MediaQuery.of(context).size.height*0.8,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summary',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Text(
                          'rhtkjth oirh tkjrh tijrhtjk rhtji etjkerwh thertejith krthg rjekthjkreh jkrehtjkreh rjkethruith iurthh rieh ruiehtui ruith thrith ioith hort khrt uirht rtkjr klttjhtkl hkorth uiorhtj tjkrh ioerkljewhrtklhnkseeutio erjkhtior grhwthrkj jketehtjkehtkrhrtweit ihtuiwerhti hwjkrth iohiot hiotwerph',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Work Experience',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'XXCOMPANY',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              child: Text(
                                'APRIL 2011- CURRENT',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.black,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(3, 5, 0, 0),
                              child: Text(
                                'XCITY, xSTATE',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.black,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'XXCOMPANY',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              child: Text(
                                'APRIL 2011- CURRENT',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.black,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(3, 5, 0, 0),
                              child: Text(
                                'XCITY, xSTATE',
                                style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.black,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'References',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(3, 5, 0, 0),
                          child: Text(
                            'Referenced ierjie jerjkoe erjeo jortj e',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
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
    );
  }
}
