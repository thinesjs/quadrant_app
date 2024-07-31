class WalletResponse {
  bool? success;
  bool? new_user;
  Data? data;

  WalletResponse({this.success, this.data});

  WalletResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    new_user = json['new_user'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['new_user'] = this.new_user;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  double? balance;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.userId, this.balance, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    balance = json['balance'] != null ? (json['balance'] as num).toDouble() : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['balance'] = this.balance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
