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


class TwelthResumeTemplate extends StatefulWidget {
  File? image;
   TwelthResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwelthResumeTemplateState createState() => _TwelthResumeTemplateState();
}

class _TwelthResumeTemplateState extends State<TwelthResumeTemplate> {
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
                grid-template-columns: 2fr 1fr;
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
                gap: 1rem; /* Reduced gap */
                text-align: left;
            }
    
          
    
            .education {
                width: 100%;
                display: flex;
                flex-direction: column;
                gap: 0.5rem; /* Reduced gap */
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
                gap: 0.25rem; /* Reduced gap */
                padding: 0rem 1rem;
                height: 1100px;
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
                gap: 0.5rem;
            }
    
            .heading {
                background-color: aliceblue;
                padding: 3rem 1rem;
            }
    
            .certifications {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: 0.25rem; /* Reduced gap */
            }
    
            .skills {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: 0.25rem; /* Reduced gap */
            }
    
            .skills ul {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 0.5rem; /* Reduced gap */
            }
    
            .professional_summary {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: 0.25rem; /* Reduced gap */
            }
    
            .work {
                padding: 1rem;
                display: flex;
                flex-direction: column;
                gap: 0.25rem; /* Reduced gap */
            }
    
       
    
            .info_box p {
                display: flex;
                gap: 0.25rem; /* Reduced gap */
                align-items: center;
            }
    
            .certifications ul {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 0.5rem; /* Reduced gap */
            }
    
            .header {
                background-color: rgb(163, 163, 163);
                display: flex;
                flex-direction: column;
                justify-content: center;
                padding: 2rem 1rem;
            }
    
            .section {
                display: flex;
                flex-direction: column;
                gap: 0.25rem; /* Reduced gap */
            }
    
            .work_entry {
                display: grid;
                grid-template-columns: 1fr 2fr;
                gap:.5rem;
            }
            .work-info{
              margin:0;
              padding:0;
            }
            .work-info h4{
              margin:0;
            }
    
            .education {
                display: grid;
                grid-template-columns: 1fr 1fr;
            }
    
            .header h2,
            h5 {
                margin: 0;
            }
            .certi-li h4,h5,p{
              margin: 0;
            }
            .ul{
              margin-top:-1rem;
              display:grid;
              grid-template-columns: 1fr 1fr;
           
            }
            .exp-ul{
              margin-top:-1rem; 
            }
            .ul-certi{
              margin-top:-2rem;
              display:grid;
              grid-template-columns: 1fr 1fr;
            }
            .education-entry h4,h5,p{
              margin: 0;
            }
            .contact-entry h4,p{
              margin: 0;
            }
            .contact-info{
              display:flex;
              flex-direction:column;
              gap:.5rem;
            }
            .award-list h4,h5,p{
              margin: 0;
            }
            .ul-skill{
              margin-top:-1rem;
              margin-left:-2.5rem;
            }
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="header">
                <h2 class="name">John Doe</h2>
                <h5 class="name">Frontend Developer</h5>
            </div>
            <div class="container">
                <div class="left_section">
                    <div class="section">
                        <p class="section-content">
                            Passionate and detail-oriented Frontend Developer with a strong foundation in web development and UI/UX design.
                        </p>
                    </div>
                    <div class="section">
                        <h3 class="section-title">Experience</h3>
                        <ul class="exp-ul">
                           
                            <li>
                                <div class="work_entry">
                                    <h5> Jan 2020 - Present</h5>
                                    <div class="work-info">
                                        <h4 class="position">Software Engineer</h4>
                                        <p class="company">ABC Company - Cityville</p>
                                        <p class="description">Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="work_entry">
                                    <h5> Jan 2020 - Present</h5>
                                    <div class="work-info">
                                        <h4 class="position">Software Engineer</h4>
                                        <p class="company">ABC Company - Cityville</p>
                                        <p class="description">Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                                    </div>
                                </div>
                            </li>
                          
                            <!-- Add more work experiences as needed -->
                        </ul>
                    </div>
                    <div class="section">
                        <h3 class="section-title">Education</h3>
                        <ul class="ul">
                            <li>
                                <div class="education-entry">
                                    <h4 class="degree">Bachelor of Science in Computer Science</h4>
                                    <p class="university">University of Cityville</p>
                                    <p class="date">2016 - 2020</p>
                                </div>
                            </li>
                            <li>
                                <div class="education-entry">
                                    <h4 class="degree">Bachelor of Science in Computer Science</h4>
                                    <p class="university">University of Cityville</p>
                                    <p class="date">2016 - 2020</p>
                                </div>
                            </li>
                            <!-- Add more education details as needed -->
                        </ul>
                    </div>
                    <div class="section">
                        <h3 class="section-title">Certification</h3>
                        <hr class="divider" />
                        <ul class="ul-certi">
                            <li>
                                <div class="education-entry">
                                    <h4 class="degree">Certification Title</h4>
                                    <p class="university">Issuing Organization</p>
                                    <p class="date">Date</p>
                                </div>
                            </li>
                            <li>
                                <div class="education-entry">
                                    <h4 class="degree">Certification Title</h4>
                                    <p class="university">Issuing Organization</p>
                                    <p class="date">Date</p>
                                </div>
                            </li>
                            <!-- Add more certification details as needed -->
                        </ul>
                    </div>
                </div>
                <div class="right_section" style="background-color: #D3D3D3;">
                    <h4 class="section-title">Personal Info</h4>
                    <div class="contact-info">
                        <div class="contact-entry">
                            <h5 class="contact-label">Address</h5>
                            <p class="contact-value">Your Address Here</p>
                        </div>
                        <div class="contact-entry">
                            <h5 class="contact-label">Phone</h5>
                            <p class="contact-value">123-456-7890</p>
                        </div>
                        <div class="contact-entry">
                            <h5 class="contact-label">E-mail</h5>
                            <p class="contact-value">john.doe@example.com</p>
                        </div>
                        <div class="contact-entry">
                            <h5 class="contact-label">LinkedIn</h5>
                            <p class="contact-value">linkedin.com/in/johndoe</p>
                        </div>
                    </div>
                    <div class="section">
                        <h4 class="section-title">Skill</h4>
                        <ul class="ul-skill">
                            <li>
                              JavaScript
                            
                            </li>
                            <!-- Add more skills as needed -->
                        </ul>
                    </div>
                    <div class="section">
                        <h4 class="section-title">Language</h4>
                    
                        <ul class="ul-skill">
                            <li>
                              English
                            </li>
                            <!-- Add more languages as needed -->
                        </ul>
                    </div>
                    <div class="section">
                        <h4 >Awards</h4>
                        <ul class="ul-skill">
                            <li class="award-list">
                                <h5>Date</h5>
                                <h4>Award Title</h4>
                                <p>Issuing Organization</p>
                            </li>
                            <!-- Add more awards as needed -->
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
        body: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  color: const Color(0xff1b1e2f),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/images/person.png",
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(children: [
                          Container(color: Color(0xffffca00), width: 10, height: 30),
                          Container(
                            color: const Color.fromARGB(255, 63, 65, 87),
                            width: MediaQuery.sizeOf(context).width * 0.36,
                            height: 30,
                            child: const Padding(
                                padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                                child: Text(
                                  'EDUCATION',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                      ),
                                )),
                          ),
                        ]),
                        const Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Column(children: [
                                Text(
                                  'Enter Your Major here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Name of your University',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Duration',
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
                                  'Enter Your Major here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Name of your University',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Duration',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                )
                              ])),
                        ),
                        const SizedBox(height: 30),
                        Row(children: [
                          Container(color: Color(0xffffca00), width: 10, height: 30),
                          Container(
                            color: const Color.fromARGB(255, 63, 65, 87),
                            width: MediaQuery.sizeOf(context).width * 0.36,
                            height: 30,
                            child: const Padding(
                                padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                                child: Text(
                                  'CONTACT',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                      ),
                                )),
                          ),
                        ]),
                        const Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Column(children: [
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
                              ])),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(children: [
                          Container(color: Color(0xffffca00), width: 10, height: 30),
                          Container(
                            color: const Color.fromARGB(255, 63, 65, 87),
                            width: MediaQuery.sizeOf(context).width * 0.36,
                            height: 30,
                            child: const Padding(
                                padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                                child: Text(
                                  'REFERENCE',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                      ),
                                )),
                          ),
                        ]),
                        const Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Column(children: [
                                Text(
                                  'Sara Taylor',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Director | Company name',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  '+5 6589 6545',
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
                                  'Sara Taylor',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Director | Company name',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  '+5 6589 6545',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                )
                              ])),
                        ),
                      ])),
              Column(children: [
                Container(
                    height: MediaQuery.sizeOf(context).height * 0.969,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    color: Colors.white,
                    child: Column(children: [
                      Row(children: [
                        Container(
                          color: Color(0xffffca00),
                          width: 10,
                          height: MediaQuery.sizeOf(context).height * 0.2,
                        ),
                        Container(
                          color: const Color(0xffebebeb),
                          width: MediaQuery.sizeOf(context).width * 0.56,
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                        child: Text(
                                          'KARAN',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                                        child: Text(
                                          'RICHARDS',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.black,
                                            letterSpacing: 1.0,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                    child: Text(
                                      'PROFESSION',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        letterSpacing: 1.0,
                                        //fontWeight: FontWeight.w700
                                      ),
                                    )),
                              ]),
                        )
                      ]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(children: [
                              Container(
                                  color: Color(0xffffca00), width: 10, height: 30),
                              Container(
                                color: const Color(0xffebebeb),
                                width: MediaQuery.sizeOf(context).width * 0.56,
                                height: 30,
                                child: const Padding(
                                    padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                                    child: Text(
                                      'ABOUT ME',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                          ),
                                    )),
                              ),
                            ])),
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
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(children: [
                              Container(
                                  color: Color(0xffffca00), width: 10, height: 30),
                              Container(
                                color: const Color(0xffebebeb),
                                width: MediaQuery.sizeOf(context).width * 0.56,
                                height: 30,
                                child: const Padding(
                                    padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                                    child: Text(
                                      'WORK EXPERIENCE',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                          ),
                                    )),
                              ),
                            ])),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(6, 5, 0, 6),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            )),
                             Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(children: [
                              Container(
                                  color: Color(0xffffca00), width: 10, height: 30),
                              Container(
                                color: const Color(0xffebebeb),
                                width: MediaQuery.sizeOf(context).width * 0.56,
                                height: 30,
                                child: const Padding(
                                    padding: EdgeInsets.fromLTRB(16, 5, 0, 5),
                                    child: Text(
                                      'SKILLS',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          letterSpacing: 1.0
                                          //fontWeight: FontWeight.w700
                                          ),
                                    )),
                              ),
                            ])),
                            const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Text(
                                        'Flutter',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.5,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xffffca00),
                                              Color(0xffffca00),
                                              Color(0xffcccccc),
                                              Color(0xffcccccc),
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
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Text(
                                        'Adobe Photoshop',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.5,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xffffca00),
                                              Color(0xffffca00),
                                              Color(0xffcccccc),
                                              Color(0xffcccccc),
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
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Text(
                                        'React Js',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.5,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xffffca00),
                                              Color(0xffffca00),
                                              Color(0xffcccccc),
                                              Color(0xffcccccc),
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
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Text(
                                        'Adobe AfterEffects',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.5,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xffffca00),
                                              Color(0xffffca00),
                                              Color(0xffcccccc),
                                              Color(0xffcccccc),
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
                      ]),
                    ]))
              ]),
            ]),
      ),
    ));
  }
}
