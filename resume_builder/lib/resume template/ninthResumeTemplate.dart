// ignore_for_file: file_names

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resume_builder/controller/global_controller.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/postResume.dart';
import '../screen/PDFFormat.dart';
import '../widget/pannel_widget.dart';

class NinthResumeTemplate extends StatefulWidget {
  File? image;
   NinthResumeTemplate({Key? key, this.image}) : super(key: key);



  @override
  // ignore: library_private_types_in_public_api
  _NinthResumeTemplateState createState() => _NinthResumeTemplateState();
}

class _NinthResumeTemplateState extends State<NinthResumeTemplate> {
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

        .heading {
            display: flex;
            justify-content: space-between;
            width: 850px;
            padding: 0.5rem 1rem;
            height: 6rem;
        }

        .heading div {
            width: 50%;
          //  border:1px red solid;
        }

        .summary h2 {
            border-top: 1px rgb(112, 111, 111) solid;
            border-bottom: 1px rgb(112, 111, 111) solid;
            width: 90%;
        }

        .para {
            width: 96%;
        }

        .summary {
            display: flex;
            align-items: center;
            flex-direction: column;
        }

        .Experience {
            display: flex;
            align-items: center;
            flex-direction: column;
            width: 850px;
      
        }

        .Experience h2 {
            border-top: 1px rgb(112, 111, 111) solid;
            border-bottom: 1px rgb(112, 111, 111) solid;
            width: 96%;
            text-align: center;
        }

        .Experience ul {
            width: 90%;
       
        }

        .Skills h2 {
            border-top: 1px rgb(112, 111, 111) solid;
            border-bottom: 1px rgb(112, 111, 111) solid;
            width: 96%;
            text-align: center;
        }

        .Skills {
            display: flex;
            align-items: center;
            flex-direction: column;
            width: 850px;
            
        }

        .Skills ul {
            width: 90%;
            margin:.1rem;
            display: inline-table;
            grid-template-columns: auto;
            margin-left: -80px; /* Adjusted from -5rem to pixels based on your requirement */
        }

        .Skills ul li {
            width: max-content;
            display: inline-table;
            padding: 8px; /* Adjusted from .5rem to pixels based on your requirement */
            margin: 8px; /* Adjusted from .5rem to pixels based on your requirement */
            border-radius: 5px;
            color: white !important;
            background-color: rgb(31, 106, 177);
        }

        .Education {
            display: flex;
            flex-direction: column;
            gap: 0rem;
            align-items: center;
            width: 850px;
        }

        .Education h2 {
            border-top: 1px rgb(112, 111, 111) solid;
            border-bottom: 1px rgb(112, 111, 111) solid;
            width: 96%;
            text-align: center;
        }

        .Education ul {
            width: 90%;
            display: grid;
            grid-template-columns: 1fr 1fr;
            padding-left: 10px; /* Adjusted from 1rem to pixels based on your requirement */
            gap: 5px; /* Adjusted from 1rem to pixels based on your requirement */
        }

        .Education ul li {
            display: flex;
            flex-direction: column;
        }

        .contact_info {
            display: flex;
            flex-direction: column;
            text-align: right;
        }

        .description_box {
            padding: 0 16px; /* Adjusted from 0rem 1rem to pixels based on your requirement */
            width: 850px;
        }

        .contact_info {
            height: 6rem;
            display:flex;
            flex-direction:column;
          
        }
        .contact_info p{
          margin:.1rem;
        }
        .work_des p{
          margin:.1rem;
        }
        .work_des h5,h3{
          margin:.1rem;
        }
        .ul{
          display:flex;
          flex-direction:column;
          gap:.2rem;
        }
        .ul li{
          margin-left:-1rem;
        }
        .edu_des h5,h4,p{
          margin:.1rem;
        }
        .name h1,p{
          margin:.1rem;
        }
        
    </style>
    </head>
    
