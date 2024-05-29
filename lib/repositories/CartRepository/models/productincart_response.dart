class ProductInCart {
  bool? status;
  Data? data;

  ProductInCart({this.status, this.data});

  ProductInCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? cartId;
  String? productId;
  int? quantity;

  Data({this.id, this.cartId, this.productId, this.quantity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cartId'];
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartId'] = this.cartId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
