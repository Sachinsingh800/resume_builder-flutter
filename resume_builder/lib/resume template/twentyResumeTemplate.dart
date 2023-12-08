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

class TwentyResumeTemplate extends StatefulWidget {
  File? image;
   TwentyResumeTemplate({Key? key,  this.image}) : super(key: key);

  @override
  _TwentyResumeTemplateState createState() =>
      _TwentyResumeTemplateState();
}

class _TwentyResumeTemplateState
    extends State<TwentyResumeTemplate> {
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
        <link rel="stylesheet" href="your-style.css">
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
        
    .heading{
      display: flex;
      justify-content: space-between;
      width: 52rem; 
      padding: 1rem ;
  }
  .heading div{
      width: 50%;
      overflow: hidden;
  }
  .summary h2{
      border-top: 1px  rgb(112, 111, 111) solid;
      border-bottom: 1px rgb(112, 111, 111) solid;
      width: 90%;
  }
  .para{
      width: 96%;
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
  .Experience h3{

      border-bottom: 1px rgb(112, 111, 111) solid;
      width: 96%;
  }
  .Experience ul{
      width: 90%;
  }
  .Skills h2{

      border-bottom: 1px rgb(112, 111, 111) solid;
      width: 96%;
    
  }
  .Skills {
      display: flex;
      align-items: center;
      flex-direction: column;
  }
  .Skills ul{
      width: 90%;
      
      margin-top:-1rem;
      margin-left:-6rem;
     
  }
  .Skills ul li{
     width: max-content;
      display: inline-table;
      padding: .5rem;
      margin: .5rem;
      border-radius: 5px;
      color: white!important;
      background-color: rgb(215, 168, 57);
      
  }

  .Eucation{
      display: flex;
      align-items: center;
      flex-direction: column;
  }

  .Eucation h3{
      border-bottom: 1px rgb(112, 111, 111) solid;
      width: 96%;
  }

  .Eucation ul{
      width: 90%;
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap:.5rem;
      margin-left:-4rem;
  }
  .Eucation ul li{
      display: flex;
      flex-direction: column;
  }
  .contact_info{
      display: flex;
      flex-direction: column;
      text-align: right;
  }
  .description_box{
      padding: 1rem;
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
  margin-left:-3rem;
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
        <div class="main">
            <div class="heading">
                <div class="name">
                    <h1>Jessica Claire</h1>
                    <p>Frontend Developer</p>
                </div>
                <div class="contact_info">
                    <p>jessica.claire@example.com</p>
                    <p>+1 234 567 890</p>
                    <p>123 Main Street, Cityville, Country</p>
                    <p>linkedin.com/in/jessicaclaire</p>
                </div>
            </div>
            <div class="description_box">
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
            </div>
            <div class="Skills">
                <h2>RELEVANT SKILLS</h2>
                <ul class="skill-list">
                    <li style="color: #333;"><span>JavaScript</span></li>
                    <li style="color: #333;"><span>React.js</span></li>
                    <li style="color: #333;"><span>HTML</span></li>
                    <li style="color: #333;"><span>CSS</span></li>
                </ul>
            </div>
            <div class="Experience">
                <h3>PROFESSIONAL EXPERIENCE</h2>
                <ul class="ul">
                    <li>
                        <div class="work_des">
                            <div>
                                <h4 class="customerService">Frontend Developer</h4>
                                <h5 class="company_name"><span>ABC Company - Cityville</span> ,
                                <span>Jan 2022 - Present</span></h5>
                            </div>
                            <div>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <div >
                                <h4 class="customerService">Frontend Developer</h4>
                                <h5 class="company_name"><span>ABC Company - Cityville</span>, <span>Jan 2022 - Present</span></h5>
                            </div>
                            <div>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <div>
                                <h4 class="customerService">Frontend Developer</h4>
                                <h5 class="company_name"><span>ABC Company - Cityville</span>,<span>Jan 2022 - Present</span></h5>
                            </div>
                            <div>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                            </div>
                        </div>
                    </li>
                    <!-- Repeat the above block for each work entry -->
                </ul>
            </div>
            <div class="Eucation">
                <h3>EDUCATION</h2>
                <ul>
                    <li style="color: #333;">
                        <span>2018 - 2022</span>
                        <h4>Bachelor of Science in Computer Science</h4>
                        <span>University of XYZ</span>
                    </li>
                    <li style="color: #333;">
                        <span>2018 - 2022</span>
                        <h4>Bachelor of Science in Computer Science</h4>
                        <span>University of XYZ</span>
                    </li>
                    <li style="color: #333;">
                        <span>2018 - 2022</span>
                        <h4>Bachelor of Science in Computer Science</h4>
                        <span>University of XYZ</span>
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
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 25,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RAM',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF3E78C1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'KUMAR',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 20,
                                ),
                          ),
                          Text(
                            'XXPOSITION/TITLEX',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF3E78C1),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address, xCity,XState,XCountry',
                        style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 10,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          '56262564646',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Text(
                          'erewr@gmerer.com',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.35,
                    height: MediaQuery.of(context).size.height*0.80,
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E5E5),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SKILLS',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF3E78C1),
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            'lREORJ ERJIO RJ RJE ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                          Text(
                            'lREORJ ERJIO RJ RJE ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                          Text(
                            'lREORJ ERJIO RJ RJE ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                          Text(
                            'lREORJ ERJIO RJ RJE ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'TRAINING & CERTIFICATIONS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            '- ERe Certificate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- ERe Certificate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- ERe Certificate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- ERe Certificate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- ERe Certificate',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'AWARDS & HONORS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            '- Wrld chamiapoma award',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- Wrld chamiapoma award',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- Wrld chamiapoma award',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'LANGUAGES',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            'Hindi',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'PROJECTS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            '- CJER pROJECT',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- CJER pROJECT',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- CJER pROJECT',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- CJER pROJECT',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'INTERESTS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          Text(
                            '- Software Developer',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- Flutter Developer',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            '- Frontend Developer',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.65,
                    height: MediaQuery.of(context).size.height*0.80,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ABOUT ME',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xFF3E78C1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Color(0xFF3E78C1),
                          ),
                          Text(
                            'rhtkjth oirh tkjrh tijrhtjk rhtji etjkerwh thertejith krthg rjekthjkreh jkrehtjkreh rjkethruith iurthh rieh ruiehtui ruith thrith ioith hort khrt uirht rtkjr klttjhtkl hkorth uiorhtj tjkrh ioerkljewhrtklhnkseeutio erjkhtior grhwthrkj jketehtjkehtkrhrtweit ihtuiwerhti hwjkrth iohiot hiotwerph',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'CAREER HIGHLIGHTS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Color(0xFF3E78C1),
                          ),
                          Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                          Text(
                            '- hekthrk rthkij trh ikerjkht iorth',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 9,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'WORK EXPERIENCE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Color(0xFF3E78C1),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'XXCOMPANY',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Text(
                                  'APRIL 2011- CURRENT',
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF3E78C1),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 5, 0, 0),
                                child: Text(
                                  'XCITY, xSTATE',
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.black,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'XXCOMPANY',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Text(
                                  'APRIL 2011- CURRENT',
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF3E78C1),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(3, 5, 0, 0),
                                child: Text(
                                  'XCITY, xSTATE',
                                  style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.black,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- hekthrk rthkij trh ikerjkht iorth',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'EDUCATION',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Color(0xFF3E78C1),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(3, 5, 0, 0),
                            child: Text(
                              'xSCHOOL ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'APRIL 2011- jUNE 2018',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'XCITY, XSTATE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(3, 5, 0, 0),
                            child: Text(
                              'xSCHOOL ',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'APRIL 2011- jUNE 2018',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3E78C1),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'XCITY, XSTATE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
