import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class DetailedProductScreen extends StatelessWidget {
  DetailedProductScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.oldPrice,
    required this.prodId,
  }) : super(key: key);

  String price, name, description, imgUrl, oldPrice, prodId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);
    var amount = TextEditingController();
    DateTime orderDate = DateTime.now();
    DateTime receiveDate = orderDate.add(const Duration(
      days: 7,
    ));
    String formattedOrderDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(orderDate);
    String formattedReceiveDate = DateFormat('yyyy-MM-dd').format(receiveDate);
    Future<void> showOrderDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure ?'),
            // title: const Text('Are you sure ?'),
            content: SizedBox(
              height: height * .06,
              width: width * .9,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: amount,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.production_quantity_limits),
                  label: MyText(
                    str: 'product amount',
                    size: width * .028,
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

            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Order'),
                onPressed: () {
                  cubit.makeOrder(
                    name: name,
                    currentPrice: double.parse(price),
                    prodImgUrl: imgUrl,
                    count: int.parse(amount.text),
                    orderDate: formattedOrderDate,
                    receiveDate: formattedReceiveDate,
                  );
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
            backgroundColor: HexColor("#EBEAEF"),
            title: MyText(
              str: name,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                          width: width * .92,
                          height: height * .36,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imgUrl),
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(width * .02),
                              topLeft: Radius.circular(width * .02),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cubit.aadProductToFav(
                              name: name,
                              currentPrice: double.parse(price),
                              oldPrice: double.parse(oldPrice),
                              prodImgUrl: imgUrl,
                              prodId: prodId,
                              description: description,
                            );
                          },
                          child: Icon(
                            //<-- SEE HERE
                            Icons.favorite,
                            color: Colors.white,
                            size: width * .05,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey,
                              shadowColor: Colors.red,
                              shape: const CircleBorder(),
                              padding: EdgeInsets.all(width * .02)
                              // ,// <-- SEE HERE
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .58,
                    ),
                  ],
                ),
                Container(
                  width: width,
                  height: height * .4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(width * .06),
                      topLeft: Radius.circular(width * .06),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyText(
                                      str: "$price LE",
                                      size: width * .05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    Text(
                                      "$oldPrice LE",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: width * .035,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.aadProductToCart(
                                      currentPrice: double.parse(price),
                                      name: name,
                                      prodImgUrl: imgUrl,
                                      prodId: prodId,
                                      counter: 1,
                                    );
                                  },
                                  child: Icon(
                                    //<-- SEE HERE
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: width * .07,
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
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          MyElevatedButton(
                            onPressed: () {
                              showOrderDialog();
                            },
                            widget: const MyText(
                              str: "Order",
                              color: Colors.white,
                            ),
                            width: width * .8,
                            height: height * .06,
                            color: Colors.black,
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
        if (state is WrongAmountState) {
          var snackBar = const SnackBar(
            backgroundColor: Colors.red,
            content: MyText(
              str: "  enter correct amount ,please",
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
