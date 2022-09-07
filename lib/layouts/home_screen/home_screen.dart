import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/modules/login_screen/login_screen.dart';
import 'package:shopapp/modules/on_boarding/on_boarding.dart';
import 'package:shopapp/modules/search_screen/search_screen.dart';
import 'package:shopapp/modules/test/test.dart';
import 'package:shopapp/network/local/shared_preference.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          HomeCubit  cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.appBarTitlesList[cubit.currentIndex],
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen()));
                    },
                    icon: Icon(Icons.search),
                ),
              ],
            ),
            body: cubit.BodyScreensList[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items:cubit.navBarItemsList,
              onTap: (index){
                cubit.changeHomeBottomNav(index);
              },
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
            ),
          );
        });
  }
}
