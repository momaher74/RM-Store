import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:buyall/screens/addproductscreen.dart';
import 'package:buyall/screens/catscreen.dart';
import 'package:buyall/screens/orderscreen.dart';
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
                  onPressed: () {
                    cubit.getOrders();
                    push(
                      context,
                      OrdersScreen(
                          products: cubit.orders,
                          title: "Orders",
                          productId: cubit.ordersId),
                    );
                  },
                  icon: const Icon(
                    Icons.reorder,
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
              physics: const BouncingScrollPhysics(),
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
                      controller: cubit.valueController,
                      onChanged: (String value) {
                        cubit.homeSearchResults = [];
                        cubit.homeSearch(value: value);
                      },
                      onFieldSubmitted: (String value) {
                        cubit.homeSearchResults = [];
                        cubit.homeSearch(value: value);
                      },
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
                  if (state is HomeSearchLoadingState &&
                      cubit.homeSearchResults.isEmpty)
                    SizedBox(
                      height: height * .05,
                    ),
                  if (state is HomeSearchLoadingState &&
                      cubit.homeSearchResults.isEmpty)
                    const LinearProgressIndicator(),
                  SizedBox(
                    height: height * .05,
                  ),
                  if (cubit.homeSearchResults.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          str: "Category",
                          size: width * .035,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: height * .025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                push(
                                    context,
                                    CategoryScreen(
                                      title: 'Woman clothes',
                                      products: cubit.womanClothesList,
                                      productId: cubit.womanClothesListId,
                                    ));
                              },
                              child: Container(
                                width: width * .15,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 3),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/dress.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                push(
                                    context,
                                    CategoryScreen(
                                      title: 'Woman watches',
                                      products: cubit.womanWatchesList,
                                      productId: cubit.womanWatchesListId,
                                    ));
                              },
                              child: Container(
                                width: width * .15,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/womanwatch.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                push(
                                    context,
                                    CategoryScreen(
                                      title: 'Men clothes',
                                      products: cubit.menClothesList,
                                      productId: cubit.menClothesListId,
                                    ));
                              },
                              child: Container(
                                width: width * .15,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 3),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/shirt.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                push(
                                    context,
                                    CategoryScreen(
                                      title: 'Men watches',
                                      products: cubit.menWatchesList,
                                      productId: cubit.menWatchesListId,
                                    ));
                              },
                              child: Container(
                                width: width * .15,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 3),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/watch.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                push(
                                    context,
                                    CategoryScreen(
                                      title: 'Accessories',
                                      products: cubit.accessoriesList,
                                      productId: cubit.accessoriesListId,
                                    ));
                              },
                              child: Container(
                                width: width * .15,
                                height: height * .08,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 3),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/cole.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (cubit.homeSearchResults.isEmpty)
                    SizedBox(
                      height: height * .05,
                    ),
                  if (state is! HomeSearchLoadingState ||
                      cubit.homeSearchResults.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          str: "New Products",
                          size: width * .035,
                          fontWeight: FontWeight.w600,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: NetworkImage(cubit
                                              .newProducts[index].prodImgUrl!),
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
                                          str: cubit
                                              .newProducts[index].currentPrice!
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
                        if (cubit.newProducts.isEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          ),
                        SizedBox(
                          height: height * .05,
                        ),
                        MyText(
                          str: "All Products",
                          size: width * .035,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        if (cubit.allProducts.isNotEmpty)
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.allProducts.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .58,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              var prod = cubit.allProducts[index];
                              String prodId = cubit.allProductsId[index];
                              return ProductWidget(
                                favFunction: () {
                                  cubit.aadProductToFav(
                                    name: prod.name!,
                                    currentPrice: prod.currentPrice!,
                                    oldPrice: prod.oldPrice!,
                                    prodImgUrl: prod.prodImgUrl!,
                                    prodId: prodId,
                                    description: prod.description!,
                                  );
                                },
                                cartFunction: () {
                                  cubit.aadProductToCart(
                                    name: prod.name!,
                                    currentPrice: prod.currentPrice!,
                                    prodImgUrl: prod.prodImgUrl!,
                                    prodId: prodId,
                                    counter: 1,
                                  );
                                },
                                productDescription: prod.description!,
                                productName: prod.name!,
                                imgUrl: prod.prodImgUrl!,
                                width: width,
                                height: height,
                                price: prod.currentPrice.toString(),
                                oldPrice: prod.oldPrice.toString(),
                                prodId: prodId,
                              );
                            },
                          ),
                        if (cubit.allProducts.isEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          )
                      ],
                    ),
                  if (cubit.homeSearchResults.isNotEmpty)
                    ListView.builder(
                      itemBuilder: (context, int index) {
                        var prod = cubit.homeSearchResults[index];
                        return Container(
                          margin: EdgeInsets.all(width * .025),
                          padding: EdgeInsets.all(width * .025),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * .025),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * .3,
                                    height: height * .15,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(prod.prodImgUrl!),
                                      ),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(width * .05),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .03,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: MyText(
                                              str: prod.name!,
                                              size: width * .04,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            width: width * .3,
                                          ),
                                          SizedBox(
                                            width: width * .02,
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: width * .15,
                                                child: MyText(
                                                  str:
                                                      "${prod.currentPrice} LE",
                                                  size: width * .03,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              SizedBox(
                                                height: width * .005,
                                              ),
                                              SizedBox(
                                                width: width * .15,
                                                child: Text(
                                                  "${prod.oldPrice} LE",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * .022,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * .03,
                                      ),
                                      SizedBox(
                                        width: width * .4,
                                        child: Text(
                                          prod.description!,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: width * .022,
                                            // decoration: TextDecoration.lineThrough,
                                          ),
                                          maxLines: 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MyElevatedButton(
                                    onPressed: () {
                                      // showOrderDialog(id: prodId, prod: prod);
                                    },
                                    widget: const MyText(
                                      str: "Order",
                                      color: Colors.white,
                                    ),
                                    width: width * .65,
                                    height: height * .06,
                                    color: Colors.black,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // cubit.aadProductToCart(
                                      //   name: prod.name!,
                                      //   currentPrice: prod.currentPrice!,
                                      //   prodImgUrl: prod.prodImgUrl!,
                                      //   prodId: "",
                                      //   counter: 1,
                                      // );
                                    },
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: width * .075,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey,
                                      shadowColor: Colors.red,
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.all(
                                        width * .02,
                                      ),
                                      // ,// <-- SEE HERE
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: cubit.homeSearchResults.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                    ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddToCartErrorState || state is AddToFavErrorState) {
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
              size: 13,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }

        if (state is AddToFavSuccessState) {
          var snackBar = const SnackBar(
            backgroundColor: Colors.green,
            content: MyText(
              str: "Added in Favourites Successfully ",
              size: 13,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }

        if (state is ProductExistInCartState) {
          var snackBar = const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: MyText(
              str: "Product is already in Your Cart ",
              size: 12,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }

        if (state is ProductExistInFavState) {
          var snackBar = const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: MyText(
              str: "Product is already in Your Favourites ",
              size: 12,
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
