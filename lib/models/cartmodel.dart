class CartModel {
  String? name;
  double? currentPrice;
  String? prodImgUrl;
  int counter = 1;

  CartModel({
    required this.name,
    required this.currentPrice,
    required this.prodImgUrl,
    required this.counter,
  });

  CartModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    currentPrice = json['currentPrice'];
    prodImgUrl = json['prodImgUrl'];
    counter = json['counter'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "currentPrice": currentPrice,
      "prodImgUrl": prodImgUrl,
      "counter": counter,
    };
  }
}
