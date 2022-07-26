import 'package:buyall/componant/componant.dart';
import 'package:buyall/screens/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../bloc/app_cubit.dart';
import '../style/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var size, height, width;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: themeColor,
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * .3,
                      ),
                      Container(
                        width: width,
                        height: height * 0.75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 0.1),
                              topRight: Radius.circular(width * 0.1)),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: width * 0.1,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.025,
                                    horizontal: width * 0.05),
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: 'Enter your email',
                                      labelText: "E-Mail",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: HexColor('C4C4C4'))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: HexColor('C4C4C4')))),
                                  cursorColor: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.025,
                                    horizontal: width * 0.05),
                                child: TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: AppCubit.get(context).visible,
                                  decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          AppCubit.get(context).changeVisible();
                                        },
                                        child: Icon(
                                          AppCubit.get(context).visible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: HexColor('C4C4C4'),
                                        ),
                                      ),
                                      labelText: "Password",
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      hintText: "***********",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: HexColor('C4C4C4'),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: HexColor('C4C4C4')))),
                                  cursorColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: height * .025,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01,
                                    horizontal: width * 0.05),
                                child: SizedBox(
                                  width: width * 0.9,
                                  height: height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                themeColor)),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        AppCubit.get(context).sign(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child: const Text('log in'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.01,
                                  horizontal: width * 0.05,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have account?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: width * 0.04,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        push(context, SignupScreen());
                                      },
                                      child: Text(
                                        " Create now",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.04,
                                          color: HexColor('000113'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is SignSuccessState) {
          AppCubit.get(context).saveUid(context: context);
        }
        if (state is SignErrorState) {
          var snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(AppCubit.get(context).loginError.toString()),
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
