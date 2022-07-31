part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ChangeVisibleSuccessState extends AppState {}

class ChangeConfirmVisibleSuccessState extends AppState {}

class WrongAmountState extends AppState {}

class RememberUser extends AppState {}

class ChangeCurrentIndexSuccessState extends AppState {}

class RegisterLoadingState extends AppState {}

class RegisterSuccessState extends AppState {}

class RegisterErrorState extends AppState {}

class SignLoadingState extends AppState {}

class SignSuccessState extends AppState {}

class SignErrorState extends AppState {}

class SaveUidLoadingState extends AppState {}

class SaveUidSuccessState extends AppState {}

class SaveUidErrorState extends AppState {}

class PickProdImgSuccessState extends AppState {}

class PickProdImgErrorState extends AppState {}

class CancelProdImgSuccessState extends AppState {}

class SelectCatSuccessState extends AppState {}

class PostProdToDBLoadingState extends AppState {}

class PostProdToDBSuccessState extends AppState {}

class PostProdToDBErrorState extends AppState {}

class GetCurrentUserLoadingState extends AppState {}

class GetCurrentUserSuccessState extends AppState {}

class GetCurrentUserErrorState extends AppState {}

class GetMenClothesCatLoadingState extends AppState {}

class GetMenClothesCatSuccessState extends AppState {}

class GetMenClothesCatErrorState extends AppState {}

class GetMenWatchesCatLoadingState extends AppState {}

class GetMenWatchesCatSuccessState extends AppState {}

class GetMenWatchesCatErrorState extends AppState {}

class GetWomanClothesCatLoadingState extends AppState {}

class GetWomanClothesCatSuccessState extends AppState {}

class GetWomanClothesCatErrorState extends AppState {}

class GetWomanWatchesCatLoadingState extends AppState {}

class GetWomanWatchesCatSuccessState extends AppState {}

class GetWomanWatchesCatErrorState extends AppState {}

class GetAccessoriesCatLoadingState extends AppState {}

class GetAccessoriesCatSuccessState extends AppState {}

class GetAccessoriesCatErrorState extends AppState {}

class AddToCartLoadingState extends AppState {}

class AddToCartSuccessState extends AppState {}

class AddToCartErrorState extends AppState {}

class AddToFavLoadingState extends AppState {}

class AddToFavSuccessState extends AppState {}

class AddToFavErrorState extends AppState {}

class GetCartLoadingState extends AppState {}

class GetCartSuccessState extends AppState {}

class GetCartErrorState extends AppState {}

class GetFavLoadingState extends AppState {}

class GetFavSuccessState extends AppState {}

class GetFavErrorState extends AppState {}

class GetOrdersLoadingState extends AppState {}

class GetOrdersSuccessState extends AppState {}

class GetOrdersErrorState extends AppState {}

class DeleteProdFromCartLoadingState extends AppState {}

class DeleteProdFromCartSuccessState extends AppState {}

class DeleteProdFromCartErrorState extends AppState {}

class DeleteProdFromFavLoadingState extends AppState {}

class DeleteProdFromFavSuccessState extends AppState {}

class DeleteProdFromFavErrorState extends AppState {}

class MakeOrderLoadingState extends AppState {}

class MakeOrderSuccessState extends AppState {}

class MakeOrderErrorState extends AppState {}

class ProductExistInCartState extends AppState {}

class ProductExistInFavState extends AppState {}

class HomeSearchLoadingState extends AppState {}

class HomeSearchSuccessState extends AppState {}

class HomeSearchErrorState extends AppState {}
