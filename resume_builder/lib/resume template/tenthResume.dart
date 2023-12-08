import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/global_controller.dart';
import '../controller/postResume.dart';
import '../screen/PDFFormat.dart';
import '../widget/pannel_widget.dart';
class TenthResumeTemplate extends StatefulWidget {
  File? image;
   TenthResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  _TenthResumeTemplateState createState() => _TenthResumeTemplateState();
}

class _TenthResumeTemplateState extends State<TenthResumeTemplate> {

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
    bool _isLoading = false;
    return Scaffold(
      backgroundColor: Colors.white,
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
        <link rel="stylesheet" href="styles.css"> 
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
            padding:1rem;
        }
        .
        .heading{
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 5rem;
            width: 52rem; 
        }
        .summary h3{
            width: 90%;
        }
        .para{
            width: 90%;
        }
        .summary {
            display: flex;
          
            flex-direction: column;
        }
        .Experience{
            display: flex;
          
            flex-direction: column;
        }
        .Experience h3{
            width: 90%;
        }
        .Experience ul{
            width: 90%;
            
        }
        .Skills h3{
    
            width: 90%
        }
        .Skills {
            display: flex;
          
            flex-direction: column;
        }
        .Skills ul{
            width: 90%;
            display: grid;
            grid-template-columns: 1fr 1fr;
            padding-left: 1rem;
        }
        .customerService{
            display: flex;
            justify-content: space-between;
          
        }
       
        .heading h1,h3,p{
          margin:0rem;
        }
        .education h5{
          margin:0rem;
        }
        .work-des h4,p,h6{
          margin:0rem!important;
        }
        .edu-ul{
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap:.5rem;
          margin-left:-1.2rem;
        }
        .work-ul{
          display: grid;
          grid-template-columns: 1fr ;
          gap:.5rem;
          margin-left:-1.2rem;
        }
        </style>
     
        <title>Your Page Title</title>
    </head>
    
    <body>
        <div class="main">
            <div class="heading">
                <h1>John Doe</h1>
                <h3>Web Developer</h3>
                <p>john.doe@example.com | 123-456-7890</p>
            </div>
             <br/>
            <div class="summary">
                <h3>Summary</h3>
                <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet quam at purus varius bibendum.
                </p>
            </div>
            <br/>
            <div >
                <h3>Work Experience</h3>
                <ul class="work-ul">
                    <li>
                        <div class="work-des">
                            <h4 class="customerService"><span>Front-End Developer</span></h4>
                            <h6>Jan 2018 - Dec 2020</h6>
                            <h6 class="company_name"><span>Example Corp - New York</span></h6>
                            <p>Responsible for developing and maintaining user interfaces, ensuring responsiveness, and
                                collaborating with the back-end team to integrate with server-side logic.</p>
                        </div>
                    </li>
                    <li>
                        <div class="work-des">
                            <h4 class="customerService"><span>Front-End Developer</span></h4>
                            <h6>Jan 2018 - Dec 2020</h6>
                            <h6 class="company_name"><span>Example Corp - New York</span></h6>
                            <p>Responsible for developing and maintaining user interfaces, ensuring responsiveness, and
                                collaborating with the back-end team to integrate with server-side logic.</p>
                        </div>
                    </li>
                    <li>
                        <div class="work-des">
                            <h4 class="customerService"><span>Front-End Developer</span></h4>
                            <h6>Jan 2018 - Dec 2020</h6>
                            <h6 class="company_name"><span>Example Corp - New York</span></h6>
                            <p>Responsible for developing and maintaining user interfaces, ensuring responsiveness, and
                                collaborating with the back-end team to integrate with server-side logic.</p>
                        </div>
                    </li>
                    <!-- Add more work experience items as needed -->
                </ul>
            </div>
    
            <div>
                <h3>Education</h3>
                <ul class="edu-ul">
                    <li class="education">
                        <h5>Master's Degree , 2015 - 2019</h5>
                        <p>University of Example</p>
                    </li>
                    <li class="education">
                        <h5>Master's Degree , 2015 - 2019</h5>
                        <p>University of Example</p>
                    </li>
                    <li class="education">
                        <h5>Master's Degree , 2015 - 2019</h5>
                        <p>University of Example</p>
                    </li>
                    <li class="education">
                        <h5>Master's Degree , 2015 - 2019</h5>
                        <p>University of Example</p>
                    </li>
                  
                    <!-- Add more education items as needed -->
                </ul>
            </div>
    
            <div >
                <h3>Skills</h3>
                <ul class="edu-ul">
                    <li>Skill 1</li>
                    <li>Skill 2</li>
                    <!-- Add more skills as needed -->
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
          body:Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFF2C6FA1),
                        fontSize: 20,
                      ),
                ),
                Text(
                  'Business Development Manager',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Color(0xFF3D4A49),
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Text(
                      'Personall business developoer with more than forue year of experintence in the dbusiness developpment of incinble in proudnt testing managerment and developeing',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'SKILLS',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF225B86),
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'SEO',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'negotaition',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'Twam work',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'decisoing',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'research',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'interlignce',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'outbounded',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'email marketing',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff06335f),
                        ),
                        child: Text(
                          'public speaking',
                          style:
                              TextStyle(color: Colors.white,
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'WORK EXPERIENCE',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF225B86),
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Text(
                  'Business Deveopkment Manager',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  'AirState Solution',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '09/2022-01-2023',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '- Sucessful magnged millions bges promects are sucessuflu archiedbe the project',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                ),
                Text(
                  '- Rsnsirea so that dchancn wiell grow a inteo a lowaj contronre lornalty prongamrda',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                ),
                Text(
                  '- Reviewrd cosntantly the coustkrer freevak amd teem usgested ways to imporive the promcea and level wiht jmcerea te',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Business Deveopkment Manager',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  'AirState Solution',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '09/2022-01-2023',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '- Sucessful magnged millions bges promects are sucessuflu archiedbe the project',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                ),
                Text(
                  '- Rsnsirea so that dchancn wiell grow a inteo a lowaj contronre lornalty prongamrda',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 12,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                  child: Text(
                    '- Reviewrd cosntantly the coustkrer freevak amd teem usgested ways to imporive the promcea and level wiht jmcerea te',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF225B86),
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                  child: Text(
                    'Msc in econineinva and bu9isnedd adminstreatioan',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                  child: Text(
                    'univnerty of chaingao',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Text(
                  '09/2022-01-2023',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    'EDUCATION',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF225B86),
                        ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                  child: Text(
                    'Americakm amagnalenfket asosoican ',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Text(
                  '09/2022-Present',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
