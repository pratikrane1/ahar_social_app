class Autogenerated {
  bool? success;
  List<ZoneModel>? data;
  String? message;

  Autogenerated({this.success, this.data, this.message});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ZoneModel>[];
      json['data'].forEach((v) {
        data!.add(new ZoneModel.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ZoneModel {
  int? id;
  String? zoneName;
  int? hostCityId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? hostCity;

  ZoneModel(
      {this.id,
        this.zoneName,
        this.hostCityId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.hostCity});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneName = json['zone_name'];
    hostCityId = json['host_city_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hostCity = json['host_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zone_name'] = this.zoneName;
    data['host_city_id'] = this.hostCityId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['host_city'] = this.hostCity;
    return data;
  }
}
