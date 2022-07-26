class RegisterModel {
  String? fName;

  String? lName;

  String? email;

  String? phone;

  String? uId;

  String? imgUrl;

  RegisterModel({
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.uId,
    required this.imgUrl,
  });

  RegisterModel.fromJsom(Map<String, dynamic>? json) {
    fName = json!['fName'];
    lName = json['lName'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      "fName": fName,
      "lName": lName,
      "email": email,
      "phone": phone,
      "uId": uId,
      "imgUrl": imgUrl,
    };
  }
}
