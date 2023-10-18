
class CommentModel {
  int? id;
  String? dsc;
  int? commentableId;
  String? commentableType;
  int? userId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? url;
  int? commentlike;
  int? islike;
  List<CommentReply>? commentReply;

  CommentModel(
      {this.id,
        this.dsc,
        this.commentableId,
        this.commentableType,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.userName,
        this.url,
        this.commentlike,
        this.islike,
        this.commentReply});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dsc = json['dsc'];
    commentableId = json['commentable_id'];
    commentableType = json['commentable_type'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['user_name'];
    commentlike = json['comment_like'];
    islike = json['islike'];
    url = json['url'];
    if (json['comment_reply'] != null) {
      commentReply = <CommentReply>[];
      json['comment_reply'].forEach((v) {
        commentReply!.add(new CommentReply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dsc'] = this.dsc;
    data['commentable_id'] = this.commentableId;
    data['commentable_type'] = this.commentableType;
    data['user_id'] = this.userId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_name'] = this.userName;
    data['comment_like'] = this.commentlike;
    data['islike'] = this.islike;
    data['url'] = this.url;
    if (this.commentReply != null) {
      data['comment_reply'] =
          this.commentReply!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentReply {
  int? id;
  String? dsc;
  String? username;
  int? commentableId;
  String? commentableType;
  int? userId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? url;
  int? commentlike;
  int? islike;
  User? user;

  CommentReply(
      {this.id,
        this.dsc,
        this.username,
        this.commentableId,
        this.commentableType,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.islike,
        this.url,
        this.commentlike,
        this.user});

  CommentReply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dsc = json['dsc'];
    username = json['user_name'];
    commentableId = json['commentable_id'];
    commentableType = json['commentable_type'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commentlike = json['comment_like'];
    islike = json['islike'];
    url = json['url'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dsc'] = this.dsc;
    data['user_name'] = this.username;
    data['commentable_id'] = this.commentableId;
    data['commentable_type'] = this.commentableType;
    data['user_id'] = this.userId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['comment_like'] = this.commentlike;
    data['islike'] = this.islike;
    data['url'] = this.url;
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
