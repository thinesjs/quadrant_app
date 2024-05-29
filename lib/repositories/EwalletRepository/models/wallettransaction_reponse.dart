// class WalletTransactionResponse {
//   bool? success;
//   Data? data;

//   WalletTransactionResponse({this.success, this.data});

//   WalletTransactionResponse.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String? id;
//   String? userId;
//   int? balance;
//   String? createdAt;
//   String? updatedAt;
//   List<Null>? transactions;

//   Data(
//       {this.id,
//       this.userId,
//       this.balance,
//       this.createdAt,
//       this.updatedAt,
//       this.transactions});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['userId'];
//     balance = json['balance'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     if (json['transactions'] != null) {
//       transactions = <Null>[];
//       json['transactions'].forEach((v) {
//         transactions!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userId'] = this.userId;
//     data['balance'] = this.balance;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     if (this.transactions != null) {
//       data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
