class NotificationModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? title;
  String? dsc;

  NotificationModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.title,
        this.dsc});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    title = json['title'];
    dsc = json['dsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['dsc'] = this.dsc;
    return data;
  }
}
