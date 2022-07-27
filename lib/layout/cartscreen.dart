import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:buyall/componant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);
    Future<void> _showMyDialog({required String id}) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure ?'),
            // title: const Text('Are you sure ?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('yes'),
                onPressed: () {
                  cubit.deleteCartProduct(id: id);
                  Navigator.of(context).pop();


                },
              ),
            ],
          );
        },
      );
    }
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: HexColor("#EBEAEF"),
          appBar: AppBar(
            leading: const Icon(Icons.shopping_cart),
            title: const MyText(
              str: 'Cart',
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: HexColor("#EBEAEF"),
          ),
          body: cubit.cartProducts.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    var prod = cubit.cartProducts[index];
                    String prodId = cubit.cartProductsId[index];
                    return Stack(
                      alignment: const Alignment(.96, -.94),
                      children: [
                        Container(
                          margin: EdgeInsets.all(width * .025),
                          padding: EdgeInsets.all(width * .025),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * .025),
                          ),
                          child: Column(
                            children: [
                              Row(
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                            width: width * .06,
                                          ),
                                          SizedBox(
                                            width: width * .15,
                                            child: MyText(
                                              str:
                                                  prod.currentPrice!.toString(),
                                              size: width * .03,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * .03,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(width * .01),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              width * .1,
                                            ),
                                            border: Border.all(
                                              color: Colors.black,
                                            )),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                if (cubit.x > 1) {
                                                  cubit.decrementX();
                                                }
                                              },
                                              child: Icon(
                                                //<-- SEE HERE
                                                Icons.exposure_minus_1,
                                                color: Colors.black,
                                                size: width * .05,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  shadowColor: Colors.red,
                                                  shape: const CircleBorder(),
                                                  padding: EdgeInsets.all(
                                                      width * .02)
                                                  // ,// <-- SEE HERE
                                                  ),
                                            ),
                                            SizedBox(
                                              width: width * .02,
                                            ),
                                            MyText(str: cubit.x.toString()),
                                            SizedBox(
                                              width: width * .02,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                cubit.incrementX();
                                              },
                                              child: Icon(
                                                //<-- SEE HERE
                                                Icons.exposure_plus_1_outlined,
                                                color: Colors.white,
                                                size: width * .05,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black,
                                                  shadowColor: Colors.red,
                                                  shape: const CircleBorder(),
                                                  padding: EdgeInsets.all(
                                                      width * .02)
                                                  // ,// <-- SEE HERE
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              MyElevatedButton(
                                onPressed: () {},
                                widget: const MyText(
                                  str: "Order",
                                  color: Colors.white,
                                ),
                                width: width * .8,
                                height: height * .07,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              _showMyDialog(id: prodId);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.black,
                              size: width * .06,
                            ))
                      ],
                    );
                  },
                  itemCount: cubit.cartProducts.length,
                  shrinkWrap: true,
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                )),
        );
      },
      listener: (context, state) {},
    );
  }
}
