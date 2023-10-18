
class BannerModel {
  int? id;
  String? documentableType;
  int? documentableId;
  String? path;
  String? type;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? url;

  BannerModel(
      {this.id,
        this.documentableType,
        this.documentableId,
        this.path,
        this.type,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentableType = json['documentable_type'];
    documentableId = json['documentable_id'];
    path = json['path'];
    type = json['type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['documentable_type'] = this.documentableType;
    data['documentable_id'] = this.documentableId;
    data['path'] = this.path;
    data['type'] = this.type;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}
