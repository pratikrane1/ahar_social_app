class LoginModel {
  bool? success;
  LoginData? data;
  String? message;

  LoginModel({this.success, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class LoginData {
  int? userId;
  String? token;
  String? name;
  String? role;
  String? mobileNumber;

  LoginData({this.userId,this.name,this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    token = json['token'];
    role = json['role'];
    mobileNumber = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['token'] = this.token;
    data['role'] = this.role;
    data['mobile_no'] = this.mobileNumber;
    return data;
  }
}
