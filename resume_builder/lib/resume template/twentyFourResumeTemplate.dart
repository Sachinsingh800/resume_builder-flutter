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


class TwentyFourResumeTemplate extends StatefulWidget {
  File? image;

   TwentyFourResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwentyFourResumeTemplateState createState() =>
      _TwentyFourResumeTemplateState();
}

class _TwentyFourResumeTemplateState extends State<TwentyFourResumeTemplate> {
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
            display: grid;
            grid-template-columns: 1fr 2fr;
        }
        
.Left_container{
    display: flex;
    flex-direction: column;
}
  
  .container {
    /* padding: 13px 0 0 0; */

  }
  
  .name {
    color: white;
  }
  
  .hr {
    margin-left: 0.5rem ; /* 0.5rem */
    margin-right: 4.375rem; /* 4.375rem */
    color:white;
  }
  

  

  .email {
    color: white;
  }
  
  .phoneIcon {
    font-size: 12px;
  }

  
  .contactInfo {
    display: flex;
    gap: .8rem;
    padding: .3rem;
    margin-left: 1rem;

  }
  .skillsHeader {
    
    display: flex;
    flex-direction: column;
    gap: .5rem;
  }

  .skillsHeader h3{
    border-bottom: 1px rgb(0, 0, 0) solid;
    margin-left: 1rem;
  }

  .skillsHeader ul{
   list-style: none;
  padding: 0rem 2rem 0rem 1rem;

  }
  .skillsHeader ul li{
display: flex;
flex-direction: column;

  }
  .skillsHeader2{
      padding: 0!important;
  }
  .skillsHeader2 p{
    margin: 1rem;
  }
  .skillsHeader2 h2{
    display: flex;
    align-items: center;
    gap: .5rem;
    padding: .5rem 2rem;
    font-weight: 400;
  }
  .skillsHeader2 ul{
    margin-left: 1.5rem;
  }
  .professionalSkillsHeader ul{
    margin-left: 1.5rem;
  }

  .info_box{
    display: flex;
    flex-direction: column;
    gap: .5rem;
    padding: 0rem 2rem;
  }
  .info_box h3{
    margin-left: .5rem;
  }
  
  .educationHeader{
    padding: 1.5rem;
  }
  .objectiveHeader{
    padding: 1.5rem;
    height: 8rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
   margin-bottom: 1rem;
   margin-top: 3rem;
  }
  .workHeader{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .skillsHeader2{
    padding: 1rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: .5rem;
  }
  .professionalSkillsHeader{
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 1rem;
  }
  .professionalSkillsHeader h2{
    display: flex;
    align-items: center;
    gap: .5rem;
    padding: .5rem 2rem;
    font-weight: 400;
  }
  .img_container{
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .img_box{
    height: 16rem!important;
    width: 100%!important;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 6rem;
}
.img_box img{
    height: 100%;
    width: 100%;
    border-radius: 0;
}
.person_name{
  font-size: 3rem;
}
.person_name span{
  color: black;
}
.company_name{
  display: flex;
  justify-content: space-between;
  color: black;
}
.work_des{
  display: flex;
  flex-direction: column;
  gap:.5rem ;
  padding: 0rem 1rem;
}
.img_container{
  display: flex;
  align-items: center;
  justify-content: center;
  height: 10rem;
}
.skillsAndLevel{
  display: grid;
  grid-template-columns: 1fr 1fr ;
  gap: .5rem;
  padding: 1rem;
}
.skillsAndLevel li{

  overflow: hidden;
}

.skillsAndLevel li span{
  margin-left: 1rem;
}

.title_box{
  display: flex;
  width: 100%;
  background-color: white;
}
.title_box2{
  display: flex;
  width: 95%;
 align-items:center ;
 gap: .5rem;
 border-bottom: 1px rgb(8, 8, 8) solid;
 margin-left: 1rem;
 padding:0rem!important;
 
}
.title_box2 h3{
    margin:0rem;
}
.objectiveHeader h1,p{
    margin:0rem;
}
.edu-ul{
    flex-direction: column;
    display: flex;
    gap:.2rem;
    margin-top:-1rem;
}
.contactInfo{
  padding:0rem;
}
.ref-ul{
    margin-top:-1rem;
}
.ref-ul li h4{
    margin:0rem;
}
.work_des h4,h5,p{
    margin:0rem;
}
.work-ul{
    margin-top:-.3rem;
    margin-left:-.3rem!important;
    flex-direction: column;
    display: flex;
    gap:1rem;
}
.ProgressBar {
    background-color: orange;
    height:.2rem;
    width:10rem;
}
.skillsAndLevel{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap:1rem;
    margin-top:-.8rem;

}
.skillsAndLevel li{
    text-align: left;
}
        </style>
        <title>Your Page Title</title>
    </head>
    
    <body>
        <div class="main">
            <div class="Left_container">
                <div class="img_container">
                    <div class="img_box">
                        <img src="" alt="dp">
                    </div>
                </div>
                <br/>
                <br/>
                <br/>
                <br/>
                <br/>
                <div class="skillsHeader">
                    <h3>EDUCATION</h3>
                    <ul class="edu-ul">
                        <li style="color: black;">
                            <span>
                                Bachelor's Degree
                                <span>
                                    2015 - 2019
                                </span>
                            </span>
                            <span>University XYZ</span>
                        </li>
                        <li style="color: black;">
                            <span>
                                Bachelor's Degree
                                <span>
                                    2015 - 2019
                                </span>
                            </span>
                            <span>University XYZ</span>
                        </li>
                        <li style="color: black;">
                            <span>
                                Bachelor's Degree
                                <span>
                                    2015 - 2019
                                </span>
                            </span>
                            <span>University XYZ</span>
                        </li>
                        <!-- More education items here -->
                    </ul>
                </div>
    
                <div class="skillsHeader">
                    <h3>CONTACT</h3>
                    <div>
                     <div class="contactInfo">
                        <p class="email" style="color: black;">
                            <span>Email</span>
                            example@email.com
                        </p>
                    </div>
                    <div class="contactInfo">
                        <p style="color: black;" class="email">
                            <span>Phone</span>
                            +1234567890
                        </p>
                    </div>
    
                    <div class="contactInfo">
                        <p style="color: black;">
                            <span>Address</span>
                            123 Main St, City
                        </p>
                    </div>
                    </div>

                   
                </div>
    
                <div class="skillsHeader">
                    <h3>REFERENCES</h3>
                    <ul class="ref-ul">
                        <li style="color: black;">
                            <h4>John Doe</h4>
                            <span>Position | ABC Company</span>
                            <span>(123) 456-7890</span>
                        </li>
                        <!-- More references items here -->
                    </ul>
                </div>
            </div>
    
            <div>
                <div class="objectiveHeader">
                    <h1 class="person_name">Jessica Claire</h1>
                    <p class="objectiveText">Frontend Developer</p>
                </div>
                 <br/>
          
                <div class="skillsHeader2" style="margin-top:.7rem;">
                    <div class="title_box2" >
                        <h3>About Me</h3>
                    </div>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        Nullam nec hendrerit urna, at convallis ex. Praesent et
                        convallis libero, a fermentum tellus.
                    </p>
                </div>
    
                <div class="professionalSkillsHeader">
                    <div class="title_box2">
                        <h3>WORKING EXPERIENCE</h3>
                    </div>
                    <ul class="work-ul">
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Software Engineer</h4>
                                <h5 class="company_name">
                                    <span>ABC Company - Location</span>
                                    <span>2019.08 - Present</span>
                                </h5>
                                <p>
                                    Lorem Ipsum is simply dummy text of the printing
                                    and typesetting industry.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Software Engineer</h4>
                                <h5 class="company_name">
                                    <span>ABC Company - Location</span>
                                    <span>2019.08 - Present</span>
                                </h5>
                                <p>
                                    Lorem Ipsum is simply dummy text of the printing
                                    and typesetting industry.
                                </p>
                            </div>
                        </li>
                        <li>
                            <div class="work_des">
                                <h4 class="customerService">Software Engineer</h4>
                                <h5 class="company_name">
                                    <span>ABC Company - Location</span>
                                    <span>2019.08 - Present</span>
                                </h5>
                                <p>
                                    Lorem Ipsum is simply dummy text of the printing
                                    and typesetting industry.
                                </p>
                            </div>
                        </li>
                        <!-- More work experience items here -->
                    </ul>
                </div>
    
                <div class="professionalSkillsHeader">
                    <div class="title_box2" style="paddingLeft:2rem;" >
                        <h3>SOFTWARE SKILL</h3>
                    </div>
                    <ul class="skillsAndLevel">
                        <li>
                            <p>JavaScript</p>
                            <div class="ProgressBar">
                                <div style="width: 40%;"></div>
                            </div>
                        </li>
                        <li>
                            <p>JavaScript</p>
                            <div class="ProgressBar">
                                <div style="width: 40%;"></div>
                            </div>
                        </li>
                        <li>
                            <p>JavaScript</p>
                            <div class="ProgressBar">
                                <div style="width: 40%;"></div>
                            </div>
                        </li>
                        <li>
                            <p>JavaScript</p>
                            <div class="ProgressBar">
                                <div style="width: 40%;"></div>
                            </div>
                        </li>
                        <!-- More software skills items here -->
                    </ul>
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
      backgroundColor: Colors.white,
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
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                  width: MediaQuery.sizeOf(context).width,
                  color: const Color(0xffe2ac52),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shubham Singh ',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Phone: 9503942697',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Software Engineer',
                      //textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Email: work.abc@gmail.com',
                      //textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      //textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Linkedin: linkedin.com/5hubzzz',
                      //textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                  child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(),
                      child: const Text(
                        'Personall business developoer with more than forue year of experintence in the dbusiness developpment of incinble in proudnt testing managerment and developeing',
                        style: TextStyle(
                          fontSize: 12,
                          //fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
                const Text(
                  'RELEVANT SKILLS',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
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
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'SEO',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'negotaition',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'Twam work',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                                              padding: EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'decisoing',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                                              padding: EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'research',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                                              padding: EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'interlignce',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                                              padding: EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'outbounded',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                                              padding: EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'email marketing',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                                              padding: EdgeInsets.all(4),

                        decoration: const BoxDecoration(
                          color: Color(0xffe2ac52),
                        ),
                        child: const Text(
                          'public speaking',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Text(
                  'PROFESSIONAL EXPERIENCE',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                const Text(
                  'Business Deveopkment Manager',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'AirState Solution',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '09/2022-01-2023',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '- Sucessful magnged millions bges promects are sucessuflu archiedbe the project',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 12,
                  ),
                ),
                const Text(
                  '- Rsnsirea so that dchancn wiell grow a inteo a lowaj contronre lornalty prongamrda',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 12,
                  ),
                ),
                const Text(
                  '- Reviewrd cosntantly the coustkrer freevak amd teem usgested ways to imporive the promcea and level wiht jmcerea te',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 12,
                  ),
                ),
                const Padding(
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
                const Text(
                  'AirState Solution',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '09/2022-01-2023',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '- Sucessful magnged millions bges promects are sucessuflu archiedbe the project',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 12,
                  ),
                ),
                const Text(
                  '- Rsnsirea so that dchancn wiell grow a inteo a lowaj contronre lornalty prongamrda',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 12,
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                  child: Text(
                    '- Reviewrd cosntantly the coustkrer freevak amd teem usgested ways to imporive the promcea and level wiht jmcerea te',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 12,
                    ),
                  ),
                ),

                const Text(
                  'EDUCATION',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xFF1C1B20),
                ),
                const Padding(
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
                const Padding(
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
                const Text(
                  '09/2022-01-2023',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                  child: Text(
                    'Bsc in econineinva and bu9isnedd adminstreatioan',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Padding(
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
                const Text(
                  '09/2022-01-2023',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),

               Padding(
                 padding: const EdgeInsets.fromLTRB(0,20,0,0),
                 child: Container(
                    height: 5,
                    width: MediaQuery.sizeOf(context).width,
                    color: const Color(0xffe2ac52),
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
