class AlbumModel {
  int? id;
  String? albumName;
  String? albumImage;
  String? createdAt;
  String? updatedAt;
  String? isNewAlbum;
  int? totalImages;

  AlbumModel(
      {this.id,
        this.albumName,
        this.albumImage,
        this.createdAt,
        this.updatedAt,
        this.totalImages,
        this.isNewAlbum});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    albumName = json['album_name'];
    albumImage = json['album_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalImages = json['total_images'];
    isNewAlbum = json['new_album'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['album_name'] = this.albumName;
    data['album_image'] = this.albumImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_images'] = this.totalImages;
    data['new_album'] = this.isNewAlbum;
    return data;
  }
}

class AlbumImagesModel {
  int? id;
  String? photoUrl;
  int? albumId;
  String? albumName;
  String? createdAt;
  String? updatedAt;
  String? isLike;
  int? likeCount;
  int? totalShare;

  AlbumImagesModel(
      {this.id,
        this.photoUrl,
        this.albumId,
        this.albumName,
        this.createdAt,
        this.updatedAt,
        this.isLike,
        this.likeCount,
        this.totalShare});

  AlbumImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoUrl = json['photo_url'];
    albumId = json['album_id'];
    albumName = json['album_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLike = json['is_like'];
    likeCount = json['like_count'];
    totalShare = json['total_share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo_url'] = this.photoUrl;
    data['album_id'] = this.albumId;
    data['album_name'] = this.albumName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_like'] = this.isLike;
    data['like_count'] = this.likeCount;
    data['total_share'] = this.totalShare;
    return data;
  }
}

class LikedUserList {
  int? id;
  String? userName;
  String? profileImage;

  LikedUserList({this.id, this.userName, this.profileImage});

  LikedUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['profile_image'] = this.profileImage;
    return data;
  }
}