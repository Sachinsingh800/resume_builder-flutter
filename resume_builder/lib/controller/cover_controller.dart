import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resume_builder/controller/postResume.dart';
import 'package:resume_builder/screen/UserInformation/UserAreaofInterest.dart';
import 'package:resume_builder/screen/UserInformation/UserAwards.dart';
import 'package:resume_builder/screen/UserInformation/UserEducation.dart';
import 'package:resume_builder/screen/UserInformation/UserInternship.dart';
import 'package:resume_builder/screen/UserInformation/UserKnowLanguages.dart';
import 'package:resume_builder/screen/UserInformation/UserReferences.dart';
import 'package:resume_builder/screen/UserInformation/UserSkills.dart';
import 'package:resume_builder/screen/UserInformation/UserWorkExperience.dart';
import 'package:resume_builder/screen/UserInformation/UservolunteerExperience.dart';
import 'package:resume_builder/screen/UserInformation/userCertifications.dart';

import '../screen/UserInformation/UserProject.dart';

class CoverController extends GetxController {
  //UserPersonalInfo
  RxString profession = ''.obs;
  RxString firstName = ''.obs;
  RxString rFirstName = ''.obs;
  RxString rLastName = ''.obs;
  RxString lastName = ''.obs;
  RxString date = ''.obs;
  RxString city = ''.obs;
  RxString rCity = ''.obs;
  RxString state = ''.obs;
  RxString rState = ''.obs;
  RxString zip = ''.obs;
  RxString rZip = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString rPhoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString rEmail = ''.obs;
  RxString rName = ''.obs;
  RxString companyName = ''.obs;
  RxString subject = ''.obs;
  RxString greeting = ''.obs;
  RxString opening = ''.obs;
  RxString letterBody = ''.obs;
  RxString callToAction = ''.obs;
  RxString closing = ''.obs;
  RxString signature = ''.obs;
  RxString availability = ''.obs;
  RxString confidentiality = ''.obs;
  RxString gaps = ''.obs;
  RxString relocation = ''.obs;
  RxString salaryRequirements = ''.obs;
  RxString linkedin = ''.obs;
  RxString github = ''.obs;
  RxString portfolio = ''.obs;
  RxString tempID = ''.obs;
  RxInt color = 0xFF003D74.obs;
  Rx<FontWeight> fontWeight = FontWeight.w600.obs;

  void updateFontWeight(FontWeight newFontWeight) {
    fontWeight.value = newFontWeight;
  }

  void userPersonalInfo({
    required String profession,
    required String date,
    required String firstName,
    required String lastName,
    required String rLastName,
    required String rFirstName,
    required String city,
    required String rCity,
    required String state,
    required String rState,
    required String zip,
    required String rZip,
    required String phoneNumber,
    required String rPhoneNumber,
    required String email,
    required String rEmail,
    required String rName,
    required String companyName,
    required String subject,
    required String greeting,
    required String opening,
    required String letterBody,
    required String callToAction,
    required String closing,
    required String signature,
    required String availability,
    required String confidentiality,
    required String gaps,
    required String relocation,
    required String salaryRequirements,
  }) {
    this.profession.value = profession;
    this.date.value = date;
    this.firstName.value = firstName;
    this.rFirstName.value = rFirstName;
    this.rLastName.value = rLastName;
    this.lastName.value = lastName;
    this.city.value = city;
    this.rCity.value = rCity;
    this.state.value = state;
    this.rState.value = rState;
    this.zip.value = zip;
    this.rZip.value = rZip;
    this.phoneNumber.value = phoneNumber;
    this.rPhoneNumber.value = rPhoneNumber;
    this.email.value = email;
    this.rEmail.value = rEmail;
    this.rName.value = rName;
    this.companyName.value = companyName;
    this.subject.value = subject;
    this.greeting.value = greeting;
    this.opening.value = opening;
    this.letterBody.value = letterBody;
    this.callToAction.value = callToAction;
    this.closing.value = closing;
    this.signature.value = signature;
    this.availability.value = availability;
    this.confidentiality.value = confidentiality;
    this.gaps.value = gaps;
    this.relocation.value = relocation;
    this.salaryRequirements.value = salaryRequirements;
  }

}
