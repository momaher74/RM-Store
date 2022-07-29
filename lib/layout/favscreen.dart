import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:buyall/models/favmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
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
    Future<void> showOrderDialog(
        {required String id, required FavModel prod}) async {
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
                  cubit.makeOrderFromFav(
                    name: prod.name!,
                    currentPrice: prod.currentPrice!,
                    prodImgUrl: prod.prodImgUrl!,
                    count: int.parse(amount.text),
                    orderDate: formattedOrderDate,
                    receiveDate: formattedReceiveDate,
                    id: id,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
                  cubit.deleteFavProduct(id: id);
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
            title: const MyText(
              str: 'Favourites',
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: HexColor("#EBEAEF"),
          ),
          body: cubit.favProducts.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var prod = cubit.favProducts[index];
                    String prodId = cubit.favProductsId[index];
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * .15,
                                            child: MyText(
                                              str: "${prod.currentPrice} LE",
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
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                        ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyElevatedButton(
                                onPressed: () {
                                  showOrderDialog(id: prodId, prod: prod);
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
                                  cubit.aadProductToCart(
                                    name: prod.name!,
                                    currentPrice: prod.currentPrice!,
                                    prodImgUrl: prod.prodImgUrl!,
                                    prodId: prodId,
                                    counter: 1,
                                  );
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
                  itemCount: cubit.favProducts.length,
                  shrinkWrap: true,
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                )),
        );
      },
      listener: (context, state) {
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
