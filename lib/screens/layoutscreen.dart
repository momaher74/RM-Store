import 'package:buyall/bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.black,
            backgroundColor: HexColor("#EBEAEF"),
            onTap: (value) {
              if (value == 2) {
                cubit.getCartProducts();
              }
              if (value == 1) {
                cubit.getFavProducts();
              }
              if (value == 0) {
                cubit.homeSearchResults=[];
                cubit.valueController.clear();
              }
              cubit.changeIndex(value: value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: width * .05,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: width * .05,
                  ),
                  label: "Favourite"),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  size: width * .05,
                ),
                label: "Cart",
              ),
              // BottomNavigationBarItem(icon: Icon(Icons.settings ,size: width*.05,),label: "setting" ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
