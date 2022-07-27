import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:buyall/screens/addproductscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: HexColor("#EBEAEF"),
          appBar: AppBar(
            backgroundColor: HexColor("#EBEAEF"),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.list,
                color: Colors.black,
              ),
            ),
            title: const MyText(
              str: "RM Store",
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                  )),
              SizedBox(
                width: width * .025,
              ),
              IconButton(
                  onPressed: () {
                    push(context, const AddProductScreens());
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                  )),
              SizedBox(
                width: width * .025,
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(width * .05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  SizedBox(
                    height: height * .06,
                    width: width * .9,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        label: const MyText(
                          str: 'Search',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * .03),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * .02),
                          borderSide: const BorderSide(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        str: "New Products",
                        size: width * .035,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  if (cubit.newProducts.isNotEmpty)
                    SizedBox(
                      width: width * .9,
                      height: height * .32,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: width * .3,
                            height: height * .3,
                            child: Card(
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        cubit.newProducts[index].prodImgUrl!),
                                    width: width * .3,
                                    height: height * .25,
                                  ),
                                  SizedBox(
                                    width: width * .22,
                                    child: MyText(
                                      str: cubit.newProducts[index].name!,
                                      size: width * .032,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  MyText(
                                    str: cubit.newProducts[index].currentPrice!
                                        .toString(),
                                    size: width * .03,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: cubit.newProducts.length,
                      ),
                    ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        str: "Category",
                        size: width * .035,
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: height * .025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: width * .15,
                        height: height * .08,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/dress.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width * .15,
                        height: height * .08,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/shirt.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width * .15,
                        height: height * .08,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/shoes.png',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width * .15,
                        height: height * .08,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/tie.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        str: "All Products",
                        size: width * .035,
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: MyText(
                      //     str: "See All",
                      //     size: width * .03,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: width * .03,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.allProducts.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .58,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      var prod = cubit.allProducts[index];
                      return ProductWidget(
                        favFunction: () {
                          print("FAVVVVVVVVVVVVVV Fun");
                        },
                        cartFunction: () {
                          cubit.aadProductToCart(
                            name: prod.name!,
                            currentPrice: prod.currentPrice!,
                            prodImgUrl: prod.prodImgUrl!,
                          );
                        },
                        productDescription: prod.description!,
                        productName: prod.name!,
                        imgUrl: prod.prodImgUrl!,
                        width: width,
                        height: height,
                        price: prod.currentPrice.toString(),
                        oldPrice: prod.oldPrice.toString(),

                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddToCartErrorState) {
          var snackBar = const SnackBar(
            backgroundColor: Colors.red,
            content: MyText(
              str: "Sorry there is error, try again ",
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }
        if (state is AddToCartSuccessState) {
          var snackBar = const SnackBar(
            backgroundColor: Colors.green,
            content: MyText(
              str: "Added in Cart Successfully ",
              size: 15,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }
      },
    );
  }
}
