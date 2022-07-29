import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);
    Future<void> showMyDialog({required String id}) async {
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

    DateTime orderDate = DateTime.now();
    DateTime receiveDate = orderDate.add(const Duration(
      days: 7,
    ));
    String formattedOrderDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(orderDate);
    String formattedReceiveDate = DateFormat('yyyy-MM-dd').format(receiveDate);
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
                  physics: const BouncingScrollPhysics(),
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
                                    width: width * .02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                width: width * .15,
                                                child: MyText(
                                                  str:
                                                      "${prod.currentPrice} LE",
                                                  size: width * .03,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  showMyDialog(id: prodId);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.black,
                                                  size: width * .045,
                                                ),
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                          ),
                                          SizedBox(
                                            height: height * .03,
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.all(width * .01),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  width * .1,
                                                ),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (prod.counter > 1) {
                                                      setState(() {
                                                        prod.counter--;
                                                      });
                                                    }
                                                  },
                                                  child: Icon(
                                                    //<-- SEE HERE
                                                    Icons.exposure_minus_1,
                                                    color: Colors.black,
                                                    size: width * .05,
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                    shadowColor: Colors.red,
                                                    shape: const CircleBorder(),
                                                    padding: EdgeInsets.all(
                                                      width * .02,
                                                    ),
                                                    // ,// <-- SEE HERE
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * .02,
                                                ),
                                                MyText(
                                                  str: "${prod.counter}",
                                                ),
                                                SizedBox(
                                                  width: width * .02,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      prod.counter++;
                                                    });
                                                  },
                                                  child: Icon(
                                                    //<-- SEE HERE
                                                    Icons
                                                        .exposure_plus_1_outlined,
                                                    color: Colors.white,
                                                    size: width * .05,
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.black,
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
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              MyElevatedButton(
                                onPressed: () {
                                  cubit.makeOrderFromCart(
                                    name: prod.name!,
                                    currentPrice: prod.currentPrice!,
                                    prodImgUrl: prod.prodImgUrl!,
                                    count: prod.counter,
                                    orderDate: formattedOrderDate,
                                    receiveDate: formattedReceiveDate,
                                    id: prodId,
                                  );
                                },
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
      listener: (context, state) {
        if (state is MakeOrderSuccessState) {
          var snackBar = const SnackBar(
            backgroundColor: Colors.green,
            content: MyText(
              str: "Product ordered Successfully",
              size: 13,
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
