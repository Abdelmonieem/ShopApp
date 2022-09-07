import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/home_model/home_model.dart';

class ProductViewScreen extends StatelessWidget {
  late ProductsModel productsModel;

  ProductViewScreen(ProductsModel this.productsModel, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Product Details'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          height: 200.0,
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
                        child: cubit.loadinProdcts['${productsModel.id}']!
                            ? Container(
                                child: CircularProgressIndicator(
                                color: Colors.blue,
                              ))
                            : IconButton(
                                onPressed: () {
                                  cubit.loadinIcon = true;
                                  HomeCubit.get(context).postFavoritesData(
                                      productsModel.id, context);
                                  cubit.loadinProdcts['${productsModel.id}'] =
                                      true;
                                  cubit.getFavoritesData();
                                  // cubit.changeIcon(productsModel.id);
                                  // print(cubit.loadinProdcts);
                                  print('the id is ${productsModel.id}');
                                  print(cubit.favoriteProducts);
                                },
                                icon: cubit.favoriteProducts[
                                        '${productsModel.id}']!
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      productsModel.description.toString(),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          width: 40.0,
                          height: 40.0,
                          child: FloatingActionButton(
                            heroTag: 'add',
                            onPressed: () {
                              cubit.addItemCoun();
                            },
                            child: Icon(Icons.add,color: Colors.black,),
                            backgroundColor: Colors.grey[400],
                          ),
                        ),
                        SizedBox(width: 40.0,),
                        Text(cubit.itemCount.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                        SizedBox(width: 40.0,),
                        Container(
                          width: 40.0,
                          height: 40.0,
                          child: FloatingActionButton(
                            heroTag: 'remove',
                            onPressed: () {
                              cubit.removeItemCoun();
                            },
                            child: Icon(Icons.remove,color: Colors.black,),
                            backgroundColor: Colors.grey[400],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                            },
                            child: Text('Buy'),
                            color: Colors.grey[200],
                            splashColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                            color: Colors.grey[200],
                            splashColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
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
        );
      },
    );
  }
}