    <body>
    <div onclick="setTemplateNo(8)" class="main">
        <div class="heading">
            <div class="name">
                <h1>John Doe</h1>
                <p>Software Developer</p>
            </div>
            <div class="contact_info">
            <a>john.doe@example.com</a>
            <p>123-456-7890</p>
            <p>123 Main St, Cityville | USA</p>
            <p>linkedin.com/in/johndoe</p>
        </div>
        </div>
        <div class="description_box">
            <p>
            Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.
            Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.
            Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.
            </p>
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
                <!-- Add more skills as needed -->
            </ul>
        </div>
        <div class="Experience">
            <h2>Work History</h2>
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
                
              
                <!-- Add more work experiences as needed -->
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
                <li class="edu_des">
                <h5>2016 - 2020</span>
                <h4>Bachelor of Science in Computer Science</h4>
                <p>University of Cityville</span> 
                </li>

               
                <!-- Add more education details as needed -->
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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.07,
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                    child: Text(
                                      'Shubham Singh',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff2d2e30),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 10),
                                    child: Text(
                                      'Profession',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff2d2e30),
                                        //fontWeight: FontWeight.w700
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                              height: MediaQuery.sizeOf(context).height * 0.89,
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                                  child: Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.schedule,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    const Text(
                                      'Resume Summary',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff2d2e30),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ]),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(42, 5, 0, 0),
                                  child: Text(
                                    'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                                  child: Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.work,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    const Text(
                                      'Experience',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff2d2e30),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ]),
                                ),
                                const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(42, 5, 6, 0),
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
                                            )),
                                      ))
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                                  child: Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.school,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    const Text(
                                      'Education',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff2d2e30),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ]),
                                ),
                                const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(42, 5, 6, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Masters',
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
                                                  '2019.08 - 2022.06',
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
                                              ],
                                            )),
                                      ))
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                                  child: Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.workspace_premium,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10.0), // Add some space between the icon and text
                                    const Text(
                                      'Certificates',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff2d2e30),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ]),
                                ),
                                const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(42, 5, 6, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Python',
                                                  style: TextStyle(
                                                    color: Color(0xff363c48),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  'Coursera ',
                                                  //textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Color(0xff363c48),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '2019.08 - 2019.12',
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
                                              ],
                                            )),
                                      ))
                                    ]),
                              ])),
                        ]),
                    Container(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                              child: Row(children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff2d2e30),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        10.0), // Add some space between the icon and text
                                const Text(
                                  'Personal Info',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xff2d2e30),
                                      fontWeight: FontWeight.w700),
                                ),
                              ]),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('Address',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('Susheela Sea Winds, Vaddem, Goa',
                                        style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w700,
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('Phone',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('+91 9503942697',
                                        style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w700,
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('E-mail',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('ss20010126@gmail.com',
                                        style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w700,
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('LinkedIn',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ))),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text('linkedin.com/5hubzzz',
                                        style: TextStyle(
                                          fontSize: 12,
                                          //fontWeight: FontWeight.w700,
                                        ))),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                              child: Row(children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff2d2e30),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        10.0), // Add some space between the icon and text
                                const Text(
                                  'Skills',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xff2d2e30),
                                      fontWeight: FontWeight.w700),
                                ),
                              ]),
                            ),
                            const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text(
                                          'adobe photoshop, after effects, figma, canva, flutter, dart, python, Data Structures and Algorithms, Programming Languages,  figma, canva, flutter, dart, python, Data Structures and Algorithms, Programming Languages, ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            //fontWeight: FontWeight.w700,
                                          ))),
                                ]),

                                    Padding(
                              padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                              child:
                              Row(children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff2d2e30),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.computer,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          10.0), // Add some space between the icon and text
                                  const Text(
                                    'Software',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xff2d2e30),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ]),
                             ),
                             const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        'Linux',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303845)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff303845),
                                              Color(0xff303845),
                                              Color(0xfffefefe),
                                              Color(0xfffefefe),
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
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        'Microsoft Teams',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303845)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff303845),
                                              Color(0xff303845),
                                              Color(0xfffefefe),
                                              Color(0xfffefefe),
                                            ],
                                            stops: [
                                              0.4,
                                              0.0,
                                              0.0,
                                              1.0
                                            ], // Adjust the stop values to control the filling level
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        'Visual Studio Code',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303845)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff303845),
                                              Color(0xff303845),
                                              Color(0xfffefefe),
                                              Color(0xfffefefe),
                                            ],
                                            stops: [
                                              0.4,
                                              0.0,
                                              0.0,
                                              1.0
                                            ], // Adjust the stop values to control the filling level
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                              padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                              child:
                              Row(children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff2d2e30),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.flag,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          10.0), // Add some space between the icon and text
                                  const Text(
                                    'Languages',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xff2d2e30),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ]),
                             ),
                             const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        'Spanish',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303845)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff303845),
                                              Color(0xff303845),
                                              Color(0xfffefefe),
                                              Color(0xfffefefe),
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
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        'German',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303845)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff303845),
                                              Color(0xff303845),
                                              Color(0xfffefefe),
                                              Color(0xfffefefe),
                                            ],
                                            stops: [
                                              0.4,
                                              0.0,
                                              0.0,
                                              1.0
                                            ], // Adjust the stop values to control the filling level
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        'French',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303845)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                      child: Container(
                                        height: 5,
                                        width: MediaQuery.sizeOf(context).width *
                                            0.4,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff303845),
                                              Color(0xff303845),
                                              Color(0xfffefefe),
                                              Color(0xfffefefe),
                                            ],
                                            stops: [
                                              0.4,
                                              0.0,
                                              0.0,
                                              1.0
                                            ], // Adjust the stop values to control the filling level
                                          ),
                                        ),
                                      ),
                                    ),
                          ]),
                    )
                  ]),
            )));
  }
}
