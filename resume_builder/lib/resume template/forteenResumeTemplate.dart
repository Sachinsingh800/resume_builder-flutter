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
class ForteenResumeTemplate extends StatefulWidget {
  File? image;
   ForteenResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForteenResumeTemplateState createState() => _ForteenResumeTemplateState();
}

class _ForteenResumeTemplateState extends State<ForteenResumeTemplate> {
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
          width: 794px ;
            height: 1130px;
          background-color: white;
          
        }
    
            .container{
              display: grid;
              grid-template-columns: 1fr 2fr;
           }
           .img_box{
              height: 10rem;
              width: 10rem;
              overflow: hidden;
              display: flex;
              align-items: center;
              justify-content: center;
              border-radius: 50%;
              margin-left: 4rem;
           }
           .profession_box{
               position: absolute;
               bottom: 61%;
               background-color: white;
               border: 1px black solid;
               padding: .2rem;
           
           }
           .img_box img{
              height: 100%;
              width: 100%;
           
           }
           .left_section{
              display: flex;
              flex-direction: column;
              padding: .5rem 2rem;
              gap: 1rem;
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
              gap: .2rem;
             border-right: 1px black solid;
             width: 18rem;
             margin-top: 1rem;
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
           .user_header{
           
             padding:  0!important;
             display: grid;
             grid-template-columns: 1fr 2fr;
         
         
           }
           
           .certifications{
            padding: 1rem;
            display: flex;
            flex-direction: column;
            gap: .5rem;
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
            align-items: center;
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
              border-bottom: 1px rgb(0, 0, 0) solid;
              padding: .5rem 1rem;

           }
           .work_entry{
              display: grid;
              grid-template-columns: 1fr 3fr;
           
           }
           .edu_entry{
             margin-left: 1rem;
             padding-top:.5rem ;
           }
           .ul{
               display: flex;
               flex-direction: column;
               gap: .5rem;
           }
           .section_title{
              margin-left: -1rem;
         
           }
           .description{
               width: 25rem;
           }
           .contact_value{
               display: flex;
               align-items: center;
               gap: .2rem;
           
           }
           
           .contact_label{
               font-size: small;
           }
           .contact_info{
             display: flex;
             flex-direction: column;
             gap: .5rem;
             border-bottom: 1px rgb(0, 0, 0) solid;
             padding: .2rem 1rem;
           }
           .skills_list{
           display: flex;
           flex-direction: column;
         
           }
      
          
           .name_box{
               width: 100%;
               height: 15rem;
               padding: 1rem;
               border-bottom: 1px black solid;
               margin: 0rem 1rem;
           }
           .image_box{
               display: flex;
               align-items: center;
               justify-content: center;
              border-right:1px black solid ;
              border-bottom:1px black solid ;
              border-radius: 10px 0px 10px 0px;
            
           }
            .icon {
                height: 1rem;
                width: 1rem;
            }
    
            .icon img {
                height: 1rem;
                width: 1rem;
            }
      
            .ul li{
              list-style: circle;
            }
            .award_section{
         
              padding-left:.5rem;
            }
            .skills_section{
              padding:.5rem;
            }
         
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="user_header">
                <div class="image_box">
                    <div class="img_box">
                        <!-- Replace with actual base64 encoded image -->
                        <img src="" alt="demo_dp" />
                    </div>
                 
                </div>
                <div class="name_box">
                    <h1 class="name">John Doe</h1>
                    <h5 class="name">Software Engineer</h5>
                    <p class="section-content">
                        Passionate software engineer with expertise in web development and problem-solving. Excited to
                        contribute to innovative projects.
                    </p>
                </div>
            </div>
            <div class="container">
                <div class="right_section">
                    <div class="contact_info">
               
                        <div class="contact_value">
                            <span class="contact_label">
                                <span style="font-size:20px" class="icon">
                                    <!-- Replace with actual base64 encoded image -->
                                    <img src="" />
                                </span>
                            </span>
                            <p class="contact-value">+91 23272767623</p>
                        </div>
                        <div class="contact_value">
                            <span class="contact_label">
                                <span style="font-size:20px" class="icon">
                                    <!-- Replace with actual base64 encoded image -->
                                    <img src="" />
                                </span>
                            </span>
                            <p class="contact-value">JohnDoe@gmail.com</p>
                        </div>
                        <div class="contact_value">
                            <span class="contact_label">
                                <span style="font-size:20px" class="icon">
                                    <!-- Replace with actual base64 encoded image -->
                                    <img src="" />
                                </span>
                            </span>
                            <p class="contact-value">linkedin.com/in/johndoe</p>
                        </div>
                        <div class="contact_value">
                            <span class="contact_label">
                                <span style="font-size:20px" class="icon">
                                    <!-- Replace with actual base64 encoded image -->
                                    <img src="" />
                                </span>
                            </span>
                            <p class="contact-value">123 Main St, Cityville, 12345</p>
                        </div>
                    </div>
                    <br />
                    <div class="skills_section">
                        <h3 class="section-title">SKILLS</h3>
                        <ul class="skills_list">
                            <li>
                             JavaScript
                            </li>
                            <li>
                             React.js
                            
                            </li>
                            <!-- Add more skills as needed -->
                        </ul>
                    </div>
                    <div class="skills_section">
                        <h3 class="section-title">LANGUAGE</h3>
                        <ul class="skills_list">
                            <li>
                                English
                            </li>
                            <li>
                              Spanish
                            </li>
                            <!-- Add more languages as needed -->
                        </ul>
                    </div>
                    <div class="award_section">
                        <h3 class="award">AWARDS</h3>
                        <ul>
                            <li>
                                <h5>2022</h5>
                                <h4>Outstanding Achievement Award</h4>
                                <p>XYZ Organization</p>
                            </li>
                            <!-- Add more awards as needed -->
                        </ul>
                    </div>
                </div>
    
                <div class="left_section">
                    <div class="section">
                        <h3 class="section_title">PROFESSIONAL EXPERIENCE</h3>
                        <ul class="ul">
                        <li>
                            <div class="work_entry">
                                <h5 class="date">Jan 2020 - Present</h5>
                                <div>
                                    <h4 class="degree">Software Engineer</h4>
                                    <p class="university">ABC Tech - Cityville</p>
                                    <p>Contributed to the development of innovative web
                                    applications using cutting-edge technologies.</p>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="work_entry">
                                <h5 class="date">Jan 2020 - Present</h5>
                                <div>
                                    <h4 class="degree">Software Engineer</h4>
                                    <p class="university">ABC Tech - Cityville</p>
                                    <p>Contributed to the development of innovative web
                                    applications using cutting-edge technologies.</p>
                                </div>
                            </div>
                        </li>
                        <!-- Add more education details as needed -->
                    </ul>
                        
                    </div>
                    <div class="sections">
                        <h3>EDUCATION</h3>
                        <ul class="ul">
                            <li>
                                <div class="work_entry">
                                    <h5 class="date">2016 - 2020</h5>
                                    <div>
                                        <h4 class="degree">Bachelor of Science in Computer Science</h4>
                                        <p class="university">University of Cityville</p>
                                    </div>
                                </div>
                            </li>
                
                            <li>
                                <div class="work_entry">
                                    <h5 class="date">2016 - 2020</h5>
                                    <div>
                                        <h4 class="degree">Bachelor of Science in Computer Science</h4>
                                        <p class="university">University of Cityville</p>
                                    </div>
                                </div>
                            </li>
                            <!-- Add more education details as needed -->
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
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width,
                          color: const Color(0xffffffff),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 40, 0),
                                  child: Text(
                                    'Shubham Singh',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff822c1d),
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.0),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                  child: Text(
                                    'Profession',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      //fontWeight: FontWeight.w700
                                    ),
                                  )),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 0, 0, 5),
                                        child: Text(
                                          'Phone:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 0, 0, 5),
                                        child: Text(
                                          '+91 9503942697',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(36, 0, 0, 5),
                                        child: Text(
                                          'E-mail:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 0, 35, 5),
                                        child: Text(
                                          'ss20010126@gmail.com',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                        child: Text(
                                          'LinkedIn:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 35, 5),
                                        child: Text(
                                          'linkedin.com/en/5huzzz',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                        child: Text(
                                          'Twitter:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 35, 5),
                                        child: Text(
                                          '@5hubzzz',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                  ]),
                            ],
                          )),
                    ]),
                    Expanded(
                      child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.75,
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          color: Color(0xffffffff),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                  child: Text(
                                    'WORK EXPERIENCE',
                                    style: TextStyle(
                                      color: Color(0xff822c1d),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6,10, 0, 0),
                                      child: Text(
                                        'Company name and location',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                      child: Text(
                                        '09/2015 - Present',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  child: Text(
                                    'Company details',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                  child: Text(
                                    'Senior Software Developer',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
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
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text(
                                        'Company name and location',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                      child: Text(
                                        '09/2015 - Present',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  child: Text(
                                    'Company details',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                  child: Text(
                                    'Senior Software Developer',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
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
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text(
                                        'Company name and location',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                      child: Text(
                                        '09/2015 - Present',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  child: Text(
                                    'Company details',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                  child: Text(
                                    'Senior Software Developer',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
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
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\u2022 Store Opening and Closing',
                                        style: TextStyle(
                                            color: Color(0xff363c48),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 15, 0, 0),
                                  child: Text(
                                    'EDUCATION',
                                    style: TextStyle(
                                      color: Color(0xff822c1d),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text(
                                        'College name and location',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                      child: Text(
                                        '09/2008 - 09/2012',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                                  child: Text(
                                    'Company details',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 15, 0, 0),
                                  child: Text(
                                    'SKILLS',
                                    style: TextStyle(
                                      color: Color(0xff822c1d),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text(
                                        'Hard Skills:',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                      child: Text(
                                        'Flutter, Adobe Photoshop, Dart, Python',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text(
                                        'Technical:',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                      child: Text(
                                        'Flutter, Adobe Photoshop, Dart, Python',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ])),
                    )
                  ]),
            )));
  }
}
