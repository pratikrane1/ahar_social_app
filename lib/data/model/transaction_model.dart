
class TransactionHistoryModel {
  int? id;
  String? dsc;
  int? userId;
  String? paymentStatus;
  int? amount;
  String? txnId;
  String? payWith;
  int? isSettle;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  User? user;

  TransactionHistoryModel(
      {this.id,
        this.dsc,
        this.userId,
        this.paymentStatus,
        this.amount,
        this.txnId,
        this.payWith,
        this.isSettle,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.user});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dsc = json['dsc'];
    userId = json['user_id'];
    paymentStatus = json['payment_status'];
    amount = json['amount'];
    txnId = json['txn_id'];
    payWith = json['pay_with'];
    isSettle = json['is_settle'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dsc'] = this.dsc;
    data['user_id'] = this.userId;
    data['payment_status'] = this.paymentStatus;
    data['amount'] = this.amount;
    data['txn_id'] = this.txnId;
    data['pay_with'] = this.payWith;
    data['is_settle'] = this.isSettle;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  String? profilePhoto;
  String? bio;
  String? fcmToken;
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
        this.fcmToken,
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
    fcmToken = json['fcm_token'];
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
    data['fcm_token'] = this.fcmToken;
    data['role'] = this.role;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
