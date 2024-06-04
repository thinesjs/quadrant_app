class OrdersResponse {
  bool? success;
  List<OrdersResponseData>? data;

  OrdersResponse({this.success, this.data});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <OrdersResponseData>[];
      json['data'].forEach((v) {
        data!.add(new OrdersResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrdersResponseData {
  String? id;
  String? bplzId;
  String? userId;
  double? total;
  bool? isPaid;
  String? profileId;
  String? createdAt;
  String? updatedAt;
  PaymentDetail? paymentDetail;
  List<OrderItems>? orderItems;

  OrdersResponseData(
      {this.id,
      this.bplzId,
      this.userId,
      this.total,
      this.isPaid,
      this.profileId,
      this.createdAt,
      this.updatedAt,
      this.paymentDetail,
      this.orderItems});

  OrdersResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bplzId = json['bplzId'];
    userId = json['userId'];
    total = json['total'];
    isPaid = json['isPaid'];
    profileId = json['profileId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    paymentDetail = json['paymentDetail'] != null
        ? new PaymentDetail.fromJson(json['paymentDetail'])
        : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bplzId'] = this.bplzId;
    data['userId'] = this.userId;
    data['total'] = this.total;
    data['isPaid'] = this.isPaid;
    data['profileId'] = this.profileId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.paymentDetail != null) {
      data['paymentDetail'] = this.paymentDetail!.toJson();
    }
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetail {
  String? id;
  double? amount;
  String? currency;
  String? userId;
  String? orderId;
  bool? isPaid;
  String? gateway;
  String? createdAt;
  String? updatedAt;

  PaymentDetail(
      {this.id,
      this.amount,
      this.currency,
      this.userId,
      this.orderId,
      this.isPaid,
      this.gateway,
      this.createdAt,
      this.updatedAt});

  PaymentDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    currency = json['currency'];
    userId = json['userId'];
    orderId = json['orderId'];
    isPaid = json['isPaid'];
    gateway = json['gateway'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['userId'] = this.userId;
    data['orderId'] = this.orderId;
    data['isPaid'] = this.isPaid;
    data['gateway'] = this.gateway;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class OrderItems {
  String? id;
  String? orderId;
  String? productId;
  double? price;
  int? quantity;
  double? subTotal;
  Product? product;

  OrderItems(
      {this.id,
      this.orderId,
      this.productId,
      this.price,
      this.quantity,
      this.subTotal,
      this.product});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    productId = json['productId'];
    price = json['price'];
    quantity = json['quantity'];
    subTotal = json['subTotal'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['subTotal'] = this.subTotal;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? desc;
  int? stock;
  double? price;
  bool? isFeatured;
  String? status;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  List<Images>? images;

  Product(
      {this.id,
      this.name,
      this.desc,
      this.stock,
      this.price,
      this.isFeatured,
      this.status,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    stock = json['stock'];
    price = json['price'];
    isFeatured = json['isFeatured'];
    status = json['status'];
    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['isFeatured'] = this.isFeatured;
    data['status'] = this.status;
    data['categoryId'] = this.categoryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? id;
  String? productId;
  String? url;
  String? createdAt;
  String? updatedAt;

  Images({this.id, this.productId, this.url, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
