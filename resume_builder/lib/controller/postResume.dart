// import 'package:dio/dio.dart' as Dio;
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:resume_builder/controller/global_controller.dart';
// import 'package:resume_builder/services/global.dart';
// import 'package:resume_builder/utils/constants.dart';

// class PostResume extends GetxController {
//   //User Personal INfo
//   TextEditingController bioController = TextEditingController();

//   TextEditingController jobTitleController = TextEditingController();

//   // TextEditingController firstNameController = TextEditingController();

//   // TextEditingController lastNameController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();

//   TextEditingController cityController = TextEditingController();

//   TextEditingController stateController = TextEditingController();

//   TextEditingController countryController = TextEditingController();

//   TextEditingController postcodeController = TextEditingController();

//   TextEditingController addressController = TextEditingController();

//   TextEditingController phoneController = TextEditingController();

//   TextEditingController dateOfBirthController = TextEditingController();
//   TextEditingController genderController = TextEditingController();

//   //User Education
//   TextEditingController degreeController = TextEditingController();

//   TextEditingController collegeNameController = TextEditingController();

//   TextEditingController streamController = TextEditingController();

//   TextEditingController startYearController = TextEditingController();
//   TextEditingController endYearController = TextEditingController();

//   //UserWork
//   TextEditingController workTitileController = TextEditingController();

//   TextEditingController workCompanyController = TextEditingController();

//   TextEditingController workStartDateController = TextEditingController();

//   TextEditingController workEndDateController = TextEditingController();
//   TextEditingController workLocationController = TextEditingController();
//   TextEditingController workDescriptionController = TextEditingController();

//   //UserSkills
//   TextEditingController skillsController = TextEditingController();
//   TextEditingController levelController = TextEditingController();

//   //UserInternship
//   TextEditingController internshipTitileController = TextEditingController();

//   TextEditingController internshipCompanyController = TextEditingController();

//   TextEditingController internshipStartDateController = TextEditingController();

//   TextEditingController internshipEndDateController = TextEditingController();
//   TextEditingController internshipLocationController = TextEditingController();
//   TextEditingController internshipDescriptionController =
//       TextEditingController();

//   //UserProject
//   TextEditingController projectTitileController = TextEditingController();

//   TextEditingController projectDescriptionController = TextEditingController();

//   TextEditingController projectYearController = TextEditingController();

//   TextEditingController projectLinkController = TextEditingController();

//   //userSocialinks
//   TextEditingController linkedinController = TextEditingController();

//   TextEditingController githubController = TextEditingController();

//   TextEditingController portfolioController = TextEditingController();

//   //userknowlanguage
//   TextEditingController languageController = TextEditingController();

//   //userCertifications
//   TextEditingController certificateTitileController = TextEditingController();

//   TextEditingController certificateIssuingOrganizationController =
//       TextEditingController();

//   TextEditingController certificateDateController = TextEditingController();

// //UserAwards
//   TextEditingController awardsTitileController = TextEditingController();

//   TextEditingController awardsIssuingOrganizationController =
//       TextEditingController();

//   TextEditingController awardsDateController = TextEditingController();

//   //userVolunteerExperience
//   TextEditingController volunteerTitileController = TextEditingController();

//   TextEditingController volunteerCompanyController = TextEditingController();

//   TextEditingController volunteerStartDateController = TextEditingController();

//   TextEditingController volunteerEndDateController = TextEditingController();
//   TextEditingController volunteerLocationController = TextEditingController();
//   TextEditingController volunteerDescriptionController =
//       TextEditingController();

//   //userAreaofinterest
//   TextEditingController areaOfInterestController = TextEditingController();

//   //userreferences
//   TextEditingController referencesNameController = TextEditingController();

//   TextEditingController referencesCompanyController = TextEditingController();

//   TextEditingController referencesPositionController = TextEditingController();

//   TextEditingController referencesEmailController = TextEditingController();
//   TextEditingController referencesPhoneController = TextEditingController();

