import 'package:buyall/componant/constant.dart';
import 'package:buyall/layout/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../bloc/app_cubit.dart';
import '../componant/componant.dart';
import '../style/colors.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        // var height = size.height;
        var width = size.width;
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(backgroundColor: themeColor,elevation: 0,),
          backgroundColor: themeColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: formKey,
                  child: Container(
                    width: double.infinity,
                    color: themeColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: width * .1,
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * .08),
                          child: Column(
                            children: [
                              // TextLogo(
                              //   width: width,
                              //   height: height,
                              // ),
                              // SizedBox(
                              //   height: width * .1,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Create new account ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: width * .05,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(width * .1),
                                topLeft: Radius.circular(width * .1)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(width * .1),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter name here ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: fNameController,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                width * .04)),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2.0),
                                          borderRadius: BorderRadius.circular(
                                              width * .04),
                                        ),
                                        labelText: 'first name',
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    height: width * .15,
                                    width: width * .35,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter name here ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: lNameController,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                width * .04)),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 2.0),
                                          borderRadius: BorderRadius.circular(
                                              width * .04),
                                        ),
                                        labelText: 'last name',
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    height: width * .15,
                                    width: width * .35,
                                  ),
                                ],
                              ),
                              MyHeightSizedBox(x: width * .05),
                              TextFormField(
                                cursorColor: Colors.black,
                                validator: (value) {
                                  if (!value!.contains('@')) {
                                    return 'your email should have @ ';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(width * .04)),
                                  labelText: "email",
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius:
                                        BorderRadius.circular(width * .04),
                                  ),
                                ),
                              ),
                              MyHeightSizedBox(x: width * .05),
                              TextFormField(
                                cursorColor: Colors.black,
                                obscureText: AppCubit.get(context).visible,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'your password should be 6 letters or more ';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: passwordController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(width * .04),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius:
                                        BorderRadius.circular(width * .04),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      AppCubit.get(context).changeVisible();
                                    },
                                    child: Icon(
                                      AppCubit.get(context).visible == false
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelText: 'password',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                              MyHeightSizedBox(x: width * .05),
                              TextFormField(
                                cursorColor: Colors.black,
                                obscureText:
                                    AppCubit.get(context).confirmVisible,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'your password should be 6 letters or more ';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(width * .04),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius:
                                        BorderRadius.circular(width * .04),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      AppCubit.get(context)
                                          .changeConfirmVisible();
                                    },
                                    child: Icon(
                                      AppCubit.get(context).confirmVisible ==
                                              false
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelText: 'confirm password',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                              MyHeightSizedBox(x: width * .05),
                              TextFormField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.length < 11) {
                                    return 'your phone number should be 11 number';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: phoneController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(width * .04)),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius:
                                        BorderRadius.circular(width * .04),
                                  ),
                                  labelText: 'phone',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                              MyHeightSizedBox(x: width * .1),
                              MyElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (passwordController.text ==
                                        confirmPasswordController.text) {
                                      cubit.register(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          fName: fNameController.text,
                                          lName: lNameController.text,
                                          phone: phoneController.text,
                                          imgUrl: defaultUrl);
                                    }
                                  }
                                },
                                widget: const MyText(
                                  str: 'Sign up',
                                  color: Colors.white,
                                ),
                                width: 300,
                                height: 50,
                                color: themeColor,
                              ),
                              MyHeightSizedBox(x: width * .07),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(
                                    str: 'Or continue with',
                                    size: width * .04,
                                    color: HexColor('#181818'),
                                  ),
                                ],
                              ),
                              MyHeightSizedBox(x: width * .05),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: width * 0.13,
                                    width: width * 0.3,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          HexColor('F1F5F9'),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          // Image(
                                          //   image: const AssetImage(
                                          //       'assets/images/google.png'),
                                          //   width: width * .055,
                                          // ),
                                          Icon(
                                            Icons.email_outlined,
                                            color: Colors.blue,
                                            size: width * .055,
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Text(
                                            'Google',
                                            style: TextStyle(
                                              fontSize: width * 0.028,
                                              fontWeight: FontWeight.w700,
                                              color: HexColor('#475569'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  SizedBox(
                                    height: width * 0.13,
                                    width: width * 0.3,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          HexColor('F1F5F9'),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.facebook,
                                            color: Colors.blue,
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Facebook',
                                            style: TextStyle(
                                              fontSize: width * 0.03,
                                              fontWeight: FontWeight.w700,
                                              color: HexColor('#475569'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, state) {
        if (state is RegisterSuccessState) {
          AppCubit.get(context).saveUid(context: context);
        }
        if (state is RegisterErrorState) {
          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(AppCubit.get(context).registerError.toString()),
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
