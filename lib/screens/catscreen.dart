import 'package:buyall/bloc/app_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../componant/componant.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({
    Key? key,
    required this.products,
    required this.title,
  }) : super(key: key);
  List products = [];
  String? title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: MyText(str: title!,fontWeight: FontWeight.w400,),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, int index) {
                    var prod = products[index];
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
                                  // showOrderDialog(id: prodId, prod: prod);
                                },
                                widget: const MyText(
                                  str: "Order",
                                  color: Colors.white,
                                ),
                                width: width * .55,
                                height: height * .06,
                                color: Colors.black,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cubit.aadProductToCart(
                                    name: prod.name!,
                                    currentPrice: prod.currentPrice!,
                                    prodImgUrl: prod.prodImgUrl!,
                                    prodId: "",
                                    counter: 1,
                                  );
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: width * .05,
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
                              ElevatedButton(
                                onPressed: () {
                                  cubit.aadProductToCart(
                                    name: prod.name!,
                                    currentPrice: prod.currentPrice!,
                                    prodImgUrl: prod.prodImgUrl!,
                                    prodId: "",
                                    counter: 1,
                                  );
                                },
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: width * .055,
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
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
