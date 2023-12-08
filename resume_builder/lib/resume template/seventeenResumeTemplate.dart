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
class SeventeenthResumeTemplate extends StatefulWidget {
  File? image;
   SeventeenthResumeTemplate({Key? key,  this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SeventeenthResumeTemplateState createState() => _SeventeenthResumeTemplateState();
}

class _SeventeenthResumeTemplateState extends State<SeventeenthResumeTemplate> {
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
 height: 65.3rem;  
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
  height: 8rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 0rem 1rem;
}
.img_box{
   border-radius: 50%;
   margin-right: 4rem;
}
.section{
  display: flex;
  flex-direction: column;
  gap: .5rem;
}
.work_entry{
  display: grid;
  grid-template-columns: 1fr ;
}
.title_{
   display: flex;
   justify-content: space-between;
   align-items: center;
   width: 90%;
}
.section_title{
   display: flex;
   align-items: center;
   gap: 2.7rem;
}
.description{
   width: 25rem;
}
.contact_value{
   display: flex;
   align-items: center;

}
.contact_label{
   font-size: small;
}
.contact_info{
display: grid;
grid-template-columns: 1fr 1fr 1fr;
 gap: 0rem;
}
.contact_info div{
  margin:0rem;
  padding:.1rem;
}
.contact_info div p{
  margin:.3rem;
}

.skills_list{
display: grid;
grid-template-columns: 1fr 1fr;
gap: .5rem;
list-style: none;
padding-top: 1rem;
margin-left: -1rem;
}
.ul{
   display: flex;
   flex-direction: column;
   gap: .5rem;
   list-style: none;
}
.name-box h1,h5{
 margin:0rem;
}
.contact_label{
  margin:0rem;
  boder:1px red solid;
}
.divider{
  margin-left:-1rem;
  margin-top:-1.5rem;
}

.section p{
  margin:0rem;
}
.ul {
  margin-left:-2.4rem;
  margin-top:-1rem;
}
.skills_list {
  margin-left:-4rem;
  margin-top:-1rem;
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
        <div class="name-box">
          <h1 class="name">JESSICA CLAIRE</h1>
          <h5 class="name">frontend Developer</h5>
        </div>
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
      <div class="container">
        <div class="left_section">
          <div class="section">
            <h3 class="section-title">SUMMARY</h3>
            <div class="divider"><hr/></div>
            <p class="section-content">
              Lorem Ipsum is simply dummy text of scrambled it to make a ty It
              was popularised in the 1960s with the release of Letraset sheets
              containing Lorem Ipsum passages, and more.
            </p>
          </div>
  
          <div class="section">
            <h3 class="section_title">EXPERIENCE</h3>
            <div class="divider"><hr/></div>
            <ul class="ul">
              <li >
                <div class="work_entry">
                  <div>
                    <div class="title_">
                      <h3 class="position">Software Engineer </h3>
                      <p class="date">2019.08 - Present</p>
                    </div>
  
                    <p class="company">ABC Company</p>
                    <p class="description">
                      Lorem Ipsum is simply dummy text of Lorem Ipsum passages,
                      and Aldus PageMaker including versions of Lorem Ipsum.
                    </p>
                  </div>
                </div>
              </li>
              <li >
                <div class="work_entry">
                  <div>
                    <div class="title_">
                      <h3 class="position">Software Engineer </h3>
                      <p class="date">2019.08 - Present</p>
                    </div>
  
                    <p class="company">ABC Company</p>
                    <p class="description">
                      Lorem Ipsum is simply dummy text of Lorem Ipsum passages,
                      and Aldus PageMaker including versions of Lorem Ipsum.
                    </p>
                  </div>
                </div>
              </li>
              <!-- Additional experience entries go here -->
            </ul>
          </div>
  
          <div class="section">
            <h3 class="section_title">EDUCATION</h3>
            <div class="divider"><hr/></div>
            <ul class="ul">
              <li>
                <div class="work_entry">
                  <div class="title_">
                    <h3 class="degree">Masters in Data Science</h3>
                    <p class="date">2019.08 - 2023.09</p>
                  </div>
  
                  <div>
                    <p class="university">ABC College</p>
                  </div>
                </div>
              </li>
              <!-- Additional education entries go here -->
            </ul>
          </div>
        </div>
  
        <div class="right_section">
          <div class="section">
            <h3 class="section-title">SKILLS</h3>
               <div class="divider"><hr/></div>
            <ul class="skills_list">
              <li>javascript </li>
              <!-- Add more skills as needed -->
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
            right: true,
            bottom: true,
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
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        //color: const Color(0xff353c46),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Text(
                                'JESSICA CLAIRE',
                                style: TextStyle(
                                  color: Color(0xff3a4e6f),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Divider(
                                      thickness: 1,
                                      indent: 6,
                                      endIndent: 10,
                                      color: Color(0xff303845),
                                    ),
                                    Padding(
                              padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                              child: Text(
                                'PROFESSIONAL SUMMARY',
                                style: TextStyle(
                                  color: Color(0xff3a4e6f),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Divider(
                                      thickness: 1,
                                      indent: 6,
                                      endIndent: 10,
                                      color: Color(0xff303845),
                                    ),
                                     Padding(
                            padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                            child: Text(
                              'Lorem Ipsum is simply dummy text of  scrambled it to make a ty It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more .',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                //letterSpacing: 1.0
                                //fontWeight: FontWeight.w700
                              ),
                            )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                              child: Text(
                                'WORK HISTORY',
                                style: TextStyle(
                                  color: Color(0xff3a4e6f),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Divider(
                                      thickness: 1,
                                      indent: 6,
                                      endIndent: 10,
                                      color: Color(0xff303845),
                                    ),
                                    Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 5, 6, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Software Engineer',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                '2019.08 - Present',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),])))]),
                                              SizedBox(height: 10),
                                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 5, 6, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Software Engineer',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                '2019.08 - Present',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),])))]),
                                              SizedBox(height: 10),
                                              Padding(
                              padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                              child: Text(
                                'EDUCATION',
                                style: TextStyle(
                                  color: Color(0xff3a4e6f),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Divider(
                                      thickness: 1,
                                      indent: 6,
                                      endIndent: 10,
                                      color: Color(0xff303845),
                                    ),
                                    Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 5, 6, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Masters in Data Science',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC College ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                '2019.08 - 2023.09',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),])))]),
                            ])),
                            Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        color: const Color(0xff394c6a),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Padding(
                                padding: EdgeInsets.fromLTRB(6, 10, 0, 5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      Text(
                                        'Enter Your Address here',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Phone',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      Text(
                                        '+91 9503942697',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'E-mail',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      Text(
                                        'ss20010126@gmail.com',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Twitter',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      Text(
                                        '@5hubzzz',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'LinkedIn',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      Text(
                                        'linkedin.com/en/5hubzzz',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          //letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ])),
                             SizedBox(
                              height: 15,
                            ),
                            Divider(
                                      thickness: 1,
                                      indent: 6,
                                      endIndent: 10,
                                      color: Colors.white,
                                    ),
                                     Padding(
                              padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                              child: Text(
                                'SKILLS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Divider(
                                      thickness: 1,
                                      indent: 6,
                                      endIndent: 10,
                                      color: Colors.white,
                                    ),
                                    Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\u2022 Store Opening and Closing and also helped other members witht heir work',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                            ]),
            )));}}