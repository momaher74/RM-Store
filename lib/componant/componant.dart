import 'package:flutter/material.dart';

import '../screens/detailproductscreen.dart';

push(context, screen) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

pushReplacement(context, screen) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

class MyHeightSizedBox extends StatelessWidget {
  double? x;

  MyHeightSizedBox({required this.x});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: x,
    );
  }
}

class MyWidthSizedBox extends StatelessWidget {
  double? x;

  MyWidthSizedBox({required this.x});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: x,
    );
  }
}

class MyElevetedButton extends StatelessWidget {
  double? height;
  double? width;
  Color color;
  Function function;

  Widget widget;

  MyElevetedButton({
    this.height,
    this.width,
    required this.color,
    required this.widget,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: () {
          function();
        },
        child: widget,
      ),
    );
  }
}

class MyCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.deepPurple,
    ));
  }
}

class MyText extends StatelessWidget {
  final String str;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;

  const MyText({
    Key? key,
    required this.str,
    this.color,
    this.size,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 18,
          fontWeight: fontWeight ?? FontWeight.normal,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  Function onPressed;
  Widget widget;
  Color color;

  final double width, height;

  MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.widget,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        onPressed: () {
          onPressed();
        },
        child: widget,
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  ProductWidget({
    Key? key,
    required this.productDescription,
    required this.productName,
    required this.imgUrl,
    required this.width,
    required this.height,
    required this.price,
    required this.oldPrice,
    required this.cartFunction,
    required this.favFunction,
    required this.prodId,
  }) : super(key: key);
  double height, width;
  String prodId, imgUrl, productName, productDescription, price, oldPrice;
  Function favFunction, cartFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .44,
      width: width * .3,
      padding: EdgeInsets.all(width * .02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * .02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              push(
                context,
                DetailedProductScreen(
                  description: productDescription,
                  name: productName,
                  imgUrl: imgUrl,
                  price: price,
                  oldPrice: oldPrice,
                  prodId: prodId,
                ),
              );
            },
            child: Image(
              image: NetworkImage(imgUrl),
              width: width * .4,
              height: height * .2,
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          MyText(
            str: productName,
            size: width * .03,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: height * .01,
          ),
          MyText(
            str: productDescription,
            size: width * .02,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            children: [
              MyText(
                str: "$price LE",
                size: width * .03,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  favFunction();
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
            height: height * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  cartFunction();
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: width * .05,
                ),
                style: ElevatedButton.styleFrom(
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
        ],
      ),
    );
  }
}
