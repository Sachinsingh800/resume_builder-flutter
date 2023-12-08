import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';
import 'package:resume_builder/controller/postResume.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/global_controller.dart';
import '../screen/PDFFormat.dart';
import '../widget/pannel_widget.dart';

class FifteenREsumeTemplate extends StatefulWidget {
  File? image;
   FifteenREsumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FifteenREsumeTemplateState createState() => _FifteenREsumeTemplateState();
}

class _FifteenREsumeTemplateState extends State<FifteenREsumeTemplate> {
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
                font-size: 14px;
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
    
            .info_box {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: 1rem;
                padding: 1rem 1rem;
            }
    
            .education {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: 1rem;
                padding: 1rem 1rem;
            }
    
            .img_container {
                display: flex;
                align-items: center;
                justify-content: center;
            }
    
            .right_section {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding: 2rem 1rem;
                height: 65.3rem;
                /* 1240px / 16px = 77.5rem */
                font-size: 14px;
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
    
            .right_section ul li {
                width: 95%!important;
            }
    
            .work_history {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }
    
            .heading {
                padding: 3rem 1rem;
            }
    
            .certifications {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
            .skills {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
            .skills ul {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }
    
            .professional_summary {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
            .work {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: .5rem;
            }
    
            hr {
                margin-left: 1rem;
            }
    
            .info_box p {
                display: flex;
                gap: .5rem;
                align-items: center;
            }
    
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
                padding: 2rem 1rem;
                background-color: rgb(201, 198, 198);
                overflow: hidden;
                font-size: 14px;
            }
    
            .img_box {
                border-radius: 50%;
                margin-left: -3.3rem;
                background-color: white;
                padding: 3rem;
                height: 10rem;
                width: 10rem;
            }
            .img_box img{
              border-radius: 50%;
            }
    
            .name_box {
                width: 70%;
                height: 100%;
                padding: 1rem;
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
                padding: 1rem .5rem;
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
               
            }
            .contact_value span,p {
              margin:0;
             
             
            }
    
            .contact_label {
                font-size: small;
            }
    
            .contact_info {
                display: flex;
                flex-direction: column;
                margin:0;
                list-style:none;
                gap:.5rem;
            }
        
    
            .skills_list {
                display: flex;
                flex-direction: column;
                gap: .5rem;
                padding-top: 1rem;
            }
            .name{
              margin:0rem;
            }
            .work-info h3,p{
              margin:0rem;
            }
            .ul{
              margin-top:-1rem;
            }
            .ul li{
              margin-left:-1rem!important;
            }
            .name_box{
              margin-top:3.5rem;

            }
            .icon{
              height:1rem;
              width:1rem;
              margin-left:-1rem;
            }
            .contact_value{
              margin-left:-2rem; 
            }
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="header">
                <div class="img_box">
                    <img src="" alt="dp" />
                </div>
                <div class="name_box">
                    <h1 class="name">JESSICA CLAIRE</h1>
                    <h5 class="name">Frontend Developer</h5>
                </div>
            </div>
            <div class="container">
                <div class="right_section">
                    <h2 class="section-title">CONTACTS</h2>
                    <ul class="contact_info">
                        <li >
                            <div class="contact_value">
                                <span class="icon">
                                <img class="icon" src="" alt="dp" />
                                </span>
                                <p class="contact-value">+91 9503942697</p>
                            </div>
                        </li>
                        <li>
                            <div class="contact_value">
                            <span class="icon">
                            <img class="icon" src=""} alt="dp" />
                            </span>
                                <p class="contact-value">ss20010126@gmail.com</p>
                            </div>
                        </li>
                        <li>
                            <div class="contact_value">
                            <span class="icon">
                            <img class="icon" src="" alt="dp" />
                            </span>
                                <p class="contact-value">linkedin.com/en/5hubzzz</p>
                            </div>
                        </li>
                        <li>
                            <div class="contact_value">
                            <span class="icon">
                            <img class="icon" src="" alt="dp" />
                            </span>
                                <p class="contact-value">Enter Your Address here</p>
                            </div>
                        </li>
                    </ul>
    
                    <div class="section">
                        <h2 class="section-title">EDUCATION</h2>
                        <ul class="ul">
                        <li>
                        <div class="work_entry">
                            <p class="date">2019.08 - 2023.09</p>
                            <div class="work-info">
                                <h3 class="degree">Masters in Data Science</h3>
                                <p class="university">ABC College</p>
                            </div>
                        </div>
                        </li>
                        </ul>
                        
                    </div>
    
                    <div class="section">
                        <h2 class="section-title">SKILLS</h2>
                        <ul class="ul">
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                            <li>JavaScript</li>
                        </ul>
                    </div>
    
                    <div class="section">
                        <h2 class="section-title">LANGUAGE</h2>
                        <ul class="ul">
                            <li>Hindi</li>
                            <li>English</li>
                            <li>Urdu</li>
                        </ul>
                    </div>
    
                    <div class="section">
                        <h2 class="section-title">AWARDS</h2>
                        <ul class="ul">
                            <li>Hindi</li>
                            <li>English</li>
                            <li>Urdu</li>
                        </ul>
                    </div>
                </div>
    
                <div class="left_section">
                    <div class="section">
                        <h2 class="section-title">ABOUT ME</h2>
                        <Divider class="divider" />
                        <p class="section-content">
                            Lorem Ipsum is simply dummy text of scrambled it to make a ty It was popularised in the 1960s with
                            the release of Letraset sheets containing Lorem Ipsum passages, and more.
                        </p>
                    </div>
    
                    <div class="section">
                        <h2 class="section_title">EXPERIENCE</h2>
                        <Divider class="divider" />
                        <ul>
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
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        color: const Color(0xff353c46),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                              child: Text(
                                'Christian Hybrid',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                              child: Text(
                                'IT Manager',
                                style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff252733),
                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                    height: 30,
                                    child: const Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                        child: Text(
                                          'Personal Info',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            //letterSpacing: 1.0
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                  ),
                                ]),
                            const Padding(
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
                                          //fontWeight: FontWeight.w700
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
                                          //fontWeight: FontWeight.w700
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
                                          //fontWeight: FontWeight.w700
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
                                          //fontWeight: FontWeight.w700
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
                                          //fontWeight: FontWeight.w700
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
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff252733),
                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                    height: 30,
                                    child: const Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                        child: Text(
                                          'Additional Skills',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            //letterSpacing: 1.0
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                  ),
                                ]),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                              child: Text(
                                'Flutter',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff22252c),
                                      Color(0xff22252c),
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
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Adobe Photoshop',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff22252c),
                                      Color(0xff22252c),
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
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'React Js',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff22252c),
                                      Color(0xff22252c),
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
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Adobe AfterEffects',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff22252c),
                                      Color(0xff22252c),
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
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff252733),
                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                    height: 30,
                                    child: const Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                        child: Text(
                                          'Languages',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            //letterSpacing: 1.0
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                  ),
                                ]),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                              child: Text(
                                'English',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff22252c),
                                      Color(0xff22252c),
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
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Spanish',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff22252c),
                                      Color(0xff22252c),
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
                        )),
                    Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        color: Colors.white,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Skills Summary',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                              child: Text(
                                'Programming and App Development',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
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
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                              child: Text(
                                'Leadership',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
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
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                              child: Text(
                                'Business Management',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
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
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                              child: Text(
                                'Experience',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
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
                                              ),
                                              SizedBox(height: 10),
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
                                              ),
                                            ],
                                          )))
                                ]),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                              child: Text(
                                'Education',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MS in Data Science, Distinction',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '2019.08 - 2023.07',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Oxford University ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        )),
                  ]),
            )));
  }
}
