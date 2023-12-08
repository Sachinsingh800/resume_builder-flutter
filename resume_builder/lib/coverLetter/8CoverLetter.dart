import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/cover_controller.dart';
import '../controller/postResume.dart';
import '../models/get_all_cover.dart';
import '../pdf_viewer_screen.dart';
import '../utils/constants.dart';
import '../screen/PDFFormat.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

import '../widget/pannel_widget_cover.dart';

class EighthCoverLetter extends StatefulWidget {
  final String code;
  final GetAllCover? cover;
  const EighthCoverLetter({Key? key, required this.code, this.cover}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EighthCoverLetterState createState() => _EighthCoverLetterState();
}

class _EighthCoverLetterState extends State<EighthCoverLetter> {

  final GlobalKey genKey = GlobalKey();
  final screenshotController = ScreenshotController();
  final pdf = pw.Document();

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

  bool _isLoading = false;
  bool _isFetching = false;
  String firstName = "John";
  String lastName = "Doe";
  String profession = "Software Engineer";
  String date = "2023-07-13";
  String city = "New York";
  String rCity = "San Francisco";
  String state = "NY";
  String rState = "CA";
  String zip = "815312";
  String rZip = "54321";
  String phoneNumber = "1234567890";
  String rPhoneNumber = "9876543210";
  String email = "johndoe@example.com";
  String rEmail = "janesmith@example.com";
  String rFirstName = "Jane";
  String rLastName = "Smith";

