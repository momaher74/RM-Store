class CartModel {
  String? name;
  double? currentPrice;
  String? prodImgUrl;

  CartModel({
    required this.name,
    required this.currentPrice,
    required this.prodImgUrl,
  });

  CartModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    currentPrice = json['currentPrice'];
    prodImgUrl = json['prodImgUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "currentPrice": currentPrice,
      "prodImgUrl": prodImgUrl,
    };
  }
}
