import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/models/ordermodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../componant/componant.dart';
import '../models/addproductmodel.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({
    Key? key,
    required this.products,
    required this.title,
    required this.productId,
  }) : super(key: key);
  List<OrderModel> products = [];
  List<String> productId = [];
  String? title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);
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
            backgroundColor: HexColor("#EBEAEF"),
            title: MyText(
              str: title!,
              fontWeight: FontWeight.w400,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * .01,
                ),
                if (cubit.orders.isNotEmpty)
                  ListView.builder(
                    itemBuilder: (context, int index) {
                      var prod = products[index];
                      String prodId = productId[index];
                      return Container(
                        margin: EdgeInsets.all(width * .025),
                        padding: EdgeInsets.all(width * .025),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * .025),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    SizedBox(
                                      child: MyText(
                                        str: prod.name!,
                                        size: width * .04,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      width: width * .45,
                                    ),
                                    SizedBox(
                                      height: width * .02,
                                    ),
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
                                      height: width * .02,
                                    ),
                                    SizedBox(
                                      width: width * .35,
                                      child: MyText(
                                        str: "Items count = ${prod.count}",
                                        size: width * .03,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    MyText(
                                      str: "Ordered on ${prod.orderDate}",
                                      size: width * .025,
                                      color: Colors.grey[800],
                                    ),
                                    SizedBox(
                                      height: height * .005,
                                    ),
                                    MyText(
                                      str: "Relieve on ${prod.receiveDate}",
                                      size: width * .025,
                                      color: Colors.grey[800],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .03,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                  ),
                if (cubit.orders.isEmpty)
                  const Center(child: LinearProgressIndicator())
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
