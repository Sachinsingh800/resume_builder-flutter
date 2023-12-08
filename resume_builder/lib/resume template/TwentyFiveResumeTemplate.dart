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

class TwentythFiveResumeTemplate extends StatefulWidget {
  File? image;
   TwentythFiveResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwentythFiveResumeTemplateState createState() => _TwentythFiveResumeTemplateState();
}

class _TwentythFiveResumeTemplateState extends State<TwentythFiveResumeTemplate> {
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
     <    <!DOCTYPE html>
    <html lang="en">
    
    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Resume</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <style>
        body {
          font-family: 'Arial', sans-serif;
          margin: 0;
          padding: 0;
          background-color: #f0f0f0;
             box-sizing: border-box;
        }
    
        .main {
            width: 794px ;
            height: 1130px;
          background-color: white;
          box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    
        .header {
          background-color: #333;
          color: white;
          padding: 20px;
          text-align: center;
          // border:1px red solid;
        }
    
        .name_box {
          text-align: center;
        }
    
        .name {
          color: white;
        }
    
        .container {
          display: grid;
          grid-template-columns: 2fr 1fr;
          padding: 20px;
          // border:1px red solid;
        }
        .section {
          margin-bottom: 20px;
          // border:1px red solid;
        }
    
        .section_title {
          position: relative;
          font-size: 1.5em;
          margin-bottom: 10px;
        }
    
        .section_title span {
          font-size: 1.2em;
          margin-right: 5px;
        }
    
        .divider {
          border: 1px solid #333;
          margin: 5px 0;
        }
    
        .skills_list,
        .ul {
          list-style: none;
          padding: 0;
        }
    
        .skills_list li,
        .ul li {
          margin-bottom: 5px;
        }
    
        .ul .work_entry {
          margin-bottom: 10px;
        }
    
        .ul .title_ {
          display: flex;
          justify-content: space-between;
        }
    
        .ul .position,
        .ul .degree {
          margin: 0;
        }
    
        .university,
        .company,
        .date,
        .description {
          margin: 0;
        }
    
        .section-content {
          line-height: 1.6;
        }
    
        .contact_info,
        .work_entry,
        .contact_value {
      
          align-items: center;
        }
    
        .contact_label {
          margin-right: 10px;
          display: flex;
          align-items: center;
          gap: .5rem;
          padding:.5rem .5rem .5rem 0rem  ;
        }
    
        .contact-value {
          margin: 0;
 
        }
        .left_section{
          // border:1px red solid;
          width:30rem;
        }
        .img_box {
  height:1rem;
  width:1rem;
        }
        .img_box  img{
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
                       <h4>Frontend Developer</h4>
          </div>
        </div>
    
        <div class="container">
          <div class="left_section">
            <div class="section">
                <h3 class="section_title">
                    ABOUT
                </h3>
                <hr class="divider">
                <p class="section-content">
                    Lorem Ipsum is simply dummy text of scrambled it to make a ty It was popularised in the 1960s
                    with the release of Letraset sheets containing Lorem Ipsum passages, and more.
                </p>
            </div>

              <div class="section">
                   <h3 class="section_title">
                    EXPERIENCE
                    </h3>
                    <hr class="divider">
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
                    PROJECTS
                    </h3>
                    <hr class="divider">
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
                   EDUCATION
                </h3>
                <hr class="divider">
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
        <div class="right_section">
    

        <div class="contact_info">
            <h3 class="section_title">Contact</h3>
            <hr class="divider">
            <div class="contact_value">
                <span class="contact_label">
                    <span style="font-size:20px">&#9990;</span>
                    <p class="contact-value">+91 9503942697</p>
                </span>
          
            </div>
            <div class="contact_value">
                <span class="contact_label">
                    <span style="font-size:20px">&#9993;</span>
                    <p class="contact-value">ss20010126@gmail.com</p>
                </span>
              
            </div>
            <div class="contact_value">
                <span class="contact_label">
                <span style="font-size:20px"  class="img_box"><img src="" /></span>
                <p class="contact-value">linkedin.com/en/5hubzzz</p>
                </span>
         
            </div>
            <div class="contact_value">
                <span class="contact_label">
                    <span style="font-size:20px"  class="img_box"><img src="" /></span>
                    <p class="contact-value">Enter Your Address here</p>
                </span>
               
            </div>
        </div>

        <div class="section">
            <h3 class="section_title">SKILLS</h3>
            <hr class="divider">
            <ul class="skills_list">
                <li>javascript</li>
                <li>javascript</li>
                <li>javascript</li>
                <li>javascript</li>
                <li>javascript</li>
                <li>javascript</li>
                <li>javascript</li>
            </ul>
        </div>

        <br>

        <div class="section">
            <h3 class="section_title">LANGUAGE</h3>
            <hr class="divider">
            <ul class="skills_list">
                <li>Hindi</li>
                <li>English</li>
                <li>Urdu</li>
            </ul>
        </div>

        <br>

        <div class="section">
            <h3 class="section_title">INTEREST</h3>
            <hr class="divider">
            <ul class="skills_list">
                <li>Hindi</li>
                <li>English</li>
                <li>Urdu</li>
            </ul>
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
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          color: const Color(0xff333333),
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 40, 0),
                                    child: Text(
                                      'Shubham Singh',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.0),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                    child: Text(
                                      'Profession',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        //fontWeight: FontWeight.w700
                                      ),
                                    )),
                                Wrap(alignment: WrapAlignment.start, children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 0, 0, 0),
                                            child: Icon(
                                              Icons.phone,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  10.0), // Add some space between the icon and text
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 6, 0),
                                            child: Text(
                                              '+91 9503942697',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 0, 0, 0),
                                            child: Icon(
                                              Icons.mail,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  10.0), // Add some space between the icon and text
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 6, 0),
                                            child: Text(
                                              'ss20010126@gmail.com',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 0, 0, 0),
                                            child: Icon(
                                              Icons.language,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  10.0), // Add some space between the icon and text
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 6, 0),
                                            child: Text(
                                              'linkedin.com/5hubzzz',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(6, 0, 0, 0),
                                            child: Icon(
                                              Icons.location_on,
                                              size: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                              width:
                                                  10.0), // Add some space between the icon and text
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 6, 0),
                                            child: Text(
                                              'Edinburg, Russia',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                              ])),
                      Container(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          color: Colors.white,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bachelor',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'ABC College ',
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
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
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Masters',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'ABC College ',
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
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
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
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
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                                child: Text(
                                  'SKILLS',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
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
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '\u2022 Store Opening and Closing',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '\u2022 Store Opening and Closing',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '\u2022 Store Opening and Closing',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                                child: Text(
                                  'HOBBIES',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
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
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '\u2022 Store Opening and Closing',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '\u2022 Store Opening and Closing',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '\u2022 Store Opening and Closing',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ]),
                    Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width * 0.55,
                        color: Colors.white,
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                child: Text(
                                  'CAREER OBJECTIVE',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(6, 10, 6, 5),
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
                                  'WORK EXPERIENCE',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(6, 10, 6, 5),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                color:
                                                    Color.fromARGB(255, 0, 0, 0),
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
                                                color:
                                                    Color.fromARGB(255, 0, 0, 0),
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
                                            color: Colors.black,
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
                                                color:
                                                    Color.fromARGB(255, 0, 0, 0),
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
                                                color:
                                                    Color.fromARGB(255, 0, 0, 0),
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
                                  'PROJECTS',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ABC Project ',
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '2019.08 - Present',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Lorem Ipsum is simply dummy text of  scrambled  popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more .',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        //letterSpacing: 1.0
                                        //fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ABC Project ',
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '2019.08 - Present',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Lorem Ipsum is simply dummy text of  scrambled  popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more .',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        //letterSpacing: 1.0
                                        //fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                child: Text(
                                  'CERTIFICATIONS',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ABC College ',
                                      //textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '2019.08 - Present',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'Lorem Ipsum is simply dummy text of  scrambled  popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more .',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        //letterSpacing: 1.0
                                        //fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]))
                  ]),
            )));
  }
}