//   //userinterested
//   TextEditingController userInterestedController = TextEditingController();
// // Lists for various sections
//   List<Map<String, dynamic>> educationList = [];
//   List<Map<String, dynamic>> workList = [];
//   List<Map<String, dynamic>> skillsList = [];
//   List<Map<String, dynamic>> internshipsList = [];
//   List<Map<String, dynamic>> projectsList = [];
//   List<Map<String, dynamic>> knownLanguagesList = [];
//   List<Map<String, dynamic>> certificationsList = [];
//   List<Map<String, dynamic>> awardsList = [];
//   List<Map<String, dynamic>> volunteerExperienceList = [];
//   List<Map<String, dynamic>> areaOfInterestList = [];
//   List<Map<String, dynamic>> referencesList = [];

//   createResume() async {
//     Map<String, dynamic> body = {
//       "name": nameController.text,
//       "summary": bioController.text,
//       "jobTitle": jobTitleController.text,
//       "contact": {"email": emailController.text, "phone": phoneController.text},
//       "dob": dateOfBirthController.text,
//       "gender": genderController.text,
//       "address": {
//         "address": addressController.text,
//         "city": cityController.text,
//         "state": stateController.text,
//         "postalCode": postcodeController.text,
//         "country": countryController.text,
//       },
//       "education": educationList,
//       "work": workList,
//       "profilePicture": '',
//       "skillsAndLevel": skillsList,
//       "internShips": internshipsList,
//       "projects": projectsList,
//       "socialLinks": {
//         "linkedin": linkedinController.text,
//         "github": githubController.text,
//         "portfolio": portfolioController.text
//       },
//       "knownLanguages": knownLanguagesList,
//       "certifications": certificationsList,
//       "awards": awardsList,
//       "volunteerExperience": volunteerExperienceList,
//       "areaOfInterest": areaOfInterestList,
//       "references": referencesList,
//       "interestedIn": userInterestedController.text,
//     };
//     Dio.Response response =
//         await Global.apiClient.postData(Constants.createResume, body, null);
//     if (response.statusCode == 201) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void receiveGlobalData(GlobalController globalController) {
//     nameController.text = globalController.name.value;
//     bioController.text = globalController.bio.value;
//     emailController.text = globalController.email.value;
//     phoneController.text = globalController.phone.value;
//     cityController.text = globalController.city.value;
//     stateController.text = globalController.state.value;
//     postcodeController.text = globalController.postalCode.value;
//     countryController.text = globalController.country.value;
//     jobTitleController.text = globalController.jobTitle.value;
//     addressController.text = globalController.address.value;
//     dateOfBirthController.text = globalController.dob.value;
//     genderController.text = globalController.gender.value;

//     // Set the lists by converting them to JSON strings
//     educationList = globalController.educationDataList
//         .map((data) => data.toJson())
//         .toList();
//     workList = globalController.workExperienceDataList
//         .map((data) => data.toJson())
//         .toList();
//     skillsList =
//         globalController.skillDataList.map((data) => data.toJson()).toList();
//     internshipsList = globalController.userInternshipDataList
//         .map((data) => data.toJson())
//         .toList();
//     projectsList =
//         globalController.projectDataList.map((data) => data.toJson()).toList();
//     knownLanguagesList = globalController.knowLanguageDataList
//         .map((data) => data.toJson())
//         .toList();

//     certificationsList = globalController.certificationDataList
//         .map((data) => data.toJson())
//         .toList();
//     awardsList =
//         globalController.awardDataList.map((data) => data.toJson()).toList();
//     volunteerExperienceList = globalController.volunteerExperienceDataList
//         .map((data) => data.toJson())
//         .toList();

//     areaOfInterestList = globalController.areaOfInterestDataList
//         .map((data) => data.toJson())
//         .toList();
//     referencesList = globalController.referenceDataList
//         .map((data) => data.toJson())
//         .toList();
//     linkedinController.text = globalController.linkedin.value;
//     githubController.text = globalController.github.value;
//     portfolioController.text = globalController.portfolio.value;
//     userInterestedController.text = globalController.interestedIn.value;
//   }

// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:resume_builder/controller/global_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pdf_viewer_screen.dart';
import 'cover_controller.dart';

class Address {
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }
}

class Contact {
  final String email;
  final String phone;

  Contact({
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
    };
  }
}

class SocialLinks {
  final String linkedin;
  final String github;
  final String portfolio;

