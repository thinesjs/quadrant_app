class EwalletReloadResponse {
  bool? status;
  String? orderId;
  String? redirectUrl;

  EwalletReloadResponse({this.status, this.orderId, this.redirectUrl});

  EwalletReloadResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderId = json['orderId'];
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['orderId'] = this.orderId;
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}
