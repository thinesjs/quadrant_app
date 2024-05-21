class ProfileResponse {
  bool? success;
  List<Message>? message;

  ProfileResponse({this.success, this.message});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? id;
  String? userId;
  String? type;
  String? name;
  String? phone;
  String? address1;
  String? address2;
  String? address3;
  String? zipcode;
  String? city;
  String? state;
  String? country;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.userId,
      this.type,
      this.name,
      this.phone,
      this.address1,
      this.address2,
      this.address3,
      this.zipcode,
      this.city,
      this.state,
      this.country,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    name = json['name'];
    phone = json['phone'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    zipcode = json['zipcode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['zipcode'] = this.zipcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['isDefault'] = this.isDefault;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
