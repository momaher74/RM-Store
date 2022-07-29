class OrderModel {
  String? name;
  double? currentPrice;
  int? count;
  String? prodImgUrl;
  String? orderDate;
  String? receiveDate;

  OrderModel({
    required this.name,
    required this.currentPrice,
    required this.prodImgUrl,
    required this.count,
    required this.orderDate,
    required this.receiveDate,
  });

  OrderModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    currentPrice = json['currentPrice'];
    prodImgUrl = json['prodImgUrl'];
    orderDate = json['orderDate'];
    receiveDate = json['receiveDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "currentPrice": currentPrice,
      "prodImgUrl": prodImgUrl,
      "count": count,
      "orderDate": orderDate,
      "receiveDate": receiveDate,
    };
  }
}
