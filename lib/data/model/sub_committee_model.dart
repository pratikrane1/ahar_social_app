class SubCommitteeModel {
  int? id;
  int? userId;
  int? committeDivisionId;
  Null? deletedAt;
  Null? createdAt;
  Null? updatedAt;
  String? committeDivisionName;
  String? committeName;
  int? committeId;
  User? user;

  SubCommitteeModel(
      {this.id,
        this.userId,
        this.committeDivisionId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.committeDivisionName,
        this.committeName,
        this.committeId,
        this.user});

  SubCommitteeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    committeDivisionId = json['committe_division_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    committeDivisionName = json['committe_division_name'];
    committeName = json['committe_name'];
    committeId = json['committe_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['committe_division_id'] = this.committeDivisionId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['committe_division_name'] = this.committeDivisionName;
    data['committe_name'] = this.committeName;
    data['committe_id'] = this.committeId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? businessName;
  String? city;
  String? address;
  String? mobileNo;
  Null? altMobileNo;
  String? email;
  Null? profilePhoto;
  Null? bio;
  String? role;
  Null? emailVerifiedAt;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? url;

  User(
      {this.id,
        this.name,
        this.businessName,
        this.city,
        this.address,
        this.mobileNo,
        this.altMobileNo,
        this.email,
        this.profilePhoto,
        this.bio,
        this.role,
        this.emailVerifiedAt,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.url});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    businessName = json['business_name'];
    city = json['city'];
    address = json['address'];
    mobileNo = json['mobile_no'];
    altMobileNo = json['alt_mobile_no'];
    email = json['email'];
    profilePhoto = json['profile_photo'];
    bio = json['bio'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['business_name'] = this.businessName;
    data['city'] = this.city;
    data['address'] = this.address;
    data['mobile_no'] = this.mobileNo;
    data['alt_mobile_no'] = this.altMobileNo;
    data['email'] = this.email;
    data['profile_photo'] = this.profilePhoto;
    data['bio'] = this.bio;
    data['role'] = this.role;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}
