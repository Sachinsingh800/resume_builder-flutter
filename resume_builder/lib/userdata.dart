class UserData {
  final String jobTitle;
  final String name;
  final String summary;
  final ContactData contact;
  final String dob;
  final String gender;
  final AddressData address;
  final String profilePicture;
  final List<EducationData> education;
  final List<WorkData> work;
  final List<SkillsData> skillsAndLevel;
  final List<InternshipData> internShips;
  final List<ProjectData> projects;
  final SocialLinksData socialLinks;
  final List<KnownLanguagesData> knownLanguages;
  final List<CertificationsData> certifications;
  final List<AwardsData> awards;
  final List<VolunteerExperienceData> volunteerExperience;
  final List<AreaOfInterestData> areaOfInterest;
  final List<ReferencesData> references;
  final String interestedIn;

  UserData({
    required this.jobTitle,
    required this.name,
    required this.summary,
    required this.contact,
    required this.dob,
    required this.gender,
    required this.address,
    required this.profilePicture,
    required this.education,
    required this.work,
    required this.skillsAndLevel,
    required this.internShips,
    required this.projects,
    required this.socialLinks,
    required this.knownLanguages,
    required this.certifications,
    required this.awards,
    required this.volunteerExperience,
    required this.areaOfInterest,
    required this.references,
    required this.interestedIn,
  });

  Map<String, dynamic> toJson() {
    return {
      'resume': {
        'jobTitle': jobTitle,
        'name': name,
        'summary': summary,
        'contact': contact.toJson(),
        'dob': dob,
        'gender': gender,
        'address': address.toJson(),
        'profilePicture': profilePicture,
        'education': education.map((e) => e.toJson()).toList(),
        'work': work.map((e) => e.toJson()).toList(),
        'skillsAndLevel': skillsAndLevel.map((e) => e.toJson()).toList(),
        'internShips': internShips.map((e) => e.toJson()).toList(),
        'projects': projects.map((e) => e.toJson()).toList(),
        'socialLinks': socialLinks.toJson(),
        'knownLanguages': knownLanguages.map((e) => e.toJson()).toList(),
        'certifications': certifications.map((e) => e.toJson()).toList(),
        'awards': awards.map((e) => e.toJson()).toList(),
        'volunteerExperience': volunteerExperience.map((e) => e.toJson()).toList(),
        'areaOfInterest': areaOfInterest.map((e) => e.toJson()).toList(),
        'references': references.map((e) => e.toJson()).toList(),
        'interestedIn': interestedIn,
      }
    };
  }
}

class ContactData {
  final String email;
  final String phone;

  ContactData({
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

class AddressData {
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  AddressData({
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
class EducationData {
  final String degree;
  final String collegeName;
  final String stream;
  final String startYear;
  final String endYear;
  final String city;

  EducationData({
    required this.degree,
    required this.collegeName,
    required this.stream,
    required this.startYear,
    required this.endYear,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'collegeName': collegeName,
      'stream': stream,
      'startYear': startYear,
      'endYear': endYear,
      'city': city,
    };
  }
}
class WorkData {
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final String location;
  final String description;

  WorkData({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'description': description,
    };
  }
}
class SkillsData {
  final String skills;
  final String level;

  SkillsData({
    required this.skills,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      'skills': skills,
      'level': level,
    };
  }
}
class InternshipData {
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final String location;
  final String description;

  InternshipData({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'description': description,
    };
  }
}
class ProjectData {
  final String title;
  final String description;
  final String year;
  final String link;

  ProjectData({
    required this.title,
    required this.description,
    required this.year,
    required this.link,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'year': year,
      'link': link,
    };
  }
}
class SocialLinksData {
  final String linkedin;
  final String github;
  final String portfolio;

  SocialLinksData({
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
class KnownLanguagesData {
  final String lang;

  KnownLanguagesData({
    required this.lang,
  });

  Map<String, dynamic> toJson() {
    return {
      'lang': lang,
    };
  }
}
class CertificationsData {
  final String title;
  final String issuingOrganization;
  final String date;

  CertificationsData({
    required this.title,
    required this.issuingOrganization,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'issuingOrganization': issuingOrganization,
      'date': date,
    };
  }
}
class AwardsData {
  final String title;
  final String issuingOrganization;
  final String date;

  AwardsData({
    required this.title,
    required this.issuingOrganization,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'issuingOrganization': issuingOrganization,
      'date': date,
    };
  }
}
class VolunteerExperienceData {
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final String location;
  final String description;

  VolunteerExperienceData({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'description': description,
    };
  }
}
class AreaOfInterestData {
  final String interest;

  AreaOfInterestData({
    required this.interest,
  });

  Map<String, dynamic> toJson() {
    return {
      'interest': interest,
    };
  }
}
class ReferencesData {
  final String name;
  final String company;
  final String email;
  final String position;
  final String phone;

  ReferencesData({
    required this.name,
    required this.company,
    required this.email,
    required this.position,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'company': company,
      'email': email,
      'position': position,
      'phone': phone,
    };
  }
}
