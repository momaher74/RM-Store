class OrderModel {
  String? name;
  double? currentPrice;
  int? count;
  String? prodImgUrl;

  OrderModel({
    required this.name,
    required this.currentPrice,
    required this.prodImgUrl,
    required this.count,
  });

  OrderModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    currentPrice = json['currentPrice'];
    prodImgUrl = json['prodImgUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "currentPrice": currentPrice,
      "prodImgUrl": prodImgUrl,
      "count": count,
    };
  }
}
