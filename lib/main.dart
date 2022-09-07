import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_screen/home_screen.dart';
import 'package:shopapp/modules/login_screen/login_screen.dart';
import 'package:shopapp/modules/on_boarding/on_boarding.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SharedPeference.init();
  bool? onboarding = await SharedPeference.getData(key: 'onBoareding');
  bool? islogedin = await SharedPeference.getData(key: 'islogedin');
  // await SharedPeference.setData(key: 'islogedin', value: false);
  // await SharedPeference.setData(key: 'onBoareding', value: false);
  // print(islogedin);
  // print(onboarding);
  String? token = await SharedPeference.getData(key: 'token');
  print('onboarding is $onboarding');
  // if(islogedin == null) islogedin = false;
  print(islogedin);
  Widget widget;
  if (onboarding!) {
    print('we saw onboarding');
    if (islogedin!) {
      print(token);
      print('we login');
      widget = HomeScreen();
    } else {
      print('we did not login');
      widget = Login();
    }
  } else {
    print('we did not see the onboarding');
    widget = OnBoarding();
  }
  runApp(ShoppingApp(widget: widget));
}

class ShoppingApp extends StatelessWidget {
  final Widget widget;

  const ShoppingApp({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit()..getHomeData()..getCategoriesData()..getFavoritesData(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: widget,
        ));
  }
}
