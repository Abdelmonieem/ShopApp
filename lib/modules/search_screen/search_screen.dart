import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/search_model/search_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: cubit.searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      'Search',
                    ),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
                    cubit.searchProducts(value);
                    print(cubit.searchModel.status);
                    print(cubit
                        .searchModel.searchModelPreData.searchDataList.length);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                cubit.searchController.text.length > 0
                    ? Expanded(
                        child: ConditionalBuilder(
                          condition: cubit.searchModel.status,
                          builder: (context) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return searchItemBuilder(
                                    cubit.searchModel, index, cubit, context);
                              },
                              separatorBuilder: (contxt, index) {
                                return Divider(
                                  height: 20.0,
                                );
                              },
                              itemCount: cubit.searchModel.searchModelPreData
                                  .searchDataList.length,
                              // cubit.searchModel.searchModelPreData.searchDataList.length,
                            );
                          },
                          fallback: (context) {
                            return SpinKitFadingCircle(
                              color: Colors.blue,
                              size: 50.0,
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget searchItemBuilder(
      SearchModel searchModel, int index, HomeCubit cubit, context) {
    return Column(
      children: [
        Container(
          height: 200.0,
            width: double.infinity,
            child: Image(
          image: NetworkImage(
              searchModel.searchModelPreData.searchDataList[index].image),
        )),
        //searchModel.searchModelPreData.searchDataList[index].image
        Text(searchModel.searchModelPreData.searchDataList[index].name),
        Row(
          children: [
            Text(
                '${searchModel.searchModelPreData.searchDataList[index].price}'),
            IconButton(
              onPressed: () {
                cubit.changeIcon(
                    searchModel.searchModelPreData.searchDataList[index].id);
                cubit.postFavoritesData(
                    searchModel.searchModelPreData.searchDataList[index].id,
                    context);
                cubit.getFavoritesData();
              },
              icon: cubit.favoriteProducts[
                      '${searchModel.searchModelPreData.searchDataList[index].id}']!
                  ? Icon(Icons.favorite,color: Colors.red,)
                  : Icon(Icons.favorite_border),
            ),
          ],
        ),
      ],
    );
  }
}
