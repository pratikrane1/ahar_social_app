class AlbumModel {
  int? id;
  int? isNew;
  int? imageCount;
  String? name;
  String? coverPhoto;
  String? createdAt;
  String? updatedAt;
  String? url;

  AlbumModel(
      {this.id,
        this.name,
        this.coverPhoto,
        this.createdAt,
        this.updatedAt,
        this.url});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coverPhoto = json['cover_photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    isNew = json['is_new'];
    imageCount = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover_photo'] = this.coverPhoto;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    data['is_new'] = this.isNew;
    data['count'] = this.imageCount;
    return data;
  }
}


class AlbumImageModel {
  int? id;
  String? documentableType;
  int? documentableId;
  String? path;
  String? type;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? url;
  int? isLike;
  String? likeCount;
  int? totalShare;

  AlbumImageModel(
      {this.id,
        this.documentableType,
        this.documentableId,
        this.path,
        this.type,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.isLike,
        this.likeCount,
        this.totalShare,
        this.url});

  AlbumImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentableType = json['documentable_type'];
    documentableId = json['documentable_id'];
    path = json['path'];
    type = json['type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    isLike = json['is_like'];
    likeCount = json['likes'];
    totalShare = json['share'];
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
    data['is_like'] = this.isLike;
    data['likes'] = this.likeCount;
    data['share'] = this.totalShare;
    return data;
  }
}
