class AddProdModel {
  String? name;

  String? description;

  double? currentPrice;
  double? oldPrice;
  int? count;

  String? prodImgUrl;

  bool? inFav;

  bool? inCart;
  bool? discount;

  AddProdModel({
    required this.name,
    required this.description,
    required this.currentPrice,
    required this.oldPrice,
    required this.prodImgUrl,
    required this.inCart,
    required this.inFav,
    required this.count,
  });

  AddProdModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    description = json['description'];
    currentPrice = json['currentPrice'];
    oldPrice = json['oldPrice'];
    prodImgUrl = json['prodImgUrl'];
    inCart = json['inCart'];
    inFav = json['inFav'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "oldPrice": oldPrice,
      "currentPrice": currentPrice,
      "prodImgUrl": prodImgUrl,
      "inFav": inFav,
      "inCart": inCart,
      "count": count,
    };
  }
}
