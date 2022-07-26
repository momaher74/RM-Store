import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:buyall/componant/componant.dart';
import 'package:buyall/layout/cartscreen.dart';
import 'package:buyall/layout/favscreen.dart';
import 'package:buyall/models/addproductmodel.dart';
import 'package:buyall/models/registermodel.dart';
import 'package:buyall/layout/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../componant/constant.dart';
import '../shared/sharedpref.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  bool visible = true;
  bool confirmVisible = true;
  bool rememberUser = false;

  void changeVisible() {
    visible = !visible;
    emit(ChangeVisibleSuccessState());
  }

  void rememberMe() {
    rememberUser = !rememberUser;
    emit(RememberUser());
  }

  void changeConfirmVisible() {
    confirmVisible = !confirmVisible;
    emit(ChangeConfirmVisibleSuccessState());
  }

  RegisterModel? registerModel;
  String? userId;

  String? registerError;

  void register({
    required String email,
    required String password,
    required String fName,
    required String lName,
    required String phone,
    required String imgUrl,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userId = value.user!.uid;
      registerModel = RegisterModel(
        fName: fName,
        lName: lName,
        email: email,
        phone: phone,
        uId: userId,
        imgUrl: imgUrl,
      );
      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .set(registerModel!.toMap())
          .then((value) {
        emit(RegisterSuccessState());
      }).catchError((error) {
        print(error.toString());
        registerError = error.toString();
        emit(RegisterErrorState());
      });
    }).catchError((error) {
      registerError = error.toString();
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  String? loginError;

  void sign({
    required String email,
    required String password,
  }) {
    emit(SignLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: "uId", value: value.user!.uid);
      emit(SignSuccessState());
    }).catchError((error) {
      print(error);
      loginError = error.toString();
      emit(SignErrorState());
    });
  }

  void saveUid({required BuildContext context}) {
    emit(SaveUidLoadingState());
    CacheHelper.saveData(key: 'uId', value: userId).then((value) {
      pushReplacement(context, HomeScreen());
      emit(SaveUidSuccessState());
    }).catchError((error) {
      emit(SaveUidErrorState());
    });
  }

  List<String> catName = ["Men clothes", "Men Watches"];
  List<String> catPrice = ["30.0 \$", "45.0 \$"];
  List<String> catImg = ["assets/images/man.png", "assets/images/watch.png"];
  List<String> newAchieveImgs = [
    "assets/images/womanwatch.png",
    "assets/images/cole.png",
    "assets/images/man.png",
    "assets/images/watch.png"
  ];
  List<String> newAchieveName = [
    "Woman Watches",
    "Coles",
    "Men clothes",
    "Men Watches"
  ];
  List<String> newAchievePrice = ["55.0 \$", "360.0 \$", "30.0 \$", "45.0 \$"];

  ImagePicker picker = ImagePicker();
  File? prodImage;

  Future<void> pickProductImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      prodImage = File(pickedFile.path);
      print(prodImage);
      emit(PickProdImgSuccessState());
    } else {
      print('No  Profile image selected.');
      emit(PickProdImgErrorState());
    }
  }

  void cancelImg() {
    prodImage = null;
    emit(CancelProdImgSuccessState());
  }

  AddProdModel? addProdModel;

  void postProdToDB({
    required String prodName,
    required double prodCurrentPrice,
    required double prodOLdPrice,
    required String prodDescription,
    int? count,
  }) {
    if (selectCat != null) {
      emit(PostProdToDBLoadingState());
      FirebaseStorage.instance
          .ref()
          .child(Uri.file(prodImage!.path).pathSegments.last)
          .putFile(prodImage!)
          .then((v) {
        v.ref.getDownloadURL().then((value) {
          addProdModel = AddProdModel(
            name: prodName,
            description: prodDescription,
            currentPrice: prodCurrentPrice,
            oldPrice: prodOLdPrice,
            prodImgUrl: value,
            inCart: false,
            inFav: false,
            count: count ?? 1,
          );
          FirebaseFirestore.instance
              .collection("products")
              .doc(selectCat)
              .collection(selectCat!)
              .add(addProdModel!.toMap())
              .then((value) {
            emit(PostProdToDBSuccessState());
          }).catchError((error) {
            emit(PostProdToDBErrorState());
          });
        });
      }).catchError((error) {
        emit(PostProdToDBErrorState());
      }).catchError((error) {
        emit(PostProdToDBErrorState());
      });
    }
  }

  void getCurrentUser() {
    emit(GetCurrentUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      registerModel = RegisterModel.fromJsom(value.data());
      emit(GetCurrentUserSuccessState());
    }).catchError((error) {
      emit(GetCurrentUserErrorState());
    });
  }

  List<AddProdModel> menClothesList = [];
  List<AddProdModel> menWatchesList = [];
  List<AddProdModel> womanClothesList = [];
  List<AddProdModel> womanWatchesList = [];
  List<AddProdModel> accessoriesList = [];
  List<AddProdModel> favProducts = [];
  List<AddProdModel> cartProducts = [];
  List<AddProdModel> newProducts = [];
  List<AddProdModel> allProducts = [];
  List<String> categories = [
    'men clothes',
    'men watches',
    'woman clothes',
    'woman watches',
    'Accessories',
  ]; // Option 2
  String? selectCat;

  void selectCategory(String value) {
    selectCat = value;
    emit(SelectCatSuccessState());
  }

  void getMenClothesCat() {
    emit(GetMenClothesCatLoadingState());
    FirebaseFirestore.instance
        .collection("products")
        .doc("men clothes")
        .collection("men clothes")
        .get()
        .then((value) {
      for (var element in value.docs) {
        menClothesList.add(AddProdModel.formJson(element.data()));
        allProducts.add(AddProdModel.formJson(element.data()));

        if (element.data()["inFav"] == true) {
          favProducts.add(AddProdModel.formJson(element.data()));
        }
        if (element.data()["inCart"] == true) {
          cartProducts.add(AddProdModel.formJson(element.data()));
        }
      }

      newProducts.add(AddProdModel.formJson(value.docs[0].data()));
      emit(GetMenClothesCatSuccessState());
    }).catchError((error) {
      emit(GetMenClothesCatErrorState());
    });
  }

  void getMenWatchesCat() {
    emit(GetMenWatchesCatLoadingState());
    FirebaseFirestore.instance
        .collection("products")
        .doc("men watches")
        .collection("men watches")
        .get()
        .then((value) {
      for (var element in value.docs) {
        menWatchesList.add(AddProdModel.formJson(element.data()));
        allProducts.add(AddProdModel.formJson(element.data()));

        if (element.data()["inFav"] == true) {
          favProducts.add(AddProdModel.formJson(element.data()));
        }
        if (element.data()["inCart"] == true) {
          cartProducts.add(AddProdModel.formJson(element.data()));
        }
      }
      newProducts.add(AddProdModel.formJson(value.docs[0].data()));
      emit(GetMenWatchesCatSuccessState());
    }).catchError((error) {
      emit(GetMenWatchesCatErrorState());
    });
  }

  void getWomanWatchesCat() {
    emit(GetWomanWatchesCatLoadingState());
    FirebaseFirestore.instance
        .collection("products")
        .doc(categories[3])
        .collection(categories[3])
        .get()
        .then((value) {
      for (var element in value.docs) {
        womanWatchesList.add(AddProdModel.formJson(element.data()));
        allProducts.add(AddProdModel.formJson(element.data()));

        if (element.data()["inFav"] == true) {
          favProducts.add(AddProdModel.formJson(element.data()));
        }
        if (element.data()["inCart"] == true) {
          cartProducts.add(AddProdModel.formJson(element.data()));
        }
      }

      newProducts.add(AddProdModel.formJson(value.docs[0].data()));

      emit(GetWomanWatchesCatSuccessState());
    }).catchError((error) {
      emit(GetWomanWatchesCatErrorState());
    });
  }

  void getWomanClothesCat() {
    emit(GetWomanClothesCatLoadingState());
    FirebaseFirestore.instance
        .collection("products")
        .doc("woman clothes")
        .collection("woman clothes")
        .get()
        .then((value) {
      for (var element in value.docs) {
        womanClothesList.add(AddProdModel.formJson(element.data()));
        allProducts.add(AddProdModel.formJson(element.data()));

        if (element.data()["inFav"] == true) {
          favProducts.add(AddProdModel.formJson(element.data()));
        }
        if (element.data()["inCart"] == true) {
          cartProducts.add(AddProdModel.formJson(element.data()));
        }
      }
      newProducts.add(AddProdModel.formJson(value.docs[0].data()));
      emit(GetWomanClothesCatSuccessState());
    }).catchError((error) {
      emit(GetWomanClothesCatErrorState());
    });
  }

  void getAccessoriesCat() {
    emit(GetAccessoriesCatLoadingState());
    FirebaseFirestore.instance
        .collection("products")
        .doc("Accessories")
        .collection("Accessories")
        .get()
        .then((value) {
      for (var element in value.docs) {
        accessoriesList.add(AddProdModel.formJson(element.data()));
        allProducts.add(AddProdModel.formJson(element.data()));

        if (element.data()["inFav"] == true) {
          favProducts.add(AddProdModel.formJson(element.data()));
        }
        if (element.data()["inCart"] == true) {
          cartProducts.add(AddProdModel.formJson(element.data()));
        }
      }
      newProducts.add(AddProdModel.formJson(value.docs[0].data()));
      emit(GetAccessoriesCatSuccessState());
    }).catchError((error) {
      emit(GetAccessoriesCatErrorState());
    });
  }

  int currentIndex = 0;

  List<Widget> screens = const [HomeScreen(), FavScreen(), CartScreen()];

  void changeIndex({required int value}) {
    currentIndex = value;
    emit(ChangeCurrentIndexSuccessState());
  }
}
