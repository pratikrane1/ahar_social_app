
class MembershipModel {
  int? id;
  String? dsc;
  int? userId;
  String? status;
  Null? deletedAt;
  String? createdAt;
  String? endAt;
  String? updatedAt;
  MembershipDetails? membershipDetails;
  User? user;

  MembershipModel(
      {this.id,
        this.dsc,
        this.userId,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.endAt,
        this.updatedAt,
        this.membershipDetails,
        this.user});

  MembershipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dsc = json['dsc'];
    userId = json['user_id'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    endAt = json['end_at'];
    updatedAt = json['updated_at'];
    membershipDetails = json['membership_details'] != null
        ? new MembershipDetails.fromJson(json['membership_details'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dsc'] = this.dsc;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['end_at'] = this.endAt;
    data['updated_at'] = this.updatedAt;
    if (this.membershipDetails != null) {
      data['membership_details'] = this.membershipDetails!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class MembershipDetails {
  int? id;
  int? amount;
  String? dsc;
  Null? createdAt;
  Null? updatedAt;

  MembershipDetails(
      {this.id, this.amount, this.dsc, this.createdAt, this.updatedAt});

  MembershipDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    dsc = json['dsc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['dsc'] = this.dsc;
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
  String? altMobileNo;
  String? email;
  String? profilePhoto;
  String? bio;
  String? role;
  Null? emailVerifiedAt;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

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
    data['bio'] = this.bio;
    data['role'] = this.role;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
