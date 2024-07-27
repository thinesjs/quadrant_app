class EwalletQrResponse {
  bool? success;
  Data? data;

  EwalletQrResponse({this.success, this.data});

  EwalletQrResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? ewalletId;
  int? amount;
  String? createdAt;
  String? updatedAt;
  String? expiresAt;

  Data(
      {this.id,
      this.ewalletId,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.expiresAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ewalletId = json['ewalletId'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ewalletId'] = this.ewalletId;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['expiresAt'] = this.expiresAt;
    return data;
  }
}
