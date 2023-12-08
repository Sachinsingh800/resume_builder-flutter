// ignore: file_names
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/global_controller.dart';
import '../controller/postResume.dart';
import '../screen/PDFFormat.dart';
import '../widget/pannel_widget.dart';

class EighthResumeTemplate extends StatefulWidget {
  File? image;
  EighthResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  _EighthResumeTemplateState createState() => _EighthResumeTemplateState();
}

class _EighthResumeTemplateState extends State<EighthResumeTemplate> {
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
          if(widget.image == null){
            //Resume with no image
            String message = await PostResume().createResume(globalController);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$message'),
              ),
            );
            if(message == "Data Posted"){
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
                height: auto;
                background-color: white;
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
          .summary h2{
              background-color:rgb(211, 211, 211)  ;
              padding: 0rem .5rem;
              width: 90%;
            font-weight:100;
          }
          .para{
              width: 90%;
          }
          .summary {
              display: flex;
              align-items: center;
              flex-direction: column;
          }
          .Experience{
              display: flex;
              align-items: center;
              flex-direction: column;
           
          }
          .Experience h2{
              background-color:rgb(211, 211, 211)  ;
              padding: 0rem .5rem;
              width: 90%;
          }
          .Experience ul{
              width: 90%;
              list-style: none;
              margin-top:-1rem;
             
          }
          .Experience ul li{
            margin:1rem;
         
            margin-left:-1rem;
          }
          .Skills h2{
            background-color:rgb(211, 211, 211)  ;
            padding: 0rem .5rem;
            width: 90%;
          font-weight:100;
          }
          .Skills {
              display: flex;
              align-items: center;
              flex-direction: column;
              margin:0rem;
          }
          .Skills ul{
              width: 90%;
              display: grid;
              grid-template-columns: 1fr 1fr;
           
              margin-top:-.5rem;
          }
          .Skills ul li{
              padding: 1rem;
              margin-left: 1rem;
              margin:0rem;
          }
          .work_des {
              display: grid;
              grid-template-columns: 1fr 2fr;
      
          }
        
          .Education {
            display: flex;
            flex-direction: column;
            gap: 0rem;
            align-items: center;
            width: 850px;
        }

        .Education  h2{
          background-color:rgb(211, 211, 211)  ;
          padding: 0rem .5rem;
          width: 90%;
      }

        .Education ul {
            width: 90%;
            display: grid;
            grid-template-columns: 1fr 1fr;
            padding-left: 10px; /* Adjusted from 1rem to pixels based on your requirement */
            gap: 15px; /* Adjusted from 1rem to pixels based on your requirement */
            margin-top:-.5rem;
        }

        .Education ul li {
            display: flex;
            flex-direction: column;
        }
          .edu_des h5,h4,p{
            margin:.1rem;
          }
          .work  h5,h4,p{
            margin:.1rem;
          }
       
        
        </style>
    </head>
    
    <body>
        <div onclick="setTemplateNo(7)" class="main">
            <div class="heading">
                <h1>John Doe</h1>
                <p>john.doe@example.com | 123-456-7890</p>
            </div>
            <div class="summary">
                <h2>Professional Summary</h2>
                <p class="para">Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.</p>
            </div>
            <div class="Skills">
                <h2>Skills</h2>
                <ul>
                    <li style="color: color3;">
                        <span>JavaScript</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                </ul>
            </div>
            <div class="Experience">
                <h2>Work History</h2>
                <ul>
                    <li>
                        <div class="work_des">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span>
                                    <p>Jan 2020 - Present</p>
                                </h5>
                            </div>
                            <div>
                            <p>
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            </p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span>
                                    <p>Jan 2020 - Present</p>
                                </h5>
                            </div>
                            <div>
                            <p>
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            </p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span>
                                    <p>Jan 2020 - Present</p>
                                </h5>
                            </div>
                            <div>
                                <p>
                                Contributed to the development of innovative web applications using cutting-edge technologies.
                                Contributed to the development of innovative web applications using cutting-edge technologies.
                                Contributed to the development of innovative web applications using cutting-edge technologies.
                                </p>
                            </div>
                        </div>
                    </li>
                  
                </ul>
            </div>
            <div class="Education">
                <h2>Education</h2>
                <ul>
                <li class="edu_des">
                <h5>2016 - 2020</span>
                <h4>Bachelor of Science in Computer Science</h4>
                <p>University of Cityville</span> 
                </li>
                <li class="edu_des">
                <h5>2016 - 2020</span>
                <h4>Bachelor of Science in Computer Science</h4>
                <p>University of Cityville</span> 
                </li>
                <li class="edu_des">
                <h5>2016 - 2020</span>
                <h4>Bachelor of Science in Computer Science</h4>
                <p>University of Cityville</span> 
                </li>
             
                </ul>
            </div>
        </div>
    </body>
    
    </html>
      """);
              await PostResume().saveAndOpenPdf(pdfBytes, context);
              setState(() {
                _isLoading = false;
              });
            }else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$message'),
                ),
              );
              setState(() {
                _isLoading = false;
              });
            }
          }else{

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
                height: auto;
                background-color: white;
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
          .summary h2{
              background-color:rgb(211, 211, 211)  ;
              padding: 0rem .5rem;
              width: 90%;
            font-weight:100;
          }
          .para{
              width: 90%;
          }
          .summary {
              display: flex;
              align-items: center;
              flex-direction: column;
          }
          .Experience{
              display: flex;
              align-items: center;
              flex-direction: column;
           
          }
          .Experience h2{
              background-color:rgb(211, 211, 211)  ;
              padding: 0rem .5rem;
              width: 90%;
          }
          .Experience ul{
              width: 90%;
              list-style: none;
              margin-top:-1rem;
             
          }
          .Experience ul li{
            margin:1rem;
         
            margin-left:-1rem;
          }
          .Skills h2{
            background-color:rgb(211, 211, 211)  ;
            padding: 0rem .5rem;
            width: 90%;
          font-weight:100;
          }
          .Skills {
              display: flex;
              align-items: center;
              flex-direction: column;
              margin:0rem;
          }
          .Skills ul{
              width: 90%;
              display: grid;
              grid-template-columns: 1fr 1fr;
           
              margin-top:-.5rem;
          }
          .Skills ul li{
              padding: 1rem;
              margin-left: 1rem;
              margin:0rem;
          }
          .work_des {
              display: grid;
              grid-template-columns: 1fr 2fr;
      
          }
        
          .Education {
            display: flex;
            flex-direction: column;
            gap: 0rem;
            align-items: center;
            width: 850px;
        }

        .Education  h2{
          background-color:rgb(211, 211, 211)  ;
          padding: 0rem .5rem;
          width: 90%;
      }

        .Education ul {
            width: 90%;
            display: grid;
            grid-template-columns: 1fr 1fr;
            padding-left: 10px; /* Adjusted from 1rem to pixels based on your requirement */
            gap: 15px; /* Adjusted from 1rem to pixels based on your requirement */
            margin-top:-.5rem;
        }

        .Education ul li {
            display: flex;
            flex-direction: column;
        }
          .edu_des h5,h4,p{
            margin:.1rem;
          }
          .work  h5,h4,p{
            margin:.1rem;
          }
       
        
        </style>
    </head>
    
    <body>
        <div onclick="setTemplateNo(7)" class="main">
            <div class="heading">
                <h1>John Doe</h1>
                <p>john.doe@example.com | 123-456-7890</p>
            </div>
            <div class="summary">
                <h2>Professional Summary</h2>
                <p class="para">Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.</p>
            </div>
            <div class="Skills">
                <h2>Skills</h2>
                <ul>
                    <li style="color: color3;">
                        <span>JavaScript</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                    <li style="color: color3;">
                        <span>React.js</span>
                    </li>
                </ul>
            </div>
            <div class="Experience">
                <h2>Work History</h2>
                <ul>
                    <li>
                        <div class="work_des">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span>
                                    <p>Jan 2020 - Present</p>
                                </h5>
                            </div>
                            <div>
                            <p>
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            </p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span>
                                    <p>Jan 2020 - Present</p>
                                </h5>
                            </div>
                            <div>
                            <p>
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            Contributed to the development of innovative web applications using cutting-edge technologies.
                            </p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <div class="work">
                                <h4 class="customerService">Software Engineer</h3>
                                <h5 class="company_name">
                                    <span>ABC Tech - Cityville</span>
                                    <p>Jan 2020 - Present</p>
                                </h5>
                            </div>
                            <div>
                                <p>
                                Contributed to the development of innovative web applications using cutting-edge technologies.
                                Contributed to the development of innovative web applications using cutting-edge technologies.
                                Contributed to the development of innovative web applications using cutting-edge technologies.
                                </p>
                            </div>
                        </div>
                    </li>
                  
                </ul>
            </div>
            <div class="Education">
                <h2>Education</h2>
                <ul>
                <li class="edu_des">
                <h5>2016 - 2020</span>
                <h4>Bachelor of Science in Computer Science</h4>
                <p>University of Cityville</span> 
                </li>
                <li class="edu_des">
                <h5>2016 - 2020</span>
                <h4>Bachelor of Science in Computer Science</h4>
                <p>University of Cityville</span> 
                </li>
                <li class="edu_des">
                <h5>2016 - 2020</span>
                <h4>Bachelor of Science in Computer Science</h4>
                <p>University of Cityville</span> 
                </li>
             
                </ul>
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$message'),
                ),
              );
              setState(() {
                _isLoading = false;
              });
            }
          }
        },
        child: _isLoading ? CircularProgressIndicator(color: Colors.white,):Icon(Icons.arrow_downward),
      ),
      body: SafeArea(
          top: true,
          right: true,
          left: true,
          child: Screenshot(
            controller: screenshotController,
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
                              decoration:  BoxDecoration(
                                color: Color(globalController.color.value),
                              ),
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
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2.0),
                                      )),
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
                            child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text(
                                      'Lorem Ipsum is simply dummy text of  scrambled it to make a ty It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 10, 0, 0),
                                    child: Text(
                                      'Experience',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.9,
                                    indent: 6,
                                    endIndent: 10,
                                    color: Color(0xff363c48),
                                  ),
                                  Row(
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
                                            child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  30, 0, 6, 0),
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
                                              )),
                                        ))
                                      ]),
                                  SizedBox(height: 15),
                                  Row(
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
                                            '2017.05-2019.09  ',
                                            style: TextStyle(
                                              color: Color(0xff363c48),
                                              fontSize: 12,
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                            child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  28, 0, 6, 0),
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
                                              )),
                                        ))
                                      ]),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 10, 0, 0),
                                    child: Text(
                                      'Education',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.9,
                                    indent: 6,
                                    endIndent: 10,
                                    color: Color(0xff363c48),
                                  ),
                                  Row(
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
                                            '2017.05-2020.08 ',
                                            style: TextStyle(
                                              color: Color(0xff363c48),
                                              fontSize: 12,
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                            child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  30, 0, 6, 0),
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
                                              )),
                                        ))
                                      ]),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(6, 10, 0, 0),
                                    child: Text(
                                      'Skills',
                                      style: TextStyle(
                                        color: Color(0xff363c48),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    indent: 6,
                                    endIndent: 10,
                                    color: Color(0xff363c48),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
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
                                        Text(
                                          '\u2022 Store Opening and Closing',
                                          style: TextStyle(
                                              color: Color(0xff363c48),
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ])))
                  ]),
            ),
          )),
    );
  }
}
