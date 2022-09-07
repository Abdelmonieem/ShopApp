import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/favorite_model/favorite_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/modules/product_view_screen/product_view_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        // cubit.getFavoritesData();
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) =>
                favoritItemBuilder(cubit.favoriteModel, index, context,cubit),
            separatorBuilder: (context, index) =>
                Divider(
                  height: 20.0,
                ),
            itemCount: cubit
                .favoriteModel.favoriteModelData.favoritePreModelData.length,
          ),
        );
      },
    );
  }

  Widget favoritesBuild(FavoriteModel favoriteModel, int index, conext) {
    return Row(
      children: [
        Container(
          height: 150.0,
          width: 150.0,
          child: Image(
            image: NetworkImage(
                favoriteModel.favoriteModelData.favoritePreModelData[index]
                    .favoriteModelProductData.image),
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Text(
            '${favoriteModel.favoriteModelData.favoritePreModelData[index]
                .favoriteModelProductData.name}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),

      ],
    );
  }


  Widget favoritItemBuilder(FavoriteModel favoriteModel, int index, context, HomeCubit cubit) {
    return BlocConsumer<HomeCubit,HomeStates>(builder: (contxt, state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.white,
        child: GestureDetector(
          onTap: (){
            ProductsModel productsModel = cubit.gettingProductDetails(favoriteModel.favoriteModelData.favoritePreModelData[index].favoriteModelProductData.id);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductViewScreen(productsModel)));
          },
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    height: 200.0,
                    fit: BoxFit.cover,
                    image: NetworkImage(favoriteModel.favoriteModelData
                        .favoritePreModelData[index].favoriteModelProductData
                        .image),
                  ),
                  if (favoriteModel.favoriteModelData.favoritePreModelData[index]
                      .favoriteModelProductData.discount != 0)
                    Container(
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                favoriteModel.favoriteModelData.favoritePreModelData[index]
                    .favoriteModelProductData.name,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${favoriteModel.favoriteModelData.favoritePreModelData[index]
                        .favoriteModelProductData.price}',
                    style: const TextStyle(),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if (favoriteModel.favoriteModelData.favoritePreModelData[index]
                      .favoriteModelProductData.discount != 0)
                    Text(
                      '${favoriteModel.favoriteModelData
                          .favoritePreModelData[index].favoriteModelProductData
                          .old_price}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.black,
                      ),
                    ),
                  const Spacer(),
                  Container(
                    child:cubit.index == index ? CircularProgressIndicator(color: Colors.blue,):IconButton(
                      onPressed: () {
                        cubit.index = index;
                         HomeCubit.get(context).postFavoritesData(
                            favoriteModel.favoriteModelData
                                .favoritePreModelData[index]
                                .favoriteModelProductData.id,context);
                        HomeCubit.get(context).changeIcon(favoriteModel.favoriteModelData.favoritePreModelData[index].favoriteModelProductData.id);
                        HomeCubit.get(context).getFavoritesData();
                        print(favoriteModel.favoriteModelData.favoritePreModelData[index].favoriteModelProductData.id);
                        cubit.loadinProdcts['${favoriteModel.favoriteModelData.favoritePreModelData[index].favoriteModelProductData.id}']= false;
                        // cubit.favoriteProducts.update('${favoriteModel.favoriteModelData.favoritePreModelData[index].favoriteModelProductData.id}', (value) => false);
                        print(cubit.favoriteProducts);
                        cubit.changeIcon(favoriteModel.favoriteModelData.favoritePreModelData[index].favoriteModelProductData.id);
                        // print(cubit.loadinProdcts);
                        // print(cubit.favoriteProducts);
                        },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }, listener: (context, state) {});
  }

}