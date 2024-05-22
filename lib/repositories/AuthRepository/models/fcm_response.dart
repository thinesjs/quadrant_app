class FcmResponse {
  bool? success;
  Message? message;

  FcmResponse({this.success, this.message});

  FcmResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    // message =
    // json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? id;
  String? token;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Message({this.id, this.token, this.userId, this.createdAt, this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
