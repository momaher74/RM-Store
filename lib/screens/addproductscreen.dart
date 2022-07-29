import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreens extends StatelessWidget {
  const AddProductScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var cubit = AppCubit.get(context);
    var prodNameController = TextEditingController();
    var prodDescriptionController = TextEditingController();
    var prodCurrentPriceController = TextEditingController();
    var prodOldPriceController = TextEditingController();
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const MyText(str: "Add Product"),
          ),
          body: Padding(
            padding: EdgeInsets.all(width * .05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * .1,
                  ),
                  DropdownButton(
                    hint: Text(
                      'choose category for product',
                      style:
                          TextStyle(fontSize: width * .03, color: Colors.black),
                    ),
                    // Not necessary for Option 1
                    value: cubit.selectCat,
                    onChanged: (String? value) {
                      cubit.selectCategory(value!);
                    },
                    items: cubit.categories.map((location) {
                      return DropdownMenuItem(
                        child: Text(
                          location,
                          style: TextStyle(
                              fontSize: width * .03, color: Colors.blue),
                        ),
                        value: location,
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  SizedBox(
                    height: height * .06,
                    width: width * .9,
                    child: TextFormField(
                      controller: prodNameController,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.production_quantity_limits),
                        label: MyText(
                          str: 'product name',
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
                  SizedBox(
                    height: height * .03,
                  ),
                  SizedBox(
                    height: height * .13,
                    width: width * .9,
                    child: TextFormField(
                      maxLines: 6,
                      minLines: 3,
                      enableSuggestions: true,
                      controller: prodDescriptionController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.library_books_sharp),
                        label: MyText(
                          str: 'product description',
                          size: width * .028,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * .02),
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
                  SizedBox(
                    height: height * .06,
                    width: width * .9,
                    child: TextFormField(
                      controller: prodCurrentPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.money_off),
                        label: MyText(
                          str: 'product Current Price',
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
                  SizedBox(
                    height: height * .03,
                  ),
                  SizedBox(
                    height: height * .06,
                    width: width * .9,
                    child: TextFormField(
                      controller: prodOldPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.money_off),
                        label: MyText(
                          str: 'product Old Price',
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
                  SizedBox(
                    height: height * .05,
                  ),
                  if (cubit.prodImage == null)
                    MyElevatedButton(
                      onPressed: () {
                        cubit.pickProductImage();
                      },
                      widget: const Icon(Icons.image),
                      width: width * .85,
                      height: height * .06,
                      color: Colors.deepPurple,
                    ),
                  SizedBox(
                    height: height * .03,
                  ),
                  if (cubit.prodImage != null)
                    GestureDetector(
                      onTap: () {
                        if (state is! PostProdToDBLoadingState) {
                          cubit.cancelImg();
                        }
                      },
                      child: Image(
                        image: FileImage(
                          cubit.prodImage!,
                        ),
                        width: width * .5,
                        height: height * .3,
                      ),
                    ),
                  if (cubit.prodImage != null)
                    SizedBox(
                      height: height * .03,
                    ),
                  if (cubit.prodImage != null &&
                      state is! PostProdToDBLoadingState)
                    MyElevatedButton(
                      onPressed: () {
                        cubit.postProdToDB(
                          prodName: prodNameController.text,
                          prodCurrentPrice: double.parse(
                            prodCurrentPriceController.text,
                          ),
                          prodOLdPrice: double.parse(
                            prodOldPriceController.text,
                          ),
                          prodDescription: prodDescriptionController.text,
                        );
                      },
                      widget: const MyText(
                        str: "Add Product",
                        color: Colors.white,
                      ),
                      width: width * .85,
                      height: height * .06,
                      color: Colors.deepPurple,
                    ),
                  if (state is PostProdToDBLoadingState)
                    MyCircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is PostProdToDBSuccessState) {
          prodCurrentPriceController.clear();
          prodDescriptionController.clear();
          prodNameController.clear();
          prodOldPriceController.clear();
          cubit.cancelImg();
          var snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: MyText(
              str: "product added successfully",
              size: width * .02,
              color: Colors.white,
            ),
            duration: const Duration(
              seconds: 2,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }
        if (state is PostProdToDBErrorState) {
          prodCurrentPriceController.clear();
          prodDescriptionController.clear();
          prodNameController.clear();
          cubit.cancelImg();
          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "sorry error was happened",
              style: TextStyle(
                color: Colors.white,
                fontSize: width * .02,
              ),
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
