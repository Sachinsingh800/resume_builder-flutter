class GetAllResume {
  Contact? contact;
  Address? address;
  SocialLinks? socialLinks;
  String? sId;
  String? jobTitle;
  String? name;
  String? summary;
  String? dob;
  String? tempId;
  String? gender;
  List<Education>? education;
  List<Work>? work;
  List<SkillsAndLevel>? skillsAndLevel;
  List<Internships>? internShips;
  List<Projects>? projects;
  List<KnownLanguages>? knownLanguages;
  List<Certifications>? certifications;
  List<AreaOfInterest>? areaOfInterest;
  List<References>? references;
  String? interestedIn;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAllResume(
      {this.contact,
        this.address,
        this.socialLinks,
        this.sId,
        this.jobTitle,
        this.name,
        this.summary,
        this.dob,
        this.tempId,
        this.gender,
        this.education,
        this.work,
        this.skillsAndLevel,
        this.internShips,
        this.projects,
        this.knownLanguages,
        this.certifications,
        this.areaOfInterest,
        this.references,
        this.interestedIn,
        this.createdAt,
        this.updatedAt,
        this.iV});

  GetAllResume.fromJson(Map<String, dynamic> json) {
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    socialLinks = json['socialLinks'] != null
        ? new SocialLinks.fromJson(json['socialLinks'])
        : null;
    sId = json['_id'];
    jobTitle = json['jobTitle'];
    name = json['name'];
    summary = json['summary'];
    dob = json['dob'];
    tempId = json['tempId'];
    gender = json['gender'];
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    if (json['work'] != null) {
      work = <Work>[];
      json['work'].forEach((v) {
        work!.add(new Work.fromJson(v));
      });
    }
    if (json['skillsAndLevel'] != null) {
      skillsAndLevel = <SkillsAndLevel>[];
      json['skillsAndLevel'].forEach((v) {
        skillsAndLevel!.add(new SkillsAndLevel.fromJson(v));
      });
    }
    if (json['internShips'] != null) {
      internShips = <Internships>[];
      json['internShips'].forEach((v) {
        internShips!.add(new Internships.fromJson(v));
      });
    }
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
    if (json['knownLanguages'] != null) {
      knownLanguages = <KnownLanguages>[];
      json['knownLanguages'].forEach((v) {
        knownLanguages!.add(new KnownLanguages.fromJson(v));
      });
    }
    if (json['certifications'] != null) {
      certifications = <Certifications>[];
      json['certifications'].forEach((v) {
        certifications!.add(new Certifications.fromJson(v));
      });
    }
    if (json['areaOfInterest'] != null) {
      areaOfInterest = <AreaOfInterest>[];
      json['areaOfInterest'].forEach((v) {
        areaOfInterest!.add(new AreaOfInterest.fromJson(v));
      });
    }
    if (json['references'] != null) {
      references = <References>[];
      json['references'].forEach((v) {
        references!.add(new References.fromJson(v));
      });
    }
    interestedIn = json['interestedIn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.socialLinks != null) {
      data['socialLinks'] = this.socialLinks!.toJson();
    }
    data['_id'] = this.sId;
    data['jobTitle'] = this.jobTitle;
    data['name'] = this.name;
    data['summary'] = this.summary;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    if (this.work != null) {
      data['work'] = this.work!.map((v) => v.toJson()).toList();
    }
    if (this.skillsAndLevel != null) {
      data['skillsAndLevel'] =
          this.skillsAndLevel!.map((v) => v.toJson()).toList();
    }
    if (this.internShips != null) {
      data['internShips'] =
          this.internShips!.map((v) => v.toJson()).toList();
    }
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    if (this.knownLanguages != null) {
      data['knownLanguages'] =
          this.knownLanguages!.map((v) => v.toJson()).toList();
    }
    if (this.certifications != null) {
      data['certifications'] =
          this.certifications!.map((v) => v.toJson()).toList();
    }
    if (this.areaOfInterest != null) {
      data['areaOfInterest'] =
          this.areaOfInterest!.map((v) => v.toJson()).toList();
    }
    if (this.references != null) {
      data['references'] = this.references!.map((v) => v.toJson()).toList();
    }
    data['interestedIn'] = this.interestedIn;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Contact {
  String? email;
  String? phone;

  Contact({this.email, this.phone});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Address {
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  Address({this.address, this.city, this.state, this.postalCode, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['country'] = this.country;
    return data;
  }
}

class SocialLinks {
  String? linkedin;
  String? github;
  String? portfolio;

  SocialLinks({this.linkedin, this.github, this.portfolio});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    linkedin = json['linkedin'];
    github = json['github'];
    portfolio = json['portfolio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['linkedin'] = this.linkedin;
    data['github'] = this.github;
    data['portfolio'] = this.portfolio;
    return data;
  }
}

class Education {
  String? degree;
  String? collegeName;
  String? stream;
  String? startYear;
  String? endYear;
  String? city;
  String? sId;

  Education(
      {this.degree,
        this.collegeName,
        this.stream,
        this.startYear,
        this.endYear,
        this.city,
        this.sId});

  Education.fromJson(Map<String, dynamic> json) {
    degree = json['degree'];
    collegeName = json['collegeName'];
    stream = json['stream'];
    startYear = json['startYear'];
    endYear = json['endYear'];
    city = json['city'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['degree'] = this.degree;
    data['collegeName'] = this.collegeName;
    data['stream'] = this.stream;
    data['startYear'] = this.startYear;
    data['endYear'] = this.endYear;
    data['city'] = this.city;
    data['_id'] = this.sId;
    return data;
  }
}

class Work {
  String? title;
  String? company;
  String? startDate;
  String? endDate;
  String? location;
  String? description;
  String? sId;

  Work(
      {this.title,
        this.company,
        this.startDate,
        this.endDate,
        this.location,
        this.description,
        this.sId});

  Work.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    company = json['company'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    location = json['location'];
    description = json['description'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['company'] = this.company;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['location'] = this.location;
    data['description'] = this.description;
    data['_id'] = this.sId;
    return data;
  }
}

class SkillsAndLevel {
  String? skills;
  String? level;
  String? sId;

  SkillsAndLevel({this.skills, this.level, this.sId});

  SkillsAndLevel.fromJson(Map<String, dynamic> json) {
    skills = json['skills'];
    level = json['level'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skills'] = this.skills;
    data['level'] = this.level;
    data['_id'] = this.sId;
    return data;
  }
}
class Internships {
  String? title;
  String? company;
  String? startDate;
  String? endDate;
  String? location;
  String? description;
  String? sId;

  Internships({
    this.title,
    this.company,
    this.startDate,
    this.endDate,
    this.description,
    this.sId
});

  Internships.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    company = json['company'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['company'] = this.company;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['_id'] = this.sId;
    return data;
  }
}

class Projects {
  String? title;
  String? description;
  String? year;
  String? link;
  String? sId;

  Projects({this.title, this.description, this.year, this.link, this.sId});

  Projects.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    year = json['year'];
    link = json['link'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['year'] = this.year;
    data['link'] = this.link;
    data['_id'] = this.sId;
    return data;
  }
}

class KnownLanguages {
  String? lang;
  String? sId;

  KnownLanguages({this.lang, this.sId});

  KnownLanguages.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = this.lang;
    data['_id'] = this.sId;
    return data;
  }
}

class Certifications {
  String? title;
  String? issuingOrganization;
  String? date;
  String? sId;

  Certifications({this.title, this.issuingOrganization, this.date, this.sId});

  Certifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    issuingOrganization = json['issuingOrganization'];
    date = json['date'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['issuingOrganization'] = this.issuingOrganization;
    data['date'] = this.date;
    data['_id'] = this.sId;
    return data;
  }
}

class AreaOfInterest {
  String? interest;
  String? sId;

  AreaOfInterest({this.interest, this.sId});

  AreaOfInterest.fromJson(Map<String, dynamic> json) {
    interest = json['interest'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interest'] = this.interest;
    data['_id'] = this.sId;
    return data;
  }
}

class References {
  String? name;
  String? company;
  String? position;
  String? email;
  String? phone;
  String? sId;

  References(
      {this.name,
        this.company,
        this.position,
        this.email,
        this.phone,
        this.sId});

  References.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    company = json['company'];
    position = json['position'];
    email = json['email'];
    phone = json['phone'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['company'] = this.company;
    data['position'] = this.position;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['_id'] = this.sId;
    return data;
  }
}
