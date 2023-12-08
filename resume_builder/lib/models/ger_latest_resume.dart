

class GetLatestResumeModel {
  final Contact contact;
  final Address address;
  final ProfilePicture profilePicture;
  final SocialLinks socialLinks;
  final String id;
  final String userId;
  final String jobTitle;
  final String name;
  final String summary;
  final String dob;
  final String gender;
  final List<Education> education;
  final List<Work> work;
  final List<SkillsAndLevel> skillsAndLevel;
  final List<Internship> internships;
  final List<Project> projects;
  final List<KnownLanguage> knownLanguages;
  final List<Certification> certifications;
  final List<Award> awards;
  final List<VolunteerExperience> volunteerExperience;
  final List<AreaOfInterest> areaOfInterest;
  final List<Reference> references;
  final String interestedIn;
  final String createdAt;
  final String updatedAt;
  final int v;

  GetLatestResumeModel({
    required this.contact,
    required this.address,
    required this.profilePicture,
    required this.socialLinks,
    required this.id,
    required this.userId,
    required this.jobTitle,
    required this.name,
    required this.summary,
    required this.dob,
    required this.gender,
    required this.education,
    required this.work,
    required this.skillsAndLevel,
    required this.internships,
    required this.projects,
    required this.knownLanguages,
    required this.certifications,
    required this.awards,
    required this.volunteerExperience,
    required this.areaOfInterest,
    required this.references,
    required this.interestedIn,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetLatestResumeModel.fromJson(Map<String, dynamic> json) {
    return GetLatestResumeModel(
      contact: Contact.fromJson(json['contact']),
      address: Address.fromJson(json['address']),
      profilePicture: ProfilePicture.fromJson(json['profilePicture']),
      socialLinks: SocialLinks.fromJson(json['socialLinks']),
      id: json['_id'],
      userId: json['userId'],
      jobTitle: json['jobTitle'],
      name: json['name'],
      summary: json['summary'],
      dob: json['dob'],
      gender: json['gender'],
      education: List<Education>.from(
        json['education'].map((x) => Education.fromJson(x)),
      ),
      work: List<Work>.from(
        json['work'].map((x) => Work.fromJson(x)),
      ),
      skillsAndLevel: List<SkillsAndLevel>.from(
        json['skillsAndLevel'].map((x) => SkillsAndLevel.fromJson(x)),
      ),
      internships: List<Internship>.from(
        json['internShips'].map((x) => Internship.fromJson(x)),
      ),
      projects: List<Project>.from(
        json['projects'].map((x) => Project.fromJson(x)),
      ),
      knownLanguages: List<KnownLanguage>.from(
        json['knownLanguages'].map((x) => KnownLanguage.fromJson(x)),
      ),
      certifications: List<Certification>.from(
        json['certifications'].map((x) => Certification.fromJson(x)),
      ),
      awards: List<Award>.from(
        json['awards'].map((x) => Award.fromJson(x)),
      ),
      volunteerExperience: List<VolunteerExperience>.from(
        json['volunteerExperience'].map((x) => VolunteerExperience.fromJson(x)),
      ),
      areaOfInterest: List<AreaOfInterest>.from(
        json['areaOfInterest'].map((x) => AreaOfInterest.fromJson(x)),
      ),
      references: List<Reference>.from(
        json['references'].map((x) => Reference.fromJson(x)),
      ),
      interestedIn: json['interestedIn'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Contact {
  final String email;
  final String phone;

  Contact({
    required this.email,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class Address {
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }
}

class ProfilePicture {
  final String url;
  final String publicId;

  ProfilePicture({
    required this.url,
    required this.publicId,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(
      url: json['url'],
      publicId: json['public_Id'],
    );
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

  factory SocialLinks.fromJson(Map<String, dynamic> json) {
    return SocialLinks(
      linkedin: json['linkedin'],
      github: json['github'],
      portfolio: json['portfolio'],
    );
  }
}

class Education {
  final String degree;
  final String collegeName;
  final String stream;
  final String startYear;
  final String endYear;
  final String id;

  Education({
    required this.degree,
    required this.collegeName,
    required this.stream,
    required this.startYear,
    required this.endYear,
    required this.id,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'],
      collegeName: json['collegeName'],
      stream: json['stream'],
      startYear: json['startYear'],
      endYear: json['endYear'],
      id: json['_id'],
    );
  }
}

class Work {
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final String location;
  final String description;
  final String id;

  Work({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
    required this.id,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      title: json['title'],
      company: json['company'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      location: json['location'],
      description: json['description'],
      id: json['_id'],
    );
  }
}

class SkillsAndLevel {
  final String skills;
  final String level;
  final String id;

  SkillsAndLevel({
    required this.skills,
    required this.level,
    required this.id,
  });

  factory SkillsAndLevel.fromJson(Map<String, dynamic> json) {
    return SkillsAndLevel(
      skills: json['skills'],
      level: json['level'],
      id: json['_id'],
    );
  }
}

class Internship {
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final String location;
  final String description;
  final String id;

  Internship({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
    required this.id,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      title: json['title'],
      company: json['company'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      location: json['location'],
      description: json['description'],
      id: json['_id'],
    );
  }
}

class Project {
  final String title;
  final String description;
  final String year;
  final String link;
  final String id;

  Project({
    required this.title,
    required this.description,
    required this.year,
    required this.link,
    required this.id,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      year: json['year'],
      link: json['link'],
      id: json['_id'],
    );
  }
}

class KnownLanguage {
  final String lang;
  final String id;

  KnownLanguage({
    required this.lang,
    required this.id,
  });

  factory KnownLanguage.fromJson(Map<String, dynamic> json) {
    return KnownLanguage(
      lang: json['lang'],
      id: json['_id'],
    );
  }
}

class Certification {
  final String title;
  final String issuingOrganization;
  final String date;
  final String id;

  Certification({
    required this.title,
    required this.issuingOrganization,
    required this.date,
    required this.id,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      title: json['title'],
      issuingOrganization: json['issuingOrganization'],
      date: json['date'],
      id: json['_id'],
    );
  }
}

class Award {
  final String title;
  final String issuingOrganization;
  final String date;
  final String id;

  Award({
    required this.title,
    required this.issuingOrganization,
    required this.date,
    required this.id,
  });

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      title: json['title'],
      issuingOrganization: json['issuingOrganization'],
      date: json['date'],
      id: json['_id'],
    );
  }
}

class VolunteerExperience {
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final String location;
  final String description;
  final String id;

  VolunteerExperience({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
    required this.id,
  });

  factory VolunteerExperience.fromJson(Map<String, dynamic> json) {
    return VolunteerExperience(
      title: json['title'],
      company: json['company'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      location: json['location'],
      description: json['description'],
      id: json['_id'],
    );
  }
}

class AreaOfInterest {
  final String interest;
  final String id;

  AreaOfInterest({
    required this.interest,
    required this.id,
  });

  factory AreaOfInterest.fromJson(Map<String, dynamic> json) {
    return AreaOfInterest(
      interest: json['interest'],
      id: json['_id'],
    );
  }
}

class Reference {
  final String name;
  final String company;
  final String position;
  final String email;
  final String phone;
  final String id;

  Reference({
    required this.name,
    required this.company,
    required this.position,
    required this.email,
    required this.phone,
    required this.id,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      name: json['name'],
      company: json['company'],
      position: json['position'],
      email: json['email'],
      phone: json['phone'],
      id: json['_id'],
    );
  }
}
