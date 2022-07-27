import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailedProductScreen extends StatelessWidget {
  DetailedProductScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.oldPrice,
  }) : super(key: key);

  String price, name, description, imgUrl, oldPrice;

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
            title: MyText(
              str: name,
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * .01,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: width * .8,
                          height: height * .5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imgUrl),
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(width * .06),
                              topLeft: Radius.circular(width * .06),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(
                            //<-- SEE HERE
                            Icons.favorite,
                            color: Colors.white,
                            size: width * .05,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shadowColor: Colors.red,
                              shape: const CircleBorder(),
                              padding: EdgeInsets.all(width * .02)
                              // ,// <-- SEE HERE
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .42,
                    ),
                  ],
                ),
                Container(
                  width: width,
                  height: height * .4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(width * .1),
                      topLeft: Radius.circular(width * .1),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * .04),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .02,
                          ),
                          MyText(
                            str: name,
                            size: width * .045,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: height * .015,
                          ),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: width * .03,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          SizedBox(
                            width: width * .8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      str: "$price LE",
                                      size: width * .05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    Text("$oldPrice LE",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: width * .05,
                                            decoration:
                                                TextDecoration.lineThrough))
                                  ],
                                ),
                                Spacer(),
                                // Container(
                                //   padding: EdgeInsets.all(width * .01),
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius:
                                //           BorderRadius.circular(width * .1),
                                //       border: Border.all(
                                //         color: Colors.black,
                                //       )),
                                //   child: Row(
                                //     children: [
                                //       ElevatedButton(
                                //         onPressed: () {
                                //           if (cubit.x > 1) {
                                //             cubit.decrementX();
                                //           }
                                //         },
                                //         child: Icon(
                                //           //<-- SEE HERE
                                //           Icons.exposure_minus_1,
                                //           color: Colors.black,
                                //           size: width * .05,
                                //         ),
                                //         style: ElevatedButton.styleFrom(
                                //             primary: Colors.white,
                                //             shadowColor: Colors.red,
                                //             shape: const CircleBorder(),
                                //             padding: EdgeInsets.all(width * .02)
                                //             // ,// <-- SEE HERE
                                //             ),
                                //       ),
                                //       SizedBox(
                                //         width: width * .02,
                                //       ),
                                //       MyText(str: cubit.x.toString()),
                                //       SizedBox(
                                //         width: width * .02,
                                //       ),
                                //       ElevatedButton(
                                //         onPressed: () {
                                //           cubit.incrementX();
                                //         },
                                //         child: Icon(
                                //           //<-- SEE HERE
                                //           Icons.exposure_plus_1_outlined,
                                //           color: Colors.white,
                                //           size: width * .05,
                                //         ),
                                //         style: ElevatedButton.styleFrom(
                                //             primary: Colors.black,
                                //             shadowColor: Colors.red,
                                //             shape: const CircleBorder(),
                                //             padding: EdgeInsets.all(width * .02)
                                //             // ,// <-- SEE HERE
                                //             ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.aadProductToCart(
                                      currentPrice: double.parse(price),
                                      name: name,
                                      prodImgUrl: imgUrl,
                                    );
                                  },
                                  child: Icon(
                                    //<-- SEE HERE
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: width * .07,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      shadowColor: Colors.red,
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.all(width * .02)
                                      // ,// <-- SEE HERE
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * .08,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
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
          var snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: MyText(
              str: "$name is Added in Cart Successfully ",
              size: 15,
              color: Colors.white,
            ),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }
      },
    );
  }
}