  SocialLinks({
    required this.linkedin,
    required this.github,
    required this.portfolio,
  });

  Map<String, dynamic> toJson() {
    return {
      'linkedin': linkedin,
      'github': github,
      'portfolio': portfolio,
    };
  }
}

class PostResume {
  // Future<String> sendPostRequest(String url, dynamic requestBody) async {
  //   Future<String> loadToken() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String savedToken = prefs.getString('token') ?? "";
  //     return savedToken;
  //   }
  //
  //   try {
  //
  //     final String? authToken = await loadToken();
  //
  //     final String requestBodyJson = jsonEncode(requestBody);
  //
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         "x-auth-token": "$authToken"
  //       },
  //       body: requestBodyJson,
  //     );
  //
  //     if (response.statusCode == 201) {
  //       // Request was successful, and you can handle the response here.
  //       print("Response: ${response.body}");
  //       return "${response.statusCode}\n${response.body}";
  //     } else {
  //       // Request failed, handle the error here.
  //       print("Request failed with status: ${response.statusCode}");
  //       return "${response.statusCode}\n${response.body}";
  //     }
  //   } catch (e) {
  //     // Handle exceptions that may occur during the request.
  //     print("Error: $e");
  //     return "$e";
  //   }
  // }

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  

  Future<String> makePostRequest(File imageFile) async {
    GlobalController globalController = Get.find();
    try {
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();

      String? authToken = await loadToken();

      var uri = Uri.parse('https://lizmyresume.onrender.com/user/resume/createResume');
      var request = new http.MultipartRequest('POST', uri);

      request.headers['x-auth-token'] = '$authToken';
      request.headers['Content-Type'] = 'application/json';

      // Add text fields to the request
      request.fields['name'] = globalController.name.value;
      request.fields['interestedIn'] = globalController.interestedIn.value;
      request.fields['tempId'] = globalController.tempId.value;
      request.fields['gender'] = globalController.gender.value;
      request.fields['bio'] = globalController.bio.value;
      request.fields['summary'] = globalController.bio.value;
      request.fields['dob'] = globalController.dob.value;
      request.fields['jobTitle'] = globalController.jobTitle.value;
      //
      // // Upload lists of data
      request.fields['education'] = json.encode(globalController
          .educationDataList
          .map((education) => education.toJson())
          .toList());
      request.fields['work'] = json.encode(globalController
          .workExperienceDataList
          .map((work) => work.toJson())
          .toList());
      request.fields['skillsAndLevel'] = json.encode(globalController
          .skillDataList
          .map((skills) => skills.toJson())
          .toList());
      request.fields['internShips'] = json.encode(globalController
          .userInternshipDataList
          .map((internship) => internship.toJson())
          .toList());
      request.fields['projects'] = json.encode(globalController.projectDataList
          .map((project) => project.toJson())
          .toList());
      request.fields['knownLanguages'] = json.encode(globalController
          .knowLanguageDataList
          .map((language) => language.toJson())
          .toList());
      request.fields['certifications'] = json.encode(globalController
          .certificationDataList
          .map((certification) => certification.toJson())
          .toList());
      request.fields['awards'] = json.encode(globalController.awardDataList
          .map((award) => award.toJson())
          .toList());
      request.fields['volunteerExperience'] = json.encode(globalController
          .volunteerExperienceDataList
          .map((volunteer) => volunteer.toJson())
          .toList());
      request.fields['areaOfInterest'] = json.encode(globalController
          .areaOfInterestDataList
          .map((interest) => interest.toJson())
          .toList());
      request.fields['references'] = json.encode(globalController
          .referenceDataList
          .map((reference) => reference.toJson())
          .toList());

      Address addressData = Address(
        address: globalController.address.value,
        city: globalController.city.value,
        state: globalController.state.value,
        postalCode: globalController.postalCode.value,
        country: globalController.country.value,
      );
      String addressJson = json.encode(addressData.toJson());
      request.fields['address'] = addressJson;

      Contact contactData = Contact(
        email: globalController.email.value,
        phone: globalController.phone.value,
      );
      String contactJson = json.encode(contactData.toJson());
      request.fields['contact'] = contactJson;

      SocialLinks socialLinksData = SocialLinks(
        linkedin: globalController.linkedin.value,
        github: globalController.github.value,
        portfolio: globalController.portfolio.value,
      );
      String socialLinksJson = json.encode(socialLinksData.toJson());
      request.fields['socialLinks'] = socialLinksJson;

      var multiport = new http.MultipartFile('profilePicture', stream, length);
      request.files.add(multiport);

      var reponse = await request.send();
      if (reponse.statusCode == 201) {
        return "Resume Created";
      } else {
        return "${reponse.statusCode}Failed";
      }
    } catch (error) {
      // Handle the error here
      return "An error occurred: $error";
    }
  }

