class UserCartResponse {
  bool? status;
  Data? data;
  Meta? meta;

  UserCartResponse({this.status, this.data, this.meta});

  UserCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  List<Items>? items;
  List<Vouchers>? vouchers;

  Data({this.id, this.userId, this.items, this.vouchers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['vouchers'] != null) {
      vouchers = <Vouchers>[];
      json['vouchers'].forEach((v) {
        vouchers!.add(new Vouchers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.vouchers != null) {
      data['vouchers'] = this.vouchers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? cartId;
  String? productId;
  int? quantity;
  Product? product;

  Items({this.id, this.cartId, this.productId, this.quantity, this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cartId'];
    productId = json['productId'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartId'] = this.cartId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
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

class Vouchers {
  String? id;
  String? cartId;
  String? voucherId;
  Voucher? voucher;

  Vouchers({this.id, this.cartId, this.voucherId, this.voucher});

  Vouchers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cartId'];
    voucherId = json['voucherId'];
    voucher =
        json['voucher'] != null ? new Voucher.fromJson(json['voucher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartId'] = this.cartId;
    data['voucherId'] = this.voucherId;
    if (this.voucher != null) {
      data['voucher'] = this.voucher!.toJson();
    }
    return data;
  }
}

class Voucher {
  String? id;
  String? name;
  String? description;
  String? code;
  int? discount;
  int? quota;
  String? status;
  bool? isWhitelisted;
  int? minTotal;
  List<String>? categoryIds;
  String? createdAt;
  String? updatedAt;

  Voucher(
      {this.id,
      this.name,
      this.description,
      this.code,
      this.discount,
      this.quota,
      this.status,
      this.isWhitelisted,
      this.minTotal,
      this.categoryIds,
      this.createdAt,
      this.updatedAt});

  Voucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    discount = json['discount'];
    quota = json['quota'];
    status = json['status'];
    isWhitelisted = json['isWhitelisted'];
    minTotal = json['minTotal'];
    categoryIds = json['categoryIds'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['quota'] = this.quota;
    data['status'] = this.status;
    data['isWhitelisted'] = this.isWhitelisted;
    data['minTotal'] = this.minTotal;
    data['categoryIds'] = this.categoryIds;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Meta {
  double? subtotal;
  int? discount;
  double? total;

  Meta({this.subtotal, this.discount, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    discount = json['discount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['total'] = this.total;
    return data;
  }
}
