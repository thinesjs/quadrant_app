class WalletTransactionsResponse {
  bool? success;
  WalletTransactionsData? data;

  WalletTransactionsResponse({this.success, this.data});

  WalletTransactionsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new WalletTransactionsData.fromJson(json['data']) : null;
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

class WalletTransactionsData {
  String? id;
  String? userId;
  double? balance;
  String? createdAt;
  String? updatedAt;
  List<Transactions>? transactions;

  WalletTransactionsData(
      {this.id,
      this.userId,
      this.balance,
      this.createdAt,
      this.updatedAt,
      this.transactions});

  WalletTransactionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    balance = json['balance'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['balance'] = this.balance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? id;
  String? ewalletId;
  int? amount;
  String? transactionType;
  String? description;
  String? createdAt;
  String? updatedAt;

  Transactions(
      {this.id,
      this.ewalletId,
      this.amount,
      this.transactionType,
      this.description,
      this.createdAt,
      this.updatedAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ewalletId = json['ewalletId'];
    amount = json['amount'];
    transactionType = json['transactionType'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ewalletId'] = this.ewalletId;
    data['amount'] = this.amount;
    data['transactionType'] = this.transactionType;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
