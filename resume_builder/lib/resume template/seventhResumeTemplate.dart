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

class SeventhResumeTemplate extends StatefulWidget {
  File? image;
   SeventhResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SeventhResumeTemplateState createState() => _SeventhResumeTemplateState();
}

class _SeventhResumeTemplateState extends State<SeventhResumeTemplate> {

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
        body: SafeArea(
            top: true,
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
                body: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child:  Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(8, 20, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          globalController.name.value,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color(0xff3b3b3b),
                                              letterSpacing: 1.0),
                                        ),
                                        Text(
                                            globalController.name.value,
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Color(0xff3b3b3b),
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 1.0),
                                        ),
                                        Text(
                                            globalController.bio.value,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff3b3b3b)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.business_center,
                                                color: Color(0xff3b3b3b),
                                              ),
                                              SizedBox(
                                                  width:
                                                      30.0), // Add some space between the icon and text
                                              Text(
                                                'EXPERIENCE',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2015',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Soft Design Studio',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2017',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Lead Web Designer',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(55, 8, 0, 0),
                                            child: Text(
                                                'Lorem Ipsum is not only five centuries, unchanged. It was popularised in  Ipsum')),


                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2015',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Soft Design Studio',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2017',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Lead Web Designer',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(55, 8, 0, 0),
                                            child: Text(
                                                'Lorem Ipsum is only five centuries, unchanged. It was popularised in  Ipsum')),

                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.school,
                                                color: Color(0xff3b3b3b),
                                              ),
                                              SizedBox(
                                                  width:
                                                      30.0), // Add some space between the icon and text
                                              Text(
                                                'EDUCATION',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2015',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Soft Design Studio',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2017',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Lead Web Designer',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(55, 8, 0, 0),
                                            child: Text(
                                                'Lorem Ipsum is only five centuries, unchanged. It was popularised in  Ipsum')),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2015',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Soft Design Studio',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2017',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      16.0), // Add some space between the icon and text
                                              Text(
                                                'Lead Web Designer',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(55, 8, 0, 0),
                                            child: Text(
                                                'Lorem Ipsum is only five centuries, unchanged. It was popularised in  Ipsum')),
                                      ],
                                    ))
                              ])),
                      Container(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.asset(
                                                "assets/images/person.png",
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(0, 18, 0, 0),
                                              child: Text('ABOUT ME',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight.bold,
                                                  ))),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(0, 15, 0, 0),
                                              child: Text(
                                                  'Lorem Ipsum is only five centuries, unchanged. It was popularised in  Ipsum Lorem Ipsum is only five centuries, unchanged.')),
                                        ])),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 18, 0, 0),
                                    child: Text('CONTACTS',
                                        style: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                        ))),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Color(0xff3b3b3b),
                                      ),
                                      SizedBox(
                                          width:
                                              5.0), // Add some space between the icon and text
                                      Text(
                                        '+91 9503942697',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: Color(0xff3b3b3b),
                                      ),
                                      SizedBox(
                                          width:
                                              5.0), // Add some space between the icon and text
                                      Text(
                                        'ss20126@gmail.com',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.language,
                                        color: Color(0xff3b3b3b),
                                      ),
                                      SizedBox(
                                          width:
                                              5.0), // Add some space between the icon and text
                                      Text(
                                        'lauraandreason.com',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Color(0xff3b3b3b),
                                      ),
                                      SizedBox(
                                          width:
                                              5.0), // Add some space between the icon and text
                                      Text(
                                        'Vasco-da-gama, Goa.',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 18, 0, 0),
                                    child: Text('SKILLS',
                                        style: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                        ))),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                    child: Text('//TECHNICAL SKILLS',
                                        style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                        ))),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text('Adobe Photoshop',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ))),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text('Adobe Photoshop',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ))),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text('Adobe Photoshop',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ))),
                               const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                    child: Text('//MY PRO SKILLS',
                                        style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                        ))),
                                        const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text('Adobe Photoshop',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ))),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text('Adobe Photoshop',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ))),
                                const Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                    child: Text('Adobe Photoshop',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ))),
                              ]))
                    ]),
              ),
            )),
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
        <!-- Include any necessary stylesheets or meta tags here -->
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
  align-items: center;
  flex-direction: column;
  justify-content: center;
  height: 5rem;
  width: 52rem; 
}
.summary h2{
  border-top: 1px  rgb(112, 111, 111) solid;
  border-bottom: 1px rgb(112, 111, 111) solid;
  width: 90%;
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
  border-top: 1px  rgb(112, 111, 111) solid;
  border-bottom: 1px rgb(112, 111, 111) solid;
  width: 90%;
}
.Experience ul{
  width: 90%;
}
.ul {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap:.5rem;
}
.Skills h2{
  border-top: 1px  rgb(112, 111, 111) solid;
  border-bottom: 1px rgb(112, 111, 111) solid;
  width: 90%
}
.Skills {
  display: flex;
  align-items: center;
  flex-direction: column;
}
.Skills ul{
  width: 90%;
  display: grid;
  grid-template-columns: 1fr 1fr;
}
.heading h1,p{
 margin:0rem;
}
.ul{
  margin-left:-1rem;
  margin-top:-1rem;
}
.work_des h3,h5{
  margin:0rem;
}
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="heading">
                <h1>John Doe</h1>
                <p>john.doe@example.com | 123-456-7890</p>
            </div>
            <div class="summary">
                <h2>Summary</h2>
                <p class="para">Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.</p>
            </div>
            <div class="Experience">
                <h2>Experience</h2>
           
                <ul class="ul">
                    <li>
                        <div class="work_des">
                            <h3 class="customerService">Software Engineer</h3>
                            <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                            <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <h3 class="customerService">Software Engineer</h3>
                            <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                            <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <h3 class="customerService">Software Engineer</h3>
                            <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                            <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                        </div>
                    </li>
                    <!-- Add more work experiences as needed -->
                </ul>
            </div>
            <div class="Experience">
                <h2>Education</h2>
              
                <ul class="ul">
                    <li >
                        <h5>Bachelor of Science in Computer Science</span>
                    
                        <p>2016 - 2020</span>
                 
                        <p>University of Cityville</span>
                    </li>
                    <li >
                        <h5>Bachelor of Science in Computer Science</span>
                    
                        <p>2016 - 2020</span>
                 
                        <p>University of Cityville</span>
                    </li>
                    <!-- Add more education details as needed -->
                </ul>
            </div>
            <div class="Skills">
                <h2>Skills</h2>
              
                <ul class="ul">
                    <li >
                        <span>JavaScript</span>
                        <ProgressBar bgcolor="orange" progress="40" height="5" />
                    </li>
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
        <!-- Include any necessary stylesheets or meta tags here -->
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
  align-items: center;
  flex-direction: column;
  justify-content: center;
  height: 5rem;
  width: 52rem; 
}
.summary h2{
  border-top: 1px  rgb(112, 111, 111) solid;
  border-bottom: 1px rgb(112, 111, 111) solid;
  width: 90%;
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
  border-top: 1px  rgb(112, 111, 111) solid;
  border-bottom: 1px rgb(112, 111, 111) solid;
  width: 90%;
}
.Experience ul{
  width: 90%;
}
.ul {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap:.5rem;
}
.Skills h2{
  border-top: 1px  rgb(112, 111, 111) solid;
  border-bottom: 1px rgb(112, 111, 111) solid;
  width: 90%
}
.Skills {
  display: flex;
  align-items: center;
  flex-direction: column;
}
.Skills ul{
  width: 90%;
  display: grid;
  grid-template-columns: 1fr 1fr;
}
.heading h1,p{
 margin:0rem;
}
.ul{
  margin-left:-1rem;
  margin-top:-1rem;
}
.work_des h3,h5{
  margin:0rem;
}
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="heading">
                <h1>John Doe</h1>
                <p>john.doe@example.com | 123-456-7890</p>
            </div>
            <div class="summary">
                <h2>Summary</h2>
                <p class="para">Passionate software developer with expertise in web development and problem-solving. Excited to contribute to innovative projects.</p>
            </div>
            <div class="Experience">
                <h2>Experience</h2>
           
                <ul class="ul">
                    <li>
                        <div class="work_des">
                            <h3 class="customerService">Software Engineer</h3>
                            <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                            <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <h3 class="customerService">Software Engineer</h3>
                            <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                            <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                        </div>
                    </li>
                    <li>
                        <div class="work_des">
                            <h3 class="customerService">Software Engineer</h3>
                            <h5 class="company_name"><span>ABC Company - Cityville</span> <span>Jan 2020 - Present</span></h5>
                            <p>Contributed to the development of innovative web applications using cutting-edge technologies.</p>
                        </div>
                    </li>
                    <!-- Add more work experiences as needed -->
                </ul>
            </div>
            <div class="Experience">
                <h2>Education</h2>
              
                <ul class="ul">
                    <li >
                        <h5>Bachelor of Science in Computer Science</span>
                    
                        <p>2016 - 2020</span>
                 
                        <p>University of Cityville</span>
                    </li>
                    <li >
                        <h5>Bachelor of Science in Computer Science</span>
                    
                        <p>2016 - 2020</span>
                 
                        <p>University of Cityville</span>
                    </li>
                    <!-- Add more education details as needed -->
                </ul>
            </div>
            <div class="Skills">
                <h2>Skills</h2>
              
                <ul class="ul">
                    <li >
                        <span>JavaScript</span>
                        <ProgressBar bgcolor="orange" progress="40" height="5" />
                    </li>
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
    );
  }
}
