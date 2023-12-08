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


class TwentyTwoResumeTemplate extends StatefulWidget {
  File? image;
   TwentyTwoResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwentyTwoResumeTemplateState createState() =>
      _TwentyTwoResumeTemplateState();
}

class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xff353b47)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _TwentyTwoResumeTemplateState extends State<TwentyTwoResumeTemplate> {
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
        <title>Your Title Here</title>
        <!-- Include your CSS stylesheets or other head elements here -->
    
        <!-- Assuming you have the necessary CSS styles defined for the classes used in the JSX code -->
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
          margin-top: -1rem;
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
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: center;
        height: 5rem;
        width: 52rem; 
     
    }
    .heading h1,p{
      margin:0rem;
    }
       
       .certifications{
      
        display: flex;
        flex-direction: column;
        gap: .5rem;
       }

       .professional_summary{
        
          display: flex;
          flex-direction: column;
          gap: .5rem;
       }
       .work{
        
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
       
       }
       .header{
       
          height: 8rem;
          display: flex;
        align-items: center;
          justify-content: space-between;
          padding: 0rem 1rem;
         
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
          font-weight:100;
       
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
       margin-left: -1rem;
       margin-top:-1rem;
       }
       .skills_list li{
           display: flex;
           align-items: center;
       }
       .ul{
           display: flex;
           flex-direction: column;
           gap: .5rem;
           margin-top:-1rem;
       }
       .section_title{
           background-color: rgb(0, 208, 255);
           padding: 0rem 1rem;
           color: white;
           display: flex;
           gap: .5rem;
       }
       .name h1,h5{
         margin:0.1rem;
       }
       .section-content{
        margin-top:-1rem;
       }
       .edu_des h5,h4,p{
        margin:.1rem;
      }
        </style>
    </head>
    <body>
    
        <div  class="main">
            <div class="header">
                <div class="name">
                    <h1 >JESSICA CLAIRE</h1>
                    <h5 >frontend Developer</h5>
                </div>
                <div class="contact_info">
                    <div class="contact_value">
                        <span class="contact_label">
                            <LocalPhoneIcon style="font-size: 20px; color: #00CCFF;"></LocalPhoneIcon>
                        </span>
                        <p class="contact-value">+91 9503942697</p>
                    </div>
                    <div class="contact_value">
                        <span class="contact_label">
                            <EmailIcon style="font-size: 20px; color: #00CCFF;"></EmailIcon>
                        </span>
                        <p class="contact-value">ss20010126@gmail.com</p>
                    </div>
                    <div class="contact_value">
                        <span class="contact_label">
                            <LinkedInIcon style="font-size: 20px; color: #00CCFF;"></LinkedInIcon>
                        </span>
                        <p class="contact-value">linkedin.com/en/5hubzzz</p>
                    </div>
                    <div class="contact_value">
                        <span class="contact_label">
                            <PlaceIcon style="font-size: 20px; color: #00CCFF;"></PlaceIcon>
                        </span>
                        <p class="contact-value">Enter Your Address here</p>
                    </div>
                </div>
            </div>
    
            <div class="container">
                <div class="right_section">
                    <div class="section">
                        <h2 class="section_title">SKILLS</h2>
                        <ul class="skills_list">
                            <!-- Include your skill list items and progress bars here -->
                            <li>javascript <span> <ProgressBar bgcolor="#00CCFF" progress="40" height="5"></span></li>
                            <li>javascript <span> <ProgressBar bgcolor="#00CCFF" progress="40" height="5"></span></li>
                            <li>javascript <span> <ProgressBar bgcolor="#00CCFF" progress="40" height="5"></span></li>
                            <li>javascript <span> <ProgressBar bgcolor="#00CCFF" progress="40" height="5"></span></li>
                            <li>javascript <span> <ProgressBar bgcolor="#00CCFF" progress="40" height="5"></span></li>
                            <!-- Repeat for other skills -->
                        </ul>
                    </div>
                    <div class="section">
                        <h2 class="section_title">LANGUAGE</h2>
                        <ul class="skills_list">
                            <!-- Include your language list items here -->
                            <li>Hindi</li>
                            <li>Hindi</li>
                            <li>Hindi</li>
                            <!-- Repeat for other languages -->
                        </ul>
                    </div>
                    <div class="section">
                        <h2 class="section_title">INTEREST</h2>
                        <ul class="skills_list">
                            <!-- Include your interest list items here -->
                            <li>Machine learning</li>
                            <!-- Repeat for other interests -->
                        </ul>
                    </div>
                </div>
                <div class="left_section">
                    <div class="section">
                        <h2 class="section_title"><PersonIcon />ABOUT</h2>
                        <p class="section-content">
                            Lorem Ipsum is simply dummy text of scrambled it to make a ty It
                            was popularised in the 1960s with the release of Letraset sheets
                            containing Lorem Ipsum passages, and more.
                        </p>
                    </div>
    
                    <div class="section">
                        <h2 class="section_title"><WorkIcon/>EXPERIENCE</h2>
                        <Divider class="divider" />
                        <ul class="ul">
                          
                            <li>
                            <div class="work_des">
                              
                                    <h3 class="customerService">Software Engineer</h3>
                                    <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span> 
                                    <span>Jan 2020 - Present</span>
                                    </h5>
                           
                                <div>
                                    <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                                </div>
                            </div>
                        </li>
                          
                            <li>
                            <div class="work_des">
                              
                                    <h3 class="customerService">Software Engineer</h3>
                                    <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span> 
                                    <span>Jan 2020 - Present</span>
                                    </h5>
                           
                                <div>
                                    <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                                </div>
                            </div>
                        </li>
                          
                            <li>
                            <div class="work_des">
                              
                                    <h3 class="customerService">Software Engineer</h3>
                                    <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span> 
                                    <span>Jan 2020 - Present</span>
                                    </h5>
                           
                                <div>
                                    <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                                </div>
                            </div>
                        </li>
                            <!-- Repeat for other entries -->
                        </ul>
                    </div>
    
                    <div class="section">
                        <h2 class="section_title"><SchoolIcon/>EDUCATION</h2>
                        <Divider class="divider" />
                        <ul class="ul">
                            <!-- Include your education entries here -->
                            <li class="edu_des">
                            <h5>2016 - 2020</span>
                            <h4>Bachelor of Science in Computer Science</h4>
                            <p>University of Cityville</span> 
                            </li>
                            <!-- Repeat for other entries -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- Include your JavaScript scripts or other body elements here -->
    
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
              body: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: MediaQuery.sizeOf(context).height * 0.15,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: const BoxDecoration(
                                color: Color(0xff363c48),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 0, 0, 0),
                                          child: Text(
                                            'Shubham',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700,
                                                letterSpacing: 2.0),
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 0, 0, 0),
                                          child: Text(
                                            'Singh',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 2.0),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 10),
                                      child: Text(
                                        'Profession',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          //fontWeight: FontWeight.w700
                                        ),
                                      )),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 5, 0, 5),
                                            child: Text(
                                              'Phone:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 5, 0, 5),
                                            child: Text(
                                              '+91 9503942697',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(36, 5, 0, 5),
                                            child: Text(
                                              'E-mail:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 5, 35, 5),
                                            child: Text(
                                              'ss20010126@gmail.com',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700
                                              ),
                                            )),
                                      ]),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 5, 0, 5),
                                            child: Text(
                                              'LinkedIn:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 5, 35, 5),
                                            child: Text(
                                              'linkedin.com/en/5huzzz',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 5, 0, 5),
                                            child: Text(
                                              'Twitter:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.w700
                                              ),
                                            )),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 5, 35, 5),
                                            child: Text(
                                              '@5hubzzz',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
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
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text(
                                      'Lorem Ipsum is simply dummy text of  with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 10, 10, 5),
                                    child: Row(
                                      children: [
                                        CustomPaint(
                                          size: const Size(50, 50),
                                          painter:
                                              DiamondPainter(), // Custom painter for diamond shape
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons
                                                    .business_center_outlined, // Icon to be placed inside the diamond
                                                size: 18.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 0, 0, 0),
                                          child: Text(
                                            'Experience',
                                            style: TextStyle(
                                                color: Color(0xff363c48),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 4, 0, 0),
                                          child: Text(
                                            '2019.08 - Present',
                                            style: TextStyle(
                                              color: Color(0xff363c48),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    23, 0, 6, 0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Software Engineer',
                                                      style: TextStyle(
                                                        color: Color(0xff363c48),
                                                        fontSize: 16,
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
                                                      '\u2022 Store Opening and Closing',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff363c48),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '\u2022 Store Opening and Closing',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff363c48),
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )))
                                      ]),
                                  const SizedBox(height: 15),
                                  const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 4, 0, 0),
                                          child: Expanded(
                                              child: Text(
                                            '2017.05 - 2019.09',
                                            style: TextStyle(
                                              color: Color(0xff363c48),
                                              fontSize: 12,
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    23, 0, 6, 0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Software Engineer',
                                                      style: TextStyle(
                                                        color: Color(0xff363c48),
                                                        fontSize: 16,
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
                                                      '\u2022 Store Opening and Closing and also helped other members witht heir work',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff363c48),
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '\u2022 Store Opening and Closing',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff363c48),
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )))
                                      ]),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 10, 10, 5),
                                    child: Row(
                                      children: [
                                        CustomPaint(
                                          size: const Size(50, 50),
                                          painter:
                                              DiamondPainter(), // Custom painter for diamond shape
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons
                                                    .school_outlined, // Icon to be placed inside the diamond
                                                size: 18.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 0, 0, 0),
                                          child: Text(
                                            'Education',
                                            style: TextStyle(
                                                color: Color(0xff363c48),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 4, 0, 0),
                                          child: Expanded(
                                              child: Text(
                                            '2017.05 - 2020.08 ',
                                            style: TextStyle(
                                              color: Color(0xff363c48),
                                              fontSize: 12,
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    23, 0, 6, 0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Software Engineer',
                                                      style: TextStyle(
                                                        color: Color(0xff363c48),
                                                        fontSize: 16,
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
                                                      '\u2022 Store Opening and Closing and also helped other members witht heir work',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff363c48),
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                )))
                                      ]),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 10, 10, 5),
                                    child: Row(
                                      children: [
                                        CustomPaint(
                                          size: const Size(50, 50),
                                          painter:
                                              DiamondPainter(), // Custom painter for diamond shape
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons
                                                    .psychology_outlined, // Icon to be placed inside the diamond
                                                size: 20.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 0, 0, 0),
                                          child: Text(
                                            'SOFT SKILLS',
                                            style: TextStyle(
                                                color: Color(0xff363c48),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 5, 8, 0),
                                            child: Text(
                                              'Flutter',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff363c48)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 8, 0),
                                            child: Container(
                                              height: 5,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.2,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xff22252c),
                                                    Color(0xff22252c),
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
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 5, 8, 0),
                                            child: Text(
                                              'Flutter',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff363c48)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 8, 0),
                                            child: Container(
                                              height: 5,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.2,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xff22252c),
                                                    Color(0xff22252c),
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
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 5, 8, 0),
                                            child: Text(
                                              'Flutter',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff363c48)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 5, 8, 0),
                                            child: Container(
                                              height: 5,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.2,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xff22252c),
                                                    Color(0xff22252c),
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
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 10, 10, 5),
                                    child: Row(
                                      children: [
                                        CustomPaint(
                                          size: const Size(50, 50),
                                          painter:
                                              DiamondPainter(), // Custom painter for diamond shape
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons
                                                    .desktop_windows_outlined, // Icon to be placed inside the diamond
                                                size: 18.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 0, 0, 0),
                                          child: Text(
                                            'HARD SKILLS',
                                            style: TextStyle(
                                                color: Color(0xff363c48),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xff22252c),
                                                Color(0xff22252c),
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
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xff22252c),
                                                Color(0xff22252c),
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
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color(0xff22252c),
                                                Color(0xff22252c),
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
                                    ],
                                  ),
                                ])))
                  ]),
            )));
  }
}
