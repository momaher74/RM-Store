import 'package:buyall/bloc/app_cubit.dart';
import 'package:buyall/componant/constant.dart';
import 'package:buyall/screens/detailproductscreen.dart';
import 'package:buyall/screens/layoutscreen.dart';
import 'package:buyall/screens/loginscreen.dart';
import 'package:buyall/shared/sharedpref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/observar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()
        ..getCurrentUser()
        ..getMenClothesCat()
        ..getWomanWatchesCat()
        ..getWomanClothesCat()
        ..getMenWatchesCat()
        ..getAccessoriesCat()..getCartProducts(),
      child: BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    color: Colors.white,
                    elevation: 0,
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    )),
                iconTheme: const IconThemeData(
                  color: Colors.black,
                )),
            debugShowCheckedModeBanner: false,
            home: uId == "" ? LoginScreen() : LayoutScreen(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
