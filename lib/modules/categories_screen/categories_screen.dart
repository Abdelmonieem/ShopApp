import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/home_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) =>
                categoriesBuild(cubit.categoriesModel, index),
            separatorBuilder: (context, index) => Divider(
              height: 20.0,
            ),
            itemCount: cubit
                .categoriesModel.categoriesModelData.categorisDataLis.length,
          ),
        );
      },
    );
  }

  Widget categoriesBuild(CategoriesModel categoriesModel, int index) {
    return Row(
      children: [
        Container(
          height: 150.0,
          width: 150.0,
          child: Image(
            image: NetworkImage(categoriesModel
                .categoriesModelData.categorisDataLis[index].image),
          ),
        ),
        SizedBox(width: 20.0,),
        Text(
            '${categoriesModel.categoriesModelData.categorisDataLis[index].name}',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        IconButton(
          iconSize: 30.0,
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
