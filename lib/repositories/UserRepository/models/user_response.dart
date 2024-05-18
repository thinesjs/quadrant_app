class UserResponse {
  bool? success;
  Message? message;

  UserResponse({this.success, this.message});

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
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
  String? name;
  String? email;
  String? emailVerified;
  String? avatar;
  String? role;
  String? createdAt;

  Message(
      {this.id,
      this.name,
      this.email,
      this.emailVerified,
      this.avatar,
      this.role,
      this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    avatar = json['avatar'];
    role = json['role'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
