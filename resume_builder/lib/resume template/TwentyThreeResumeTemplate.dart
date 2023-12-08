// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:convert';
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


class TwentyThreeResumeTemplate extends StatefulWidget {
  File? image;
   TwentyThreeResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwentyThreeResumeTemplateState createState() =>
      _TwentyThreeResumeTemplateState();
}

class _TwentyThreeResumeTemplateState extends State<TwentyThreeResumeTemplate> {
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
    width: 15rem;
   padding: 2rem 1rem;
   height: 1100px;
   margin-left:1rem ;
   margin-top: -13rem;
   background-color: rgb(178, 176, 181);
   
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
 
    height: 15rem;
    display: flex;
  align-items: center;
  justify-content: end;
   width:;
    padding: 0rem 1rem;
    background-color: grey;
   
 }
 .img_box{
     border-radius: 0;
     width: 14.8rem;
     height: 12rem;
     margin-top: -1rem;
     background-color: rgb(31, 0, 110);
     overflow: hidden;
     background-color: white;
 }
 .img_box img{
     height: 100%;
     width: 100%;
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
     color: black!important;
 
 }
 .description{
     width: 25rem;
 }
 .contact_value{
     display: flex;
     align-items: center;
     gap: .3rem;
 
 }
 
 .contact_label{
     font-size: small;
 }
 .contact_info{
 display: grid;
 grid-template-columns: 1fr ;
   gap: .5rem;
 }
 .skills_list{
 display: grid;
 grid-template-columns: 1fr ;
 gap: .5rem;

 padding-top: 1rem;
 }
 .skills_list li{
     display: flex;
     align-items: center;
 }
 .ul{
     display: flex;
     flex-direction: column;
     gap: .5rem;
   
 }
 .section_title{
     padding: 0rem ;
     color: white;
     display: flex;
     gap: .5rem;
 }
 .name{
     font-size: 3rem;
 }
 .name_box{
     display: flex;
     flex-direction: column;
     align-items: center;
     width: 70%;
     color: white;
     
 }
 .name_box h1,h4{
     margin:0rem;
 }
 .contact_value span,p{
    margin:0rem;
 }
 .divider{
     margin-top:-2rem;
 }
 .skill-list {
    display: flex;
    flex-direction: column;
    gap:.3rem;
     margin-top:-.5rem;
 }
 .skill-list  li{
  
    margin-left:-1rem!important;
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
        <div class="header">
            <div class="name_box">
                <h1 class="name">JESSICA CLAIRE</h1>
                <h4>Frontend Developer</h4>
            </div>
        </div>
        <div class="container">
            <div class="right_section">
                <div class="img_box">
                    <img src="" alt="dp">
                </div>
                <div class="contact_info">
                    <h3 class="section_title">Contact</h3>
                    <div class="divider"><hr/></div>
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
                <div class="section">
                    <h3 class="section_title">SKILLS</h3>
                 <div class="divider"><hr/></div>
                    <ul class="skill-list">
                        <li>javascript</li>
                        <li>javascript</li>
                        <li>javascript</li>
                        <li>javascript</li>
                        <li>javascript</li>
                        <li>javascript</li>
                        <li>javascript</li>
                    </ul>
                </div>
                <div class="section">
                    <h3 class="section_title">LANGUAGE</h3>
                 <div class="divider"><hr/></div>
                    <ul class="skill-list">
                        <li>Hindi</li>
                        <li>English</li>
                        <li>Urdu</li>
                    </ul>
                </div>
                <div class="section">
                    <h3 class="section_title">INTEREST</h3>
                 <div class="divider"><hr/></div>
                    <ul class="skill-list">
                        <li>Hindi</li>
                        <li>English</li>
                        <li>Urdu</li>
                    </ul>
                </div>
            </div>
            <div class="left_section">
                <div class="section">
                    <h3 class="section_title">
                        <PersonIcon />
                        ABOUT
                    </h3>
                 <div class="divider"><hr/></div>
                    <p class="section-content">
                        Lorem Ipsum is simply dummy text of scrambled it to make a ty It was popularised in the 1960s
                        with the release of Letraset sheets containing Lorem Ipsum passages, and more.
                    </p>
                </div>
                <div class="section">
                    <h3 class="section_title">
                        <WorkIcon />
                        EXPERIENCE
                    </h3>
                 <div class="divider"><hr/></div>
                    <ul class="ul">
                        <li>
                            <div class="work_entry">
                                <div>
                                    <div class="title_">
                                        <h4 class="position">Software Engineer </h4>
                                        <p class="date">2019.08 - Present</p>
                                    </div>
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
                                <div>
                                    <div class="title_">
                                        <h4 class="position">Software Engineer </h4>
                                        <p class="date">2019.08 - Present</p>
                                    </div>
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
                    <h3 class="section_title">
                        <SchoolIcon />
                        EDUCATION
                    </h3>
                 <div class="divider"><hr/></div>
                    <ul class="ul">
                        <li>
                            <div class="work_entry">
                                <div class="title_">
                                    <h4 class="degree">Masters in Data Science</h4>
                                    <p class="date">2019.08 - 2023.09</p>
                                </div>
                                <div>
                                    <p class="university">ABC College</p>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="work_entry">
                                <div class="title_">
                                    <h4 class="degree">Masters in Data Science</h4>
                                    <p class="date">2019.08 - 2023.09</p>
                                </div>
                                <div>
                                    <p class="university">ABC College</p>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="work_entry">
                                <div class="title_">
                                    <h4 class="degree">Masters in Data Science</h4>
                                    <p class="date">2019.08 - 2023.09</p>
                                </div>
                                <div>
                                    <p class="university">ABC College</p>
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
            right: true,
            left: true,
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
              body: Wrap(
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width,
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 40, 0),
                                    child: Text(
                                      'Shubham Singh',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.0),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                    child: Text(
                                      'Profession',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff61a3a2),
                                        //fontWeight: FontWeight.w700
                                      ),
                                    )),
                                Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Icon(
                                        Icons.phone,
                                        size: 20.0,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      child: Text(
                                        '+91 9503942697',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Icon(
                                        Icons.mail,
                                        size: 20.0,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      child: Text(
                                        'ss20010126@gmail.com',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Icon(
                                        Icons.language,
                                        size: 20.0,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      child: Text(
                                        'linkedin.com/5hubzzz',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 20.0,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      child: Text(
                                        'Edinburg, Russia',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ])),
                    ]),
                    Container(
                        height: MediaQuery.sizeOf(context).height * 0.819,
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Text(
                                'SUMMARY',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
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
                                padding: EdgeInsets.fromLTRB(6, 0, 6, 5),
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of  scrambled  popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more .',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Text(
                                'EXPERIENCE',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              indent: 6,
                              endIndent: 6,
                              color: Color(0xff303845),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(6, 0, 6, 5),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Software Engineer',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'ABC Company ',
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            size: 18.0,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '2019.08-Present',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 18.0,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                        style: TextStyle(
                                          color: Color(0xff363c48),
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Software Engineer',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'ABC Company ',
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            size: 18.0,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '2019.08 - Present',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 18.0,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                        style: TextStyle(
                                          color: Color(0xff363c48),
                                          fontSize: 12,
                                        ),
                                      )
                                    ])),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Text(
                                'EDUCATION',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              indent: 6,
                              endIndent: 6,
                              color: Color(0xff303845),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Software Engineer',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'ABC Company ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: 18.0,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '2019.08 - Present',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 18.0,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Software Engineer',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'ABC Company ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: 18.0,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '2019.08 - Present',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 18.0,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.819,
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  child: Text(
                                    'SKILLS',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  indent: 6,
                                  endIndent: 10,
                                  color: Color(0xff303845),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Text(
                                        'Flutter',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff363c48)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.2,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff22252c),
                                              Color(0xff22252c),
                                              Colors.lightBlue,
                                              Colors.lightBlue,
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
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Text(
                                        'Flutter',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff363c48)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.2,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff22252c),
                                              Color(0xff22252c),
                                              Colors.lightBlue,
                                              Colors.lightBlue,
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
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Text(
                                        'Flutter',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff363c48)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.2,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff22252c),
                                              Color(0xff22252c),
                                              Colors.lightBlue,
                                              Colors.lightBlue,
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
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Text(
                                        'Flutter',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff363c48)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.2,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff22252c),
                                              Color(0xff22252c),
                                              Colors.lightBlue,
                                              Colors.lightBlue,
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
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Text(
                                        'Flutter',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff363c48)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.2,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff22252c),
                                              Color(0xff22252c),
                                              Colors.lightBlue,
                                              Colors.lightBlue,
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
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  child: Text(
                                    'MY LIFE PHILOSOPHY',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  indent: 6,
                                  endIndent: 10,
                                  color: Color(0xff303845),
                                ),
                                 const Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of  scrambled it to make a ty It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more .',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.lightBlue,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                )),
                                 const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  child: Text(
                                    ' MY OPEN SOURSE WORK',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  indent: 6,
                                  endIndent: 10,
                                  color: Color(0xff303845),
                                ),
                                 const Padding(
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
                              ]),
                        ),
                      ],
                    )
                  ]),
            )));
  }
}
