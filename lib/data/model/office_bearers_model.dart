class OfficeBearers {
  int? id;
  int? positionId;
  int? userId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Position? position;
  User? user;

  OfficeBearers(
      {this.id,
      this.positionId,
      this.userId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.position,
      this.user});

  OfficeBearers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionId = json['position_id'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position_id'] = this.positionId;
    data['user_id'] = this.userId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Position {
  int? id;
  String? positionName;
  Null? deletedAt;
  Null? createdAt;
  Null? updatedAt;

  Position(
      {this.id,
      this.positionName,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Position.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionName = json['position_name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position_name'] = this.positionName;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
      this.url,
      this.bio,
      this.role,
      this.emailVerifiedAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

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
    url = json['url'];
    bio = json['bio'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['url'] = this.url;
    data['bio'] = this.bio;
    data['role'] = this.role;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