  String companyName = "ABC Company";
  String subject = "Regarding Job Application";
  String greeting = "Dear Manager";
  String opening =
      "I am writing to express my interest in the software engineer position at ABC Company.";
  String letterBody =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit...";
  String callToAction =
      "I would welcome the opportunity to discuss my qualifications further...";
  String closing = "Thank you for considering my application.";
  String signature = "jhon Doe";
  String availability = "I am available for an interview...";
  String confidentiality = "I understand the importance of maintaining...";
  String gaps = "During my previous employment...";
  String relocation = "I am willing to relocate...";
  String salaryRequirements = "My salary requirements are flexible...";
  String tempID = "template7";
  String linkedin = "www.lildlen.com";
  String github = "www.github.com";
  String portfolio = "www.portfolio.com";

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }
  Future<Map<String, dynamic>> fetchData() async {
    setState(() {
      _isFetching = true;
    });
    final String? authToken = await loadToken();

    final headers = <String, String>{};
    if (authToken != null) {
      headers['x-auth-token'] =
      '$authToken';
    }

    if (authToken == null) {
      setState(() {
        _isFetching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No token"),
        ),
      );
    }

    final response = await http.get(
      Uri.parse(
          'https://lizmyresume.onrender.com/user/coverLetter/getParticularCoverLetter/${widget.cover!.sId}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      setState(() {
        _isFetching = false;
      });
      return json.decode(response.body);
    } else {
      setState(() {
        _isFetching = false;
      });
      throw Exception('Failed to load data');
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CoverController globalController = Get.find();
    if(widget.code == "update"){
      fetchData().then((data) {
        // Update the text fields with data from the API response
        setState(() {

          globalController.firstName.value = data['data']['nameAndContact']['firstName'] ?? "Null Null";
          globalController.lastName.value = data['data']['nameAndContact']['lastName'] ?? "Null Null";

          globalController.email.value = data['data']['nameAndContact']['email'] ?? 'no email';
          globalController.phoneNumber.value = data['data']['nameAndContact']['phoneNumber'] ?? 'no phone number';
          globalController.city.value = data['data']['nameAndContact']['city'] ?? 'no phone number';
          globalController.state.value = data['data']['nameAndContact']['state'] ?? 'no phone number';
          globalController.profession.value = data['data']['nameAndContact']['profession'] ?? 'no profession';
          globalController.zip.value = data['data']['nameAndContact']['zip'] ?? 'no profession';

          globalController.rFirstName.value = data['data']['recipient']['firstName'] ?? "Null Null";
          globalController.rLastName.value = data['data']['recipient']['lastName'] ?? "Null Null";

          globalController.rEmail.value = data['data']['recipient']['email'] ?? 'no email';
          globalController.rPhoneNumber.value = data['data']['recipient']['phoneNumber'] ?? 'no phone number';
          globalController.rCity.value = data['data']['recipient']['city'] ?? 'no phone number';
          globalController.rState.value = data['data']['recipient']['state'] ?? 'no phone number';
          globalController.rZip.value = data['data']['recipient']['zip'] ?? 'no profession';
          globalController.companyName.value = data['data']['recipient']['companyName'] ?? 'no profession';

          globalController.linkedin.value = data['data']['socialLinks']['linkedin'] ?? 'no profession';
          globalController.github.value = data['data']['socialLinks']['github'] ?? 'no profession';
          globalController.portfolio.value = data['data']['socialLinks']['portfolio'] ?? 'no profession';

          globalController.date.value = data['data']['date'] ?? 'no profession';
          globalController.subject.value = data['data']['subject'] ?? 'no profession';
          globalController.greeting.value = data['data']['greeting'] ?? 'no profession';
          globalController.opening.value = data['data']['opening'] ?? 'no profession';
          globalController.letterBody.value = data['data']['letterBody'] ?? 'no profession';
          globalController.callToAction.value = data['data']['callToAction'] ?? 'no profession';
          globalController.closing.value = data['data']['closing'] ?? 'no profession';
          globalController.signature.value = data['data']['signature'] ?? 'no profession';
          globalController.availability.value = data['data']['availability'] ?? 'no profession';
          globalController.confidentiality.value = data['data']['confidentiality'] ?? 'no profession';
          globalController.gaps.value = data['data']['gaps'] ?? 'no profession';
          globalController.relocation.value = data['data']['relocation'] ?? 'no profession';
          globalController.salaryRequirements.value = data['data']['salaryRequirements'] ?? 'no profession';
          globalController.tempID.value = data['data']['tempID'] ?? 'no profession';



        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch data from API ${error.toString()}"),
          ),
        );
      });
    }else{
      globalController.firstName.value = firstName;
      globalController.lastName.value = lastName;
      globalController.email.value = email;
      globalController.phoneNumber.value = phoneNumber;
      globalController.city.value = city;
      globalController.rCity.value = rCity;
      globalController.state.value = state;
      globalController.rState.value = rState;
      globalController.zip.value = zip;
      globalController.rZip.value = rZip;
      globalController.date.value = date;
      globalController.rFirstName.value = rFirstName;
      globalController.rLastName.value = rLastName;
      globalController.rEmail.value = rEmail;
      globalController.rPhoneNumber.value = rPhoneNumber;
      globalController.companyName.value = companyName;
      globalController.rEmail.value = rEmail;
      globalController.profession.value = profession;
      globalController.subject.value = subject;
      globalController.greeting.value = greeting;
      globalController.opening.value = opening;
      globalController.letterBody.value = letterBody;
      globalController.callToAction.value = callToAction;
      globalController.closing.value = closing;
      globalController.signature.value = signature;
      globalController.availability.value = availability;
      globalController.confidentiality.value = confidentiality;
      globalController.gaps.value = gaps;
      globalController.relocation.value = relocation;
      globalController.salaryRequirements.value = salaryRequirements;
      globalController.tempID.value = tempID;
      globalController.linkedin.value = linkedin;
      globalController.github.value = github;
      globalController.portfolio.value = portfolio;
    }

  }

