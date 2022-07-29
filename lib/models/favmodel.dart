class FavModel {
  String? name;
  String? description;
  double? currentPrice;
  double? oldPrice;
  String? prodImgUrl;

  FavModel({
    required this.name,
    required this.currentPrice,
    required this.prodImgUrl,
    required this.description,
    required this.oldPrice,
  });

  FavModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    currentPrice = json['currentPrice'];
    prodImgUrl = json['prodImgUrl'];
    description = json['description'];
    oldPrice = json['oldPrice'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "currentPrice": currentPrice,
      "prodImgUrl": prodImgUrl,
      "description": description,
      "oldPrice": oldPrice,
    };
  }
}