  Future<String> createResume(GlobalController globalController) async {
    try {
      String? authToken = await loadToken();
      final apiUrl = Uri.parse('https://lizmyresume.onrender.com/user/resume/createResume');

      final headers = {
        'Content-Type': 'application/json',
        'x-auth-token': '$authToken',
      };

      final userData = {
          'name': globalController.name.value,
          'summary': globalController.bio.value,
          'dob': globalController.dob.value,
          'gender': globalController.gender.value,
          // Add other fields from your globalController as needed
          'address': {
            'address': globalController.address.value,
            'city': globalController.city.value,
            'state': globalController.state.value,
            'postalCode': globalController.postalCode.value,
            'country': globalController.country.value,
          },
          'contact': {
            'email': globalController.email.value,
            'phone': globalController.phone.value,
          },
          'socialLinks': {
            'linkedin': globalController.linkedin.value,
            'github': globalController.github.value,
            'portfolio': globalController.portfolio.value,
          },
          // 'profilePicture': "https://images.unsplash.com/photo-1697574316241-bb05ae18a0ef?auto=format&fit=crop&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=1887",
          'education': globalController.educationDataList.map((education) => education.toJson()).toList(),
          'work': globalController.workExperienceDataList.map((work) => work.toJson()).toList(),
          'skillsAndLevel': globalController.skillDataList.map((skills) => skills.toJson()).toList(),
          'internShips': globalController.userInternshipDataList.map((internship) => internship.toJson()).toList(),
          'projects': globalController.projectDataList.map((project) => project.toJson()).toList(),
          'knownLanguages': globalController.knowLanguageDataList.map((project) => project.toJson()).toList(),
          'certifications': globalController.certificationDataList.map((project) => project.toJson()).toList(),
          'awards': globalController.awardDataList.map((project) => project.toJson()).toList(),
          'volunteerExperience': globalController.volunteerExperienceDataList.map((project) => project.toJson()).toList(),
          'areaOfInterest': globalController.areaOfInterestDataList.map((project) => project.toJson()).toList(),
          'references': globalController.referenceDataList.map((project) => project.toJson()).toList(),
          'interestedIn': globalController.interestedIn.value,
          'jobTitle': globalController.jobTitle.value,
          'tempId': globalController.tempId.value,
          // Add other data lists as needed (e.g., knownLanguages, certifications, etc.)
      };
      final response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return "Data Posted"; // Data posted successfully
      } else {
        print('HTTP Error: ${response.statusCode}');
        return "${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }




  Future<String> createCover(CoverController coverController) async {
    try {
      final apiUrl = Uri.parse('https://lizmyresume.onrender.com/user/coverLetter/createCoverLetter');
      String? authToken = await loadToken();
      final headers = {
        'Content-Type': 'application/json',
        'x-auth-token': '$authToken',
      };

      final userData = {
          'nameAndContact': {
            'firstName': coverController.firstName.value,
            'lastName': coverController.lastName.value,
            'profession': coverController.profession.value,
            'city': coverController.city.value,
            'state': coverController.state.value,
            'zip': coverController.zip.value,
            'phoneNumber': coverController.phoneNumber.value,
            'email': coverController.email.value,
          },
          'date': coverController.date.value,
          'recipient': {
            'firstName': coverController.rFirstName.value,
            'lastName': coverController.rLastName.value,
            'companyName': coverController.companyName.value,
            'city': coverController.rCity.value,
            'state': coverController.rState.value,
            'zip': coverController.rZip.value,
            'phoneNumber': coverController.rPhoneNumber.value,
            'email': coverController.rEmail.value,
          },
        'socialLinks': {
          'linkedin': coverController.linkedin.value,
          'github': coverController.github.value,
          'portfolio': coverController.portfolio.value,
        },
          'subject': coverController.subject.value,
          'greeting': coverController.greeting.value,
          'opening': coverController.opening.value,
          'letterBody': coverController.letterBody.value,
          'callToAction': coverController.callToAction.value,
          'closing': coverController.closing.value,
          'signature': coverController.signature.value,
          'availability': coverController.availability.value,
          'confidentiality': coverController.confidentiality.value,
          'gaps': coverController.gaps.value,
          'relocation': coverController.relocation.value,
          'salaryRequirements': coverController.salaryRequirements.value,
          'tempID': coverController.tempID.value,
      };


      final response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return "created"; // Data posted successfully
      } else {
        print('HTTP Error: ${response.statusCode}');
        return "${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }

  Future<String> updateCover(CoverController coverController, String? coverId) async {
    try {
      final apiUrl = Uri.parse('https://lizmyresume.onrender.com/user/coverLetter/updateCoverLetter/$coverId');
      String? authToken = await loadToken();
      final headers = {
        'Content-Type': 'application/json',
        'x-auth-token': '$authToken',
      };

      final userData = {
        'nameAndContact': {
          'firstName': coverController.firstName.value,
          'lastName': coverController.lastName.value,
          'profession': coverController.profession.value,
          'city': coverController.city.value,
          'state': coverController.state.value,
          'zip': coverController.zip.value,
          'phoneNumber': coverController.phoneNumber.value,
          'email': coverController.email.value,
        },
        'date': coverController.date.value,
        'recipient': {
          'firstName': coverController.rFirstName.value,
          'lastName': coverController.rLastName.value,
          'companyName': coverController.companyName.value,
          'city': coverController.rCity.value,
          'state': coverController.rState.value,
          'zip': coverController.rZip.value,
          'phoneNumber': coverController.rPhoneNumber.value,
          'email': coverController.rEmail.value,
        },
        'socialLinks': {
          'linkedin': coverController.linkedin.value,
          'github': coverController.github.value,
          'portfolio': coverController.portfolio.value,
        },
        'subject': coverController.subject.value,
        'greeting': coverController.greeting.value,
        'opening': coverController.opening.value,
        'letterBody': coverController.letterBody.value,
        'callToAction': coverController.callToAction.value,
        'closing': coverController.closing.value,
        'signature': coverController.signature.value,
        'availability': coverController.availability.value,
        'confidentiality': coverController.confidentiality.value,
        'gaps': coverController.gaps.value,
        'relocation': coverController.relocation.value,
        'salaryRequirements': coverController.salaryRequirements.value,
        'tempID': coverController.tempID.value,
      };


      final response = await http.put(
        apiUrl,
        headers: headers,
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return "${response.statusCode}"; // Data posted successfully
      } else {
        print('HTTP Error: ${response.statusCode}');
        return "${response.statusCode}"; // Data posting failed
      }
    } catch (error) {
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }

  Future<void> clearControllerValue() async {
    GlobalController globalController = Get.find();
    globalController.educationDataList.clear();
    globalController.workExperienceDataList.clear();
    globalController.skillDataList.clear();
    globalController.userInternshipDataList.clear();
    globalController.projectDataList.clear();
    globalController.knowLanguageDataList.clear();
    globalController.certificationDataList.clear();
    globalController.awardDataList.clear();
    globalController.volunteerExperienceDataList.clear();
    globalController.areaOfInterestDataList.clear();
    globalController.referenceDataList.clear();
    globalController.tempId.value = "";
  }


  Future<String> generatePdf(String content) async {
    print("Working");
    try {
      final apiUrl = Uri.parse('https://whihtmltopdf.onrender.com/convertToPdf');
      final headers = {
        'Content-Type': 'application/json',
      };

      final userData = {
        "htmlContent": content
      };



      final response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return "${response.statusCode}, ${response.body}"; // Data posted successfully
      } else {
        return "HTTP error: ${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }


  Future<void> saveAndOpenPdf(String pdfBytes, BuildContext context) async {
    print("working");
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
          File file = File('$tempPath/$timestamp.pdf');
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
}
