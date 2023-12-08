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

class TwentySixResumeTemplate extends StatefulWidget {
  File? image;
   TwentySixResumeTemplate({Key? key, this.image}) : super(key: key);

  @override
  _TwentySixResumeTemplateState createState() =>
      _TwentySixResumeTemplateState();
}

class _TwentySixResumeTemplateState
    extends State<TwentySixResumeTemplate> {

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
        <title>Jessica Claire's Resume</title>
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
          grid-template-columns: 1fr ;
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
       .heading{
         
          padding: 3rem 1rem;
       }
       
       .certifications{
        padding: 1rem;
        display: flex;
        flex-direction: column;
        gap: .5rem;
       }
       .skills{
          padding: 1rem;
          display: flex;
          flex-direction: column;
          gap: .5rem;
       
       }
       .skills ul{
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 1rem;
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
         background-color: rgb(215, 213, 213);
          height: 10rem;
          display: flex;
        align-items: center;
          justify-content: space-between;
          padding:  1rem;
       }
       .img_box{
           border-radius: 50%;
          margin-left: 2rem;
       }
       .section{
          display: flex;
          flex-direction: column;
          gap: .5rem;
       }
       .work_entry{
          display: grid;
          grid-template-columns: 1fr 1fr ;
          gap: 1rem;
          margin-top:-1rem;
       }
       .section_title{
           display: flex;
           align-items: center;
           gap: 2.7rem;
           padding-left: 1rem;
       
       }
       .title_{
           display: flex;
           justify-content: space-between;
           align-items: center;
           width: 90%;
       }
       .description{
           width: 25rem;
       }
       .contact_value{
           display: flex;
           align-items: center;
           gap: .2rem;
       
       }
       .name_box{
           width: 75%;
           display: flex;
           align-items: center;
           flex-direction: column;
           gap: .5rem;
       }
       
       .contact_label{
           font-size: small;
       }
       .contact_info{
       display:flex;
         justify-content: space-evenly;
         gap: .8rem;
         font-size: small;
       }
       .skills-list{
       display: grid!important;
        grid-template-columns: 1fr 1fr ;
       gap: .5rem;
       margin-left:-1rem;
       margin-top:-1rem;
       }
       .container_section1{
           display: grid;
           grid-template-columns: 1fr 1fr;
           padding: 1rem;
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
        .name_box h1,h5{
          margin:0rem;
        }
        .section-content{
         margin-top:-1rem;
        }
        .edu_des h5,h4,p{
         margin:.1rem;
       }
       .edu-info h4,p{
        margin:0rem;
       }
       .work{
      
         padding:0rem;
     
       }
    
       .section-title-exp{
     
        padding-left:1rem;
       }
       .work-div{
         margin-left: 1rem;
         padding:0rem;
       }
       .icon{
        height:1rem;
        width:1rem;
      }
      .hr{
        width:98%
      }
        </style>
    </head>
    
    <body>
        <div class="main">
            <div class="header">
                <div>
                    <div class="img_box">
                        <img src="" alt="dp" />
                    </div>
                </div>
                <div class="name_box">
                    <h1 class="name">JESSICA CLAIRE</h1>
                    <h5 class="name">Frontend Developer</h5>
                    <div class="contact_info">
                        <div class="contact_value">
                        <span class="icon">
                        <img class="icon" src="" alt="dp" />
                        </span>
                            <p class="contact-value">+91 9503942697</p>
                        </div>
                        <div class="contact_value">
                        <span class="icon">
                        <img class="icon" src="" alt="dp" />
                        </span>
                            <p class="contact-value">ss20010126@gmail.com</p>
                        </div>
                        <div class="contact_value">
                        <span class="icon">
                        <img class="icon" src="" alt="dp" />
                        </span>
                            <p class="contact-value">Enter Your Address here</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="container_section1">
                    <div class="section">
                        <h3 class="section-title">SUMMARY</h3>
                        <p class="section-content">
                            Lorem Ipsum is simply dummy text of scrambled it to make a ty It was popularised in the
                            1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more.
                        </p>
                    </div>
    
                    <div class="section">
                        <h3>EDUCATION</h3>
                        <div class="work_entry">
                        <div class="work">
                        <p class="date">2019.08 - 2023.09</p>
                        <div class="edu-info">
                            <h4 class="degree">Masters in Data Science</h4>
                            <p class="university">ABC College</p>
                        </div>
                        </div>
                        <div class="work">
                        <p class="date">2019.08 - 2023.09</p>
                        <div class="edu-info">
                            <h4 class="degree">Masters in Data Science</h4>
                            <p class="university">ABC College</p>
                        </div>
                        </div>
                           
                        </div>
                    </div>
                </div>
              <div class="hr"> <hr/></div> 
                <div class="section">
                    <h3 class="section-title-exp">EXPERIENCE</h3>
                    <div class="work_entry">
                        <div class="work-div">
                            <div class="title_">
                                <h3 class="position">Software Engineer</h3>
                                <p class="date">2019.08 - Present</p>
                            </div>
                            <p class="company">ABC Company</p>
                            <p class="description">
                                Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                including versions of Lorem Ipsum.
                            </p>
                        </div>
                        <div class="work-div">
                            <div class="title_">
                                <h3 class="position">Software Engineer</h3>
                                <p class="date">2019.08 - Present</p>
                            </div>
                            <p class="company">ABC Company</p>
                            <p class="description">
                                Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                including versions of Lorem Ipsum.
                            </p>
                        </div>
                        <div class="work-div">
                            <div class="title_">
                                <h3 class="position">Software Engineer</h3>
                                <p class="date">2019.08 - Present</p>
                            </div>
                            <p class="company">ABC Company</p>
                            <p class="description">
                                Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                including versions of Lorem Ipsum.
                            </p>
                        </div>
                        <div class="work-div">
                            <div class="title_">
                                <h3 class="position">Software Engineer</h3>
                                <p class="date">2019.08 - Present</p>
                            </div>
                            <p class="company">ABC Company</p>
                            <p class="description">
                                Lorem Ipsum is simply dummy text of Lorem Ipsum passages, and Aldus PageMaker
                                including versions of Lorem Ipsum.
                            </p>
                        </div>
                        <!-- Repeat the above block for each work entry -->
                    </div>
                </div>
                <div class="hr"> <hr/></div> 
                <div class="container_section1">
                    <div class="section">
                        <h3 class="section-title">SKILLS</h3>
                        <ul class="skills-list">
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                            <li>javascript </li>
                        </ul>
                    </div>
                    <div class="section">
                        <h3 class="section-title">LANGUAGE</h3>
                        <ul class="skills-list">
                            <li>Hindi</li>
                            <li>English</li>
                            <li>Urdu</li>
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
      body: SlidingUpPanel(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Align(
              alignment: AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEBASTIAN BENNETT',
                      style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      'WEB DESIGNER & DEVELOPER',
                      style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.35,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CONTACT',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    '0955606586',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'ereef@gmail.com',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'Delhi ,220542',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'EDUCATION',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Text(
                              'University',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              '- 2015-2016',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Text(
                            'B.A. in Businedd Adminitration',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 8,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'AWARDS & CERTIFICATIONS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- masrer Degree OF THE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- masrer Degree OF THE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              '- masrer Degree OF THE',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'SKILLS',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                              '- Negotitation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                              '- Negotitation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                              '- Negotitation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                              '- Negotitation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                              '- Negotitation',
                              style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.8,
                    child: VerticalDivider(
                      thickness: 1,
                      indent: 20,
                      color: Color(0xFF898989),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            'PROFILE',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Text(
                          'lorem imporiem sin iae  eiorej eorje ieorj joier eroij ioer  fnweijrqo fqenfiqrjowr qoie ioaewrjowejr iorqwjrie eoirjqiw ioerj ioejrio  IRJHTRIOTJ OIRTJRIOJ RIOTJ KK kretj klrtgjrtg krgjrklg klfgfklg fgmklgkl gfklg klfgkrejwjt owirjtoe orjewoj orgjiowerjhg iojroighwgo grjeojgo jgreotjhweriojfkwrjtio grofgtjo rjthiop[roerj jtiowrqtjr jtoweijrtioiowejrtwio jiorjioejer[jioe jirwojt ioijrweio[tj jrio[wejto rreoitj jriowtjh owrje',
                          style:
                              TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 8,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: Text(
                            'WORK EXPERIENCE',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Heatd of ritier eor',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            '- 2015-2016',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- eiurhqiwr or  rkrpoer',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- eiurhqiwr or  rkrpoer',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- KJHER HIOiro',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- jehriwh oeiwr oeiwru ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- jehriwh oeiwr oeiwru ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- jehriwh oeiwr oeiwru ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: Text(
                            'Heatd of ritier eor',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: Text(
                            '- 2015-2016',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- eiurhqiwr or  rkrpoer',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- KJHER HIOiro',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- jehriwh oeiwr oeiwru ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- jehriwh oeiwr oeiwru ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- jehriwh oeiwr oeiwru ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Text(
                            '- jehriwh oeiwr oeiwru ',
                            style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