  Future<void> _saveAndOpenPdf(String pdfBytes) async {
    Directory? directory;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {
        // if platform is android
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          print("No download directory");
          directory = await getExternalStorageDirectory();
          String tempPath = directory!.path;
          File file = File('$tempPath/example.pdf');
          await file.writeAsBytes(pdfBytes.codeUnits, flush: true);
          final String filePath = file.absolute.path;
          final Uri uri = Uri.file(filePath);
        } else {
          print("Download directory exists");
          String tempPath = directory.path;
          File file = File('$tempPath/$timestamp.pdf');
          await file.writeAsBytes(pdfBytes.codeUnits, flush: true);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PDFViewerScreen(
                    file: file,
                  )));
        }
      }
    } catch (error) {
      print('Error saving and opening PDF: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving and opening PDF: $error'),
        ),
      );
      // Handle the error (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    CoverController globalController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(

        onPressed: () async{
          if(widget.code == "update"){
            setState(() {
              _isLoading = true;
            });
            String message = await PostResume().updateCover(globalController, widget.cover!.sId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("$message"),
              ),
            );
            setState(() {
              _isLoading = false;
            });
          }else{
            setState(() {
              _isLoading = true;
            });
            String message = await PostResume().createCover(globalController);
            if (message == "created") {
              String pdfBytes = await PostResume().generatePdf("""
              
        <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Title</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Readex Pro', sans-serif;
    }

    .header-container {
      width: 100%;
      height: 100px;
      background-color: #000000;
      box-sizing: border-box;
      padding: 10px;
      color: #ffffff;
      font-weight: 600;
    }

    .header-container h1 {
      font-size: 24px;
    }

    .contact-info-container {
      width: 100%;
      background-color: #ffffff;
      box-sizing: border-box;
      padding: 10px;
    }

    .contact-info-container h1 {
      font-family: 'Readex Pro';
      color: #ffffff;
      font-size: 24px;
      font-weight: 600;
    }

    .contact-info-container p {
      font-family: 'Readex Pro';
      color: #ffffff;
      font-size: 12px;
      font-weight: 300;
    }

    .contact-info-container .contact-details {
      display: flex;
      align-items: center;
    }

    .contact-info-container .contact-details .contact-item {
      display: flex;
      align-items: center;
      margin-right: 10px;
    }

    .contact-info-container .contact-details .contact-item:last-child {
      margin-right: 0;
    }

    .contact-info-container .contact-details .contact-item i {
      margin-right: 5px;
    }

    .main-content-container {
      width: 100%;
      background-color: #ffffff;
      box-sizing: border-box;
      padding: 10px;
    }

    .main-content-container h2 {
      font-weight: 500;
    }

    .main-content-container .recipient-info {
      font-weight: 500;
    }

    .main-content-container .letter-text {
      font-size: 12px;
    }

    .main-content-container .closing {
      font-weight: 500;
    }

    .main-content-container .signature {
      font-family: 'Readex Pro';
      font-size: 16px;
      font-weight: 600;
    }
  </style>
</head>
<body>
  <div class="header-container">
    <h1>${globalController.firstName} ${globalController.lastName}</h1>
  </div>
  <div class="contact-info-container">
    <h1>${globalController.firstName} ${globalController.lastName}</h1>
    <p>${globalController.profession}</p>
    <div class="contact-details">
      <div class="contact-item">
        <i class="material-icons">mail_outlined</i>
        <p>${globalController.email}</p>
      </div>
      <div class="contact-item">
        <i class="material-icons">call</i>
        <p>${globalController.phoneNumber}</p>
      </div>
      <div class="contact-item">
        <i class="material-icons">language</i>
        <p>linkedin.com/5hubzzz</p>
      </div>
    </div>
  </div>
  <div class="main-content-container">
    <h2>${globalController.date},</h2>
    <p>Hiring manager ${globalController.rFirstName}</p>
    <p>${globalController.rCity} ${globalController.rState}</p>
    <p>Subject: ${globalController.subject}</p>
    <p>${globalController.greeting} ${globalController.firstName},</p>
    <div>
      <p>
        I am writing to express my strong interest in the [Job Title] position at ${globalController.companyName.value}, as advertised on [where you found the job posting, e.g., LinkedIn or the company's website]. I am excited about the opportunity to contribute my skills and experience to your team.<br><br>Throughout my career, I have honed my expertise in [mention your key skills and experience areas], and I am confident that my background makes me a perfect fit for this role. I am particularly drawn to [specific aspects of the company or the job posting that excite you], and I am eager to be part of your innovative and dynamic team.<br><br>${globalController.letterBody}<br><br>${globalController.callToAction}<br><br>${globalController.availability}${globalController.confidentiality}<br><br>I am highly motivated, detail-oriented, and thrive in fast-paced environments. I look forward to the opportunity to contribute to ${globalController.companyName}'s continued growth and success.<br><br>Thank you for considering my application. I am excited about the possibility of joining your team and would welcome the opportunity to discuss how my skills and experience align with your needs.
      </p>
    </div>
    <p>Best regards</p>
    <p>${globalController.firstName} ${globalController.lastName}</p>
  </div>
</body>
</html>





      """);
              await _saveAndOpenPdf(pdfBytes);
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
            setState(() {
              _isLoading = false;
            });
          }

        },
        child: _isLoading? CircularProgressIndicator(strokeWidth: 2, color: Colors.white,): Icon(widget.code == "update"?Icons.update:Icons.done),
      ),
      body: SafeArea(
        top: true,
        child:_isFetching?Center(child: CircularProgressIndicator()): SlidingUpPanel(
          minHeight: MediaQuery.of(context).size.height * 0.02,
          maxHeight: MediaQuery.of(context).size.height * 0.3,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          panelBuilder: (controller)=> PanelWidgetCover(
            controller: controller,
            globalController: globalController,
            callBack: (){
              setState(() {

              });
            },
          ),
          body: SingleChildScrollView(
            child: Screenshot(
              key: genKey,
              controller: screenshotController,
              child:
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child:  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 6, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${globalController.firstName} ${globalController.lastName}',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.mail_outlined,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  '${globalController.email}',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),

                              Icon(Icons.call, color: Colors.white, size: 18),
                              SizedBox(width: 5),
                              Text(
                                '${globalController.phoneNumber}',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.language, color: Colors.white, size: 18),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'linkedin.com/5hubzzz',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                '${globalController.date},',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                               Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  "Hiring manager ${globalController.rFirstName}",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                               Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  '${globalController.rCity} ${globalController.rState}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                               Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  'Subject: ${globalController.subject}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                               Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: Text(
                                  '${globalController.greeting} ${globalController.firstName},',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: (){
                                  _showCustomDialog(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child:  Text(
                                    "I am writing to express my strong interest in the [Job Title] position at ${globalController.companyName.value}, as advertised on [where you found the job posting, e.g., LinkedIn or the company\'s website]. I am excited about the opportunity to contribute my skills and experience to your team.\n\nThroughout my career, I have honed my expertise in [mention your key skills and experience areas], and I am confident that my background makes me a perfect fit for this role. I am particularly drawn to [specific aspects of the company or the job posting that excite you], and I am eager to be part of your innovative and dynamic team.\n\n${globalController.letterBody}\n\n${globalController.callToAction}\n\n${globalController.availability}${globalController.confidentiality}\n\nI am highly motivated, detail-oriented, and thrive in fast-paced environments. I look forward to the opportunity to contribute to${globalController.companyName}\'s continued growth and success.\n\nThank you for considering my application. I am excited about the possibility of joining your team and would welcome the opportunity to discuss how my skills and experience align with your needs.",
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Text(
                                  'Best regards',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                               Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: Text(
                                  '${globalController.firstName} ${globalController.lastName}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
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
        ),
      ),
    );
  }
  Future<void> _showCustomDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: StadiumBorder(),
          content: CoverDialog(),
        );
      },
    );
  }
}
class CoverBodyScreen extends StatefulWidget {
  const CoverBodyScreen({super.key});

  @override
  State<CoverBodyScreen> createState() => _CoverBodyScreenState();
}

class _CoverBodyScreenState extends State<CoverBodyScreen> {
  CoverController globalController = Get.find();
  TextEditingController subjectController = TextEditingController();
  TextEditingController greetingController = TextEditingController();
  TextEditingController openingController = TextEditingController();
  TextEditingController callToActionController = TextEditingController();
  TextEditingController closingController = TextEditingController();
  TextEditingController signController = TextEditingController();
  TextEditingController letterBodyController = TextEditingController();
  TextEditingController availibialityController = TextEditingController();
  TextEditingController confidentialityController = TextEditingController();
  TextEditingController gapsController = TextEditingController();
  TextEditingController relocationController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial text for each TextField from the provided controllers
    subjectController.text = globalController.subject.value;
    greetingController.text = globalController.greeting.value;
    openingController.text = globalController.opening.value;
    callToActionController.text = globalController.callToAction.value;
    letterBodyController.text = globalController.letterBody.value;
    closingController.text = globalController.closing.value;
    signController.text = globalController.signature.value;
    availibialityController.text = globalController.availability.value;
    confidentialityController.text = globalController.confidentiality.value;
    gapsController.text = globalController.gaps.value;
    relocationController.text = globalController.relocation.value;
    salaryController.text = globalController.salaryRequirements.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32),
          child: Column(
            children: [
              SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Letter Body",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: greetingController,
                decoration: InputDecoration(
                  labelText: 'Greeting',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: openingController,
                decoration: InputDecoration(
                  labelText: 'Opening',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: letterBodyController,
                decoration: InputDecoration(
                  labelText: 'Letter Body',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: callToActionController,
                decoration: InputDecoration(
                  labelText: 'call To Action',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: closingController,
                decoration: InputDecoration(
                  labelText: 'Closing',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: signController,
                decoration: InputDecoration(
                  labelText: 'Signature',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: availibialityController,
                decoration: InputDecoration(
                  labelText: 'Availability',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: confidentialityController,
                decoration: InputDecoration(
                  labelText: 'Confidentiality',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: gapsController,
                decoration: InputDecoration(
                  labelText: 'gaps',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: relocationController,
                decoration: InputDecoration(
                  labelText: 'Relocation',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: salaryController,
                decoration: InputDecoration(
                  labelText: 'Salary Requirement',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close")),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: ElevatedButton(
                        onPressed: () {
                          globalController.subject.value = subjectController.text;
                          globalController.greeting.value =
                              greetingController.text;
                          globalController.opening.value = openingController.text;
                          globalController.callToAction.value =
                              callToActionController.text;
                          globalController.letterBody.value =
                              letterBodyController.text;
                          globalController.closing.value = closingController.text;
                          globalController.signature.value = signController.text;
                          globalController.availability.value =
                              availibialityController.text;
                          globalController.confidentiality.value =
                              confidentialityController.text;
                          globalController.gaps.value = gapsController.text;
                          globalController.relocation.value =
                              relocationController.text;
                          globalController.salaryRequirements.value =
                              salaryController.text;
                          Navigator.of(context).pop();
                        },
                        child: Text("Save")),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CoverDialog extends StatefulWidget {
  const CoverDialog({
    super.key,
  });

  @override
  State<CoverDialog> createState() => _CoverDialogState();
}

class _CoverDialogState extends State<CoverDialog> {
  bool isYear = false;
  @override
  Widget build(BuildContext context) {

    return
      Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Container(
                height: 450,
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("Letter Section", style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontFamily: "MontserratBold",
                        ),),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          _showCustomDialog(context, "Subject");
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Subject", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: const StadiumBorder(),
                                content: GreetingDialog(title: "Greetings"),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Greetings", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: const StadiumBorder(),
                                content: OpeningDialog(title: "Opening"),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Opening", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: const StadiumBorder(),
                                content: LetterBodyDialog(title: "Letter Body"),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Letter Body", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                shape: const StadiumBorder(),
                                content: CallToActionDialog(title: "Call to Action"),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Call to Action", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const StadiumBorder(),
                                  content: ClosingDialog(title: "Closing")
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Closing", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const StadiumBorder(),
                                  content: SignatureDialog(title: "Signature")
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Signature", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const StadiumBorder(),
                                  content: GapsDialog(title: "Gaps")
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Gaps", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const StadiumBorder(),
                                  content: RelocationDialog(title: "Relocation")
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Relocation", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const StadiumBorder(),
                                  content: AvalibilityDialog(title: "Availability")
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Availability", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const StadiumBorder(),
                                  content: AvalibilityDialog(title: "Confidentiality")
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Confidentiality", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  shape: const StadiumBorder(),
                                  content: AvalibilityDialog(title: "Salary")
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text("Salary", style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                              fontFamily: "MontserratRegular",
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
  Future<void> _showCustomDialog(BuildContext context, String title) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: const StadiumBorder(),
          content: SubjectDialog(title: title),
        );
      },
    );
  }
}


class SubjectDialog extends StatefulWidget {
  final String title;
  const SubjectDialog({super.key, required this.title});

  @override
  State<SubjectDialog> createState() => _SubjectDialogState();
}

class _SubjectDialogState extends State<SubjectDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.subject.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.subject.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class GreetingDialog extends StatefulWidget {
  final String title;
  const GreetingDialog({super.key, required this.title});

  @override
  State<GreetingDialog> createState() => _GreetingDialogState();
}

class _GreetingDialogState extends State<GreetingDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.greeting.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.greeting.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OpeningDialog extends StatefulWidget {
  final String title;
  const OpeningDialog({super.key, required this.title});

  @override
  State<OpeningDialog> createState() => _OpeningDialogState();
}

class _OpeningDialogState extends State<OpeningDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.opening.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.opening.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class LetterBodyDialog extends StatefulWidget {
  final String title;
  const LetterBodyDialog({super.key, required this.title});

  @override
  State<LetterBodyDialog> createState() => _LetterBodyDialogState();
}

class _LetterBodyDialogState extends State<LetterBodyDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.letterBody.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.letterBody.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CallToActionDialog extends StatefulWidget {
  final String title;
  const CallToActionDialog({super.key, required this.title});

  @override
  State<CallToActionDialog> createState() => _CallToActionDialogState();
}

class _CallToActionDialogState extends State<CallToActionDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.callToAction.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.callToAction.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ClosingDialog extends StatefulWidget {
  final String title;
  const ClosingDialog({super.key, required this.title});

  @override
  State<ClosingDialog> createState() => _ClosingDialogState();
}

class _ClosingDialogState extends State<ClosingDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.closing.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.closing.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SignatureDialog extends StatefulWidget {
  final String title;
  const SignatureDialog({super.key, required this.title});

  @override
  State<SignatureDialog> createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<SignatureDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.signature.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.signature.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class GapsDialog extends StatefulWidget {
  final String title;
  const GapsDialog({super.key, required this.title});

  @override
  State<GapsDialog> createState() => _GapsDialogState();
}

class _GapsDialogState extends State<GapsDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.gaps.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.gaps.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RelocationDialog extends StatefulWidget {
  final String title;
  const RelocationDialog({super.key, required this.title});

  @override
  State<RelocationDialog> createState() => _RelocationDialogState();
}

class _RelocationDialogState extends State<RelocationDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.relocation.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.relocation.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AvalibilityDialog extends StatefulWidget {
  final String title;
  const AvalibilityDialog({super.key, required this.title});

  @override
  State<AvalibilityDialog> createState() => _AvalibilityDialogState();
}

class _AvalibilityDialogState extends State<AvalibilityDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.availability.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.availability.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ConfedentialityDialog extends StatefulWidget {
  final String title;
  const ConfedentialityDialog({super.key, required this.title});

  @override
  State<ConfedentialityDialog> createState() => _ConfedentialityDialogState();
}

class _ConfedentialityDialogState extends State<ConfedentialityDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.confidentiality.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.confidentiality.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SalaryDialog extends StatefulWidget {
  final String title;
  const SalaryDialog({super.key, required this.title});

  @override
  State<SalaryDialog> createState() => _SalaryDialogState();
}

class _SalaryDialogState extends State<SalaryDialog> {
  CoverController globalController = Get.find();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = globalController.salaryRequirements.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: widget.title,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: () {
                                globalController.salaryRequirements.value = controller.text;
                                Navigator.pop(context);
                              },
                              child: Text("Save")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}