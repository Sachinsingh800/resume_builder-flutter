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

class GlobalController extends GetxController {
  //UserPersonalInfo
  RxString bio = ''.obs;
  RxString jobTitle = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString dob = ''.obs;
  RxString gender = ''.obs;
  RxString address = ''.obs;
  RxString city = ''.obs;
  RxString state = ''.obs;
  RxString postalCode = ''.obs;
  RxString country = ''.obs;
  RxInt color = 0xFFE5E5E5.obs;
  Rx<FontWeight> fontWeight = FontWeight.w600.obs;

  // Function to update font weight
  void updateFontWeight(FontWeight newFontWeight) {
    fontWeight.value = newFontWeight;
  }

//UserExperience
  RxList<EducationData> educationDataList = <EducationData>[].obs;
  //User Work
  RxList<WorkExperienceData> workExperienceDataList =
      <WorkExperienceData>[].obs;
  //user skills
  RxList<SkillData> skillDataList = <SkillData>[].obs;

//User internship
  RxList<UserInternshipData> userInternshipDataList =
      <UserInternshipData>[].obs;

//user project
  RxList<ProjectData> projectDataList = <ProjectData>[].obs;

//user social link
  RxString linkedin = ''.obs;
  RxString github = ''.obs;
  RxString portfolio = ''.obs;

//User know language
  RxList<KnowLanguageData> knowLanguageDataList = <KnowLanguageData>[].obs;

// user certification
  RxList<CertificationData> certificationDataList = <CertificationData>[].obs;

//user awards
  RxList<AwardData> awardDataList = <AwardData>[].obs;

//user volunteer experience
  RxList<VolunteerExperienceData> volunteerExperienceDataList =
      <VolunteerExperienceData>[].obs;

//user area of interest
  RxList<AreaOfInterestData> areaOfInterestDataList =
      <AreaOfInterestData>[].obs;

//user references
  RxList<ReferenceData> referenceDataList = <ReferenceData>[].obs;

  //user interested
  RxString interestedIn = ''.obs;
  RxString tempId = ''.obs;
//userPersonalInfo
  void userPersonalInfo({
    required String bio,
    required String jobTitle,
    required String name,
    required String email,
    required String phone,
    required String dob,
    required String gender,
    required String address,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    required int color,
  }) {
    this.bio.value = bio;
    this.jobTitle.value = jobTitle;
    this.name.value = name;
    this.email.value = email;
    this.phone.value = phone;
    this.dob.value = dob;
    this.gender.value = gender;
    this.address.value = address;
    this.city.value = city;
    this.state.value = state;
    this.postalCode.value = postalCode;
    this.country.value = country;
    this.color.value = color;

    print(bio);
    print(jobTitle);
    print(email);
    print(name);
    print(address);
    print(postalCode);
    print(state);
    print(country);
    print(city);
    print(dob);
    print(gender);
    print(phone);
  }

  // Method to add education data
  void addEducationData(EducationData data) {
    educationDataList.add(data);
  }

  // Method to remove education data
  void removeEducationData(EducationData data) {
    educationDataList.remove(data);
  }

  void addWorkExperienceData(WorkExperienceData data) {
    workExperienceDataList.add(data);
  }

  void removeWorkExperienceData(WorkExperienceData data) {
    workExperienceDataList.remove(data);
  }

  void addSkillseData(SkillData data) {
    skillDataList.add(data);
  }

  void removeSkillsData(SkillData data) {
    skillDataList.remove(data);
  }

  void addUserInternshipData(UserInternshipData data) {
    userInternshipDataList.add(data);
  }

  void removeUserInternshipData(UserInternshipData data) {
    userInternshipDataList.remove(data);
  }

  void addUserProjectData(ProjectData data) {
    projectDataList.add(data);
  }

  void removeUserProjectData(ProjectData data) {
    projectDataList.remove(data);
  }

//user social links
  void usersociallinks({
    required String linkedin,
    required String github,
    required String portfolio,
  }) {
    this.linkedin.value = linkedin;
    this.github.value = github;
    this.portfolio.value = portfolio;
    print(linkedin);
    print(github);
    print(portfolio);
  }

  void addUserKnowLanguageData(KnowLanguageData data) {
    knowLanguageDataList.add(data);
  }

  void removeUserKnowLanguageData(KnowLanguageData data) {
    knowLanguageDataList.remove(data);
  }

  void addUserCertificationData(CertificationData data) {
    certificationDataList.add(data);
  }

  void removeUserCertificationData(CertificationData data) {
    certificationDataList.remove(data);
  }

  void addUserAwardsData(AwardData data) {
    awardDataList.add(data);
  }

  void removeUserAwardsData(AwardData data) {
    awardDataList.remove(data);
  }

  void addUserVolunteerExperienceData(VolunteerExperienceData data) {
    volunteerExperienceDataList.add(data);
  }

  void removeUserVolunteerExperienceData(VolunteerExperienceData data) {
    volunteerExperienceDataList.remove(data);
  }

  void addUserAreofInterestData(AreaOfInterestData data) {
    areaOfInterestDataList.add(data);
  }

  void removeUserAreofInterestData(AreaOfInterestData data) {
    areaOfInterestDataList.remove(data);
  }

  void addUserReferencesData(ReferenceData data) {
    referenceDataList.add(data);
  }

  void removeUserReferencesData(ReferenceData data) {
    referenceDataList.remove(data);
  }

  void userInterested({
    required String interestedIN,
  }) {
    this.interestedIn.value = interestedIN;
    print(interestedIN);
  }

  Future<bool> sendUserDataToAPI() async {
    final apiUrl = 'https://lizmyresume.onrender.com/user/createResume';

    final userData = {
      "bio": bio.value,
      "jobTitle": jobTitle.value,
      "name": name.value,
      "email": email.value,
      "phone": phone.value,
      "dob": dob.value,
      "gender": gender.value,
      "address": address.value,
      "city": city.value,
      "state": state.value,
      "postalCode": postalCode.value,
      "country": country.value,
      // Add more data fields as needed
    };

    try {
      final response =
          await http.post(Uri.parse(apiUrl), body: jsonEncode(userData));

      if (response.statusCode == 201) {
        // Data posted successfully
        return true;
      } else {
        // Data posting failed
        print('Data posting failed. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle any network or other errors
      print('Error sending data: $error');
      return false;
    }
  }


}

class UserProfileScreen extends StatelessWidget {
  GlobalController globalController = Get.find();
  PostResume postResume = Get.put(PostResume());

  @override
  Widget build(BuildContext context) {
    // postResume.receiveGlobalData(globalController);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Personal Info:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Name: ${globalController.name.value}'),
              Text('Bio: ${globalController.bio.value}'),
              Text('Email: ${globalController.email.value}'),
              Text('Phone: ${globalController.phone.value}'),
              Text('Date of Birth: ${globalController.dob.value}'),
              Text('Gender: ${globalController.gender.value}'),
              Text('Address: ${globalController.address.value}'),
              Text('City: ${globalController.city.value}'),
              Text('State: ${globalController.state.value}'),
              Text('Postal Code: ${globalController.postalCode.value}'),
              Text('Country: ${globalController.country.value}'),
              Text(
                'User Education:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Education Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (EducationData education
                  in globalController.educationDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Institution: ${education.schoolName}'),
                    Text('location: ${education.schoolLocation}'),
                    Text('Degree: ${education.degree}'),
                    Text('Field of Study: ${education.fieldOfStudy}'),
                    Text('Start Date: ${education.startDate}'),
                    Text('End Date: ${education.endDate}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              // Similar sections for other data lists (e.g., UserReferences, UserAwards, etc.)
              Text(
                'work experience:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (WorkExperienceData work
                  in globalController.workExperienceDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title: ${work.positionTitle}'),
                    Text('company: ${work.companyName}'),
                    Text('start: ${work.startDate}'),
                    Text('end of Study: ${work.endDate}'),
                    Text('location : ${work.location}'),
                    Text('desc : ${work.workSummary}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'skill Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (SkillData skills in globalController.skillDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Institution: ${skills.skill}'),
                    Text('location: ${skills.proficiencyLevel}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'work intern:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (UserInternshipData work
                  in globalController.userInternshipDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title: ${work.positionTitle}'),
                    Text('company: ${work.companyName}'),
                    Text('start: ${work.startDate}'),
                    Text('end of Study: ${work.endDate}'),
                    Text('location : ${work.location}'),
                    Text('desc : ${work.workSummary}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'project:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (ProjectData work in globalController.projectDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title: ${work.title}'),
                    Text('start: ${work.year}'),
                    Text('link : ${work.link}'),
                    Text('desc : ${work.description}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'socail links:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('linkwdin: ${globalController.linkedin.value}'),
              Text('github: ${globalController.github.value}'),
              Text('portfolio: ${globalController.portfolio.value}'),

              Text(
                'language:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (KnowLanguageData work
                  in globalController.knowLanguageDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('language: ${work.lang}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'certificate:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (CertificationData work
                  in globalController.certificationDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title: ${work.title}'),
                    Text('start: ${work.date}'),
                    Text('organi : ${work.issuingOrganization}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'awards:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (AwardData work in globalController.awardDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title: ${work.title}'),
                    Text('start: ${work.date}'),
                    Text('organi : ${work.issuingOrganization}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'volunteer:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (VolunteerExperienceData work
                  in globalController.volunteerExperienceDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title: ${work.title}'),
                    Text('company: ${work.company}'),
                    Text('start: ${work.startDate}'),
                    Text('end of Study: ${work.endDate}'),
                    Text('location : ${work.location}'),
                    Text('desc : ${work.description}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'interest:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (AreaOfInterestData work
                  in globalController.areaOfInterestDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('interest: ${work.interest}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'references:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (ReferenceData work in globalController.referenceDataList)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('name: ${work.name}'),
                    Text('company: ${work.company}'),
                    Text('email : ${work.email}'),
                    Text('position : ${work.position}'),
                    Text('phone : ${work.phone}'),
                    // Add more fields as needed
                    SizedBox(height: 10),
                  ],
                ),
              Text(
                'Interesed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('InterestedIN: ${globalController.interestedIn.value}'),
              // ElevatedButton(
                // onPressed: () async {
                  // Call the createResume method to post data
                  // bool result = await postResume.createResume();
                  // if (result) {
                    // Data posted successfully
                    // You can show a message or navigate to another screen if needed
                    // Example: Get.to(SomeOtherScreen());
                    // print('Data posted successfully');
                  // } else {
                    // Data posting failed
                    // Handle the error or show an error message
                    // print('Data posting failed');
                  // }
                // },
                // child: Text('Post Data'),
              // ),
            ],
          ),
        )),
      ),
    );
  }
}
