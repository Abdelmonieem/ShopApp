import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/home_model/categories_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/modules/product_view_screen/product_view_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.homeModel.status,
            fallback: (BuildContext context) => const SpinKitCircle(
              color: Colors.blue,
              size: 50.0,
            ),
            builder: (BuildContext context) {
              return ProuductBuilder(cubit.homeModel, cubit.categoriesModel,context,cubit);
            },
          ),
        );
      },
    );
  }

  Widget ProuductBuilder(HomeModel homeModel, CategoriesModel categoriesModel,context,HomeCubit cubit) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.homeModelDatadata.banners
                .map((e) => Image(
                      image: NetworkImage(
                        e.image,
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              reverse: false,
              autoPlay: true,
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child:  Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
            ),
          ),
          Container(
            height: 150.0,
            child: ListView.builder(
              // shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return getCategories(categoriesModel, index);
              },
              itemCount:
                  categoriesModel.categoriesModelData.categorisDataLis.length,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child:  Text(
              'New Products',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),
            ),
          ),
          Container(
            color: Colors.grey[150],
            child: GridView.count(
              childAspectRatio: 1 / 1.47,
              shrinkWrap: true,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                homeModel.homeModelDatadata.productsList.length,
                (index) => ProudctItemBuilder(
                    homeModel.homeModelDatadata.productsList[index],context,cubit,index),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget ProudctItemBuilder(ProductsModel productsModel,context,HomeCubit cubit,int index) {
    cubit.productsModel = productsModel;

    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductViewScreen(productsModel)));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    height: 198.0,
                    fit: BoxFit.cover,
                    image: NetworkImage(productsModel.image),
                  ),
                  if (productsModel.discount != 0)
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
                productsModel.name,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${productsModel.price}',
                    style: const TextStyle(),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if (productsModel.discount != 0)
                    Text(
                      '${productsModel.old_price}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.black,
                      ),
                    ),
                  const Spacer(),
                  Container(
                    child:cubit.loadinProdcts['${productsModel.id}']! ?Container(child: CircularProgressIndicator(color: Colors.blue,)) : IconButton(
                      onPressed: (){
                        cubit.loadinIcon = true;
                        HomeCubit.get(context).postFavoritesData(productsModel.id,context);
                        cubit.loadinProdcts['${productsModel.id}']= true;
                        cubit.getFavoritesData();
                        // cubit.changeIcon(productsModel.id);
                        // print(cubit.loadinProdcts);
                        print('the id is ${productsModel.id}');
                        print(cubit.favoriteProducts);
                      },
                      icon:cubit.favoriteProducts['${productsModel.id}']!?const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      
    );
  }
  Widget getCategories(CategoriesModel categoriesModel, int index) {
    return Card(
      child: Container(
        
        width: 250.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(categoriesModel
                  .categoriesModelData.categorisDataLis[index].image),
            ),
            Container(
              width: double.infinity,
              height: 25.0,
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Text(
                  categoriesModel.categoriesModelData.categorisDataLis[index].name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
