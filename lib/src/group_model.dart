class GroupModel {
  String? position;
  String? committeName;
  String? name;
  String? businessName;
  String? mobileNo;
  String? email;

  GroupModel(
      {this.position, this.name, this.businessName, this.mobileNo, this.email});

  GroupModel.fromJson(Map<String, dynamic> json) {
    position = json['position_name'];
    committeName = json['committe_name'];
    name = json['name'];
    businessName = json['business_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position_name'] = this.position;
    data['committe_name'] = this.committeName;
    data['name'] = this.name;
    data['business_name'] = this.businessName;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    return data;
  }
}

class SubCommitee {
  bool? success;
  SubCommiteeModel? data;
  String? message;

  SubCommitee({this.success, this.data, this.message});

  SubCommitee.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new SubCommiteeModel.fromJson(json['data'])
        : null;
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

class SubCommiteeModel {
  List<Police>? police;
  List<Police>? excise;
  List<Police>? publication;

  SubCommiteeModel({this.police, this.excise, this.publication});

  SubCommiteeModel.fromJson(Map<String, dynamic> json) {
    if (json['Police'] != null) {
      police = <Police>[];
      json['Police'].forEach((v) {
        police!.add(new Police.fromJson(v));
      });
    }
    if (json['Excise'] != null) {
      excise = <Police>[];
      json['Excise'].forEach((v) {
        excise!.add(new Police.fromJson(v));
      });
    }
    if (json['Publication'] != null) {
      publication = <Police>[];
      json['Publication'].forEach((v) {
        publication!.add(new Police.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.police != null) {
      data['Police'] = this.police!.map((v) => v.toJson()).toList();
    }
    if (this.excise != null) {
      data['Excise'] = this.excise!.map((v) => v.toJson()).toList();
    }
    if (this.publication != null) {
      data['Publication'] = this.publication!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Police {
  String? committeName;
  String? name;
  String? businessName;
  String? mobileNo;
  String? email;

  Police(
      {this.committeName,
      this.name,
      this.businessName,
      this.mobileNo,
      this.email});

  Police.fromJson(Map<String, dynamic> json) {
    committeName = json['committe_name'];
    name = json['name'];
    businessName = json['business_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['committe_name'] = this.committeName;
    data['name'] = this.name;
    data['business_name'] = this.businessName;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    return data;
  }
}
