class OrderResponse {
  bool? success;
  OrderResponseData? data;

  OrderResponse({this.success, this.data});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new OrderResponseData.fromJson(json['data']) : null;
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

class OrderResponseData {
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
  List<OrderStatus>? orderStatus;
  List<Null>? voucherTransaction;

  OrderResponseData(
      {this.id,
      this.bplzId,
      this.userId,
      this.total,
      this.isPaid,
      this.profileId,
      this.createdAt,
      this.updatedAt,
      this.paymentDetail,
      this.orderItems,
      this.orderStatus,
      this.voucherTransaction});

  OrderResponseData.fromJson(Map<String, dynamic> json) {
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
    if (json['orderStatus'] != null) {
      orderStatus = <OrderStatus>[];
      json['orderStatus'].forEach((v) {
        orderStatus!.add(new OrderStatus.fromJson(v));
      });
    }
    if (json['voucherTransaction'] != null) {
      voucherTransaction = <Null>[];
      json['voucherTransaction'].forEach((v) {
        // voucherTransaction!.add(new Null.fromJson(v));
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
    if (this.orderStatus != null) {
      data['orderStatus'] = this.orderStatus!.map((v) => v.toJson()).toList();
    }
    if (this.voucherTransaction != null) {
      // data['voucherTransaction'] =
      //     this.voucherTransaction!.map((v) => v.toJson()).toList();
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
      this.updatedAt});

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
    return data;
  }
}

class OrderStatus {
  String? id;
  String? orderId;
  Null? courier;
  Null? trackingId;
  String? status;
  String? createdAt;
  String? updatedAt;

  OrderStatus(
      {this.id,
      this.orderId,
      this.courier,
      this.trackingId,
      this.status,
      this.createdAt,
      this.updatedAt});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    courier = json['courier'];
    trackingId = json['trackingId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['courier'] = this.courier;
    data['trackingId'] = this.trackingId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
