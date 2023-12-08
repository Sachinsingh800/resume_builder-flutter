class GetAllCover {
  SocialLinks? socialLinks;
  String? sId;
  String? userId;
  NameAndContact? nameAndContact;
  String? date;
  Recipient? recipient;
  String? subject;
  String? greeting;
  String? opening;
  String? letterBody;
  String? callToAction;
  String? closing;
  String? signature;
  String? availability;
  String? confidentiality;
  String? gaps;
  String? relocation;
  String? salaryRequirements;
  String? tempID;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetAllCover(
      {this.socialLinks,
        this.sId,
        this.userId,
        this.nameAndContact,
        this.date,
        this.recipient,
        this.subject,
        this.greeting,
        this.opening,
        this.letterBody,
        this.callToAction,
        this.closing,
        this.signature,
        this.availability,
        this.confidentiality,
        this.gaps,
        this.relocation,
        this.salaryRequirements,
        this.tempID,
        this.createdAt,
        this.updatedAt,
        this.iV});

  GetAllCover.fromJson(Map<String, dynamic> json) {
    socialLinks = json['socialLinks'] != null
        ? new SocialLinks.fromJson(json['socialLinks'])
        : null;
    sId = json['_id'];
    userId = json['userId'];
    nameAndContact = json['nameAndContact'] != null
        ? new NameAndContact.fromJson(json['nameAndContact'])
        : null;
    date = json['date'];
    recipient = json['recipient'] != null
        ? new Recipient.fromJson(json['recipient'])
        : null;
    subject = json['subject'];
    greeting = json['greeting'];
    opening = json['opening'];
    letterBody = json['letterBody'];
    callToAction = json['callToAction'];
    closing = json['closing'];
    signature = json['signature'];
    availability = json['availability'];
    confidentiality = json['confidentiality'];
    gaps = json['gaps'];
    relocation = json['relocation'];
    salaryRequirements = json['salaryRequirements'];
    tempID = json['tempID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.socialLinks != null) {
      data['socialLinks'] = this.socialLinks!.toJson();
    }
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.nameAndContact != null) {
      data['nameAndContact'] = this.nameAndContact!.toJson();
    }
    data['date'] = this.date;
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    data['subject'] = this.subject;
    data['greeting'] = this.greeting;
    data['opening'] = this.opening;
    data['letterBody'] = this.letterBody;
    data['callToAction'] = this.callToAction;
    data['closing'] = this.closing;
    data['signature'] = this.signature;
    data['availability'] = this.availability;
    data['confidentiality'] = this.confidentiality;
    data['gaps'] = this.gaps;
    data['relocation'] = this.relocation;
    data['salaryRequirements'] = this.salaryRequirements;
    data['tempID'] = this.tempID;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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

class NameAndContact {
  String? firstName;
  String? lastName;
  String? profession;
  String? city;
  String? state;
  String? zip;
  String? phoneNumber;
  String? email;
  String? sId;

  NameAndContact(
      {this.firstName,
        this.lastName,
        this.profession,
        this.city,
        this.state,
        this.zip,
        this.phoneNumber,
        this.email,
        this.sId});

  NameAndContact.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    profession = json['profession'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profession'] = this.profession;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['_id'] = this.sId;
    return data;
  }
}

class Recipient {
  String? firstName;
  String? lastName;
  String? companyName;
  String? city;
  String? state;
  String? zip;
  String? phoneNumber;
  String? email;
  String? sId;

  Recipient(
      {this.firstName,
        this.lastName,
        this.companyName,
        this.city,
        this.state,
        this.zip,
        this.phoneNumber,
        this.email,
        this.sId});

  Recipient.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    companyName = json['companyName'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['companyName'] = this.companyName;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['_id'] = this.sId;
    return data;
  }
}
