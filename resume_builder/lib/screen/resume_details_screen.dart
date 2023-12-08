import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resume_builder/models/ger_latest_resume.dart';
import 'package:resume_builder/resume%20template/firstResumeTemplate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../controller/global_controller.dart';
import '../resume template/SixthResumeTemplate.dart';
import '../resume template/TwentyFiveResumeTemplate.dart';
import '../resume template/TwentyThreeResumeTemplate.dart';
import '../resume template/eightResumeTemplate.dart';
import '../resume template/eighteenResumeTemplate.dart';
import '../resume template/eleventhResumeTemplate.dart';
import '../resume template/fifteenResumeTemplate.dart';
import '../resume template/fifthResumeResumeTemplate.dart';
import '../resume template/forteenResumeTemplate.dart';
import '../resume template/fourthResumeTemplate.dart';
import '../resume template/ninteenResumeTemplate.dart';
import '../resume template/ninthResumeTemplate.dart';
import '../resume template/secondResumeTemplate.dart';
import '../resume template/seventeenResumeTemplate.dart';
import '../resume template/seventhResumeTemplate.dart';
import '../resume template/sixteenResumeTemplate.dart';
import '../resume template/tenthResume.dart';
import '../resume template/thirdResumeTemplate.dart';
import '../resume template/thirteenResume.dart';
import '../resume template/twelthResumeTemplate.dart';
import '../resume template/twentyFourResumeTemplate.dart';
import '../resume template/twentyResumeTemplate.dart';
import '../resume template/twentySevenResumeTemplate.dart';
import '../resume template/twentySixResumeTemplate.dart';
import '../resume template/twentyTwoResumeTemplate.dart';
import '../resume template/twentyoneResumeTemplate.dart';

class ResumeDetailsScreen extends StatefulWidget {
  final  String resumeId, code;

  const ResumeDetailsScreen({super.key, required this.resumeId, required this.code});

  @override
  State<ResumeDetailsScreen> createState() => _ResumeDetailsScreenState();
}

class _ResumeDetailsScreenState extends State<ResumeDetailsScreen> {
  List<GetLatestResumeModel> resumeDetails = [];
  GetLatestResumeModel? globalResumeModel;
  GlobalController globalController = Get.find();
  bool _isLoading = false;
  String tempId = '';

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Future<Map<String, dynamic>> fetchData() async {

    setState(() {
      _isLoading = true;
    });

    final String? authToken = await loadToken();

    final headers = <String, String>{};
    if (authToken != null) {
      headers['x-auth-token'] =
          '$authToken';
    }

    if (authToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No token"),
        ),
      );
    }

    final response = await http.get(
      Uri.parse(
          'https://lizmyresume.onrender.com/user/resume/getParticularResume/${widget.resumeId}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${json.decode(response.body).toString()}"),
        ),
      );
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.code == "allResume"){
      fetchData().then((data) {

        setState(() {
          tempId = data['data']['tempId'];
          globalController.name.value = data['data']['name'] ?? 'no name';
          globalController.interestedIn.value = data['data']['interestedIn'] ?? 'no name';

          globalController.email.value = data['data']['contact']['email'] ?? 'no email';
          globalController.phone.value = data['data']['contact']['phone'] ?? 'no email';

          globalController.phone.value = data['data']['socialLinks']['linkedin'] ?? 'no email';
          globalController.phone.value = data['data']['socialLinks']['github'] ?? 'no email';
          globalController.phone.value = data['data']['socialLinks']['portfolio'] ?? 'no email';

          globalController.address.value = data['data']['address']['address'] ?? 'no email';
          globalController.city.value = data['data']['address']['city'] ?? 'no email';
          globalController.postalCode.value = data['data']['address']['postalCode'] ?? 'no email';
          globalController.state.value = data['data']['address']['state'] ?? 'no email';
          globalController.country.value = data['data']['address']['country'] ?? 'no email';

          globalController.jobTitle.value = data['data']['jobTitle'] ?? 'no jobTitle';
          globalController.bio.value = data['data']['summary'] ?? 'no summary';
          globalController.dob.value = data['data']['dob'] ?? 'no dob';
          globalController.gender.value = data['data']['gender'] ?? 'no gender';
          globalController.tempId.value = data['data']['tempId'] ?? 'no gender';
          // Repeat this for other fields
        });

      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to fetch data from API"),
          ),
        );
      });
    }else {

    }

    super.initState();
  }
  Widget getTemplateByTempId(String tempId) {
    switch (tempId) {
      case 'template0':
        return FirstResumeTemplate();
      case 'template1':
        return SecondResumeTemplate();
      case 'template2':
        return ThirdResumeTemplate();
      case 'template3':
        return FourthResumeTemplate();
      case 'template4':
        return FifthResumeTemplate();
      case 'template5':
        return SixthResumeTemplate();
      case 'template6':
        return SeventhResumeTemplate();
      case 'template7':
        return EighthResumeTemplate();
      case 'template8':
        return NinthResumeTemplate();
      case 'template9':
        return TenthResumeTemplate();
      case 'template10':
        return ElevethResumeTemplate();
      case 'template11':
        return TwelthResumeTemplate();
      case 'template12':
        return ThirteenResumeTemplate();
      case 'template13':
        return ForteenResumeTemplate();
      case 'template14':
        return FifteenREsumeTemplate();
      case 'template15':
        return SixteenResumeTemplate();
      case 'template16':
        return SeventeenthResumeTemplate();
      case 'template17':
        return EighteenResumeTemplate();
      case 'template18':
        return NineTeenResumeTemplate();
      case 'template19':
        return TwentyResumeTemplate();
      case 'template20':
        return TwentyOneResumeTemplate();
      case 'template21':
        return TwentyTwoResumeTemplate();
      case 'template22':
        return TwentyThreeResumeTemplate();
      case 'template23':
        return TwentyFourResumeTemplate();
      case 'template24':
        return TwentythFiveResumeTemplate();
      case 'template25':
        return TwentySixResumeTemplate();
      case 'template26':
        return TwentySevenResumeTemplateWidget();
      case 'template27':
        return SizedBox();
      case 'template28':
        return SizedBox();
      case 'template29':
        return SizedBox();
      default:
        return FirstResumeTemplate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading? Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,))):
    getTemplateByTempId(tempId);
  }
}

