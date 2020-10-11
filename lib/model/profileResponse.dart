class ProfileResponse {
  Profile profile;

  ProfileResponse({this.profile});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
}

class Profile {
  Name name;
  Contact contact;
  Address address;
  bool userIsAvailable;
  bool deleted;
  String sId;
  String licenseNo;
  String role;

  Profile(
      {this.name,
      this.contact,
      this.address,
      this.userIsAvailable,
      this.deleted,
      this.sId,
      this.licenseNo,
      this.role});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    userIsAvailable = json['user_is_available'];
    deleted = json['deleted'];
    sId = json['_id'];
    licenseNo = json['license_no'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['user_is_available'] = this.userIsAvailable;
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    data['license_no'] = this.licenseNo;
    data['role'] = this.role;
    return data;
  }
}

class Name {
  String first;
  String middle;
  String last;

  Name({this.first, this.middle, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    middle = json['middle'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['middle'] = this.middle;
    data['last'] = this.last;
    return data;
  }
}

class Contact {
  String email;
  String phone;

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
  String no;
  String street;
  String city;

  Address({this.no, this.street, this.city});

  Address.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    street = json['street'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['street'] = this.street;
    data['city'] = this.city;
    return data;
  }
}
