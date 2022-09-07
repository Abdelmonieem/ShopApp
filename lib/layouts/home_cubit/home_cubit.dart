import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/favorite_model/favorite_model.dart';
import 'package:shopapp/models/home_model/categories_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/models/search_model/search_model.dart';
import 'package:shopapp/modules/categories_screen/categories_screen.dart';
import 'package:shopapp/modules/favorite_screen/favorite_screen.dart';
import 'package:shopapp/modules/porduct_screen/porduct_screen.dart';
import 'package:shopapp/modules/setteings_screen/setteings_screen.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  static HomeCubit get(context) => BlocProvider.of(context);

  HomeCubit() : super(HomeIntialState());

  int index = 99999;

  int itemCount = 1;

  addItemCoun() {
    itemCount++;
    emit(AddItem());
  }

  removeItemCoun() {
    itemCount--;
    emit(RemoveItem());
  }

  int currentIndex = 0;
  List<String> appBarTitlesList = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];
  List<Widget> BodyScreensList = [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    Settings(),
  ];

  List<BottomNavigationBarItem> navBarItemsList = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        label: 'Favorite'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeHomeBottomNav(int index) {
    currentIndex = index;
    emit(HomeNaveBarChange());
  }

  late HomeModel homeModel = HomeModel();
  late ProductsModel productsModel;

  Map<String, bool?> favoriteProducts = {};
  Map<String, bool?> loadinProdcts = {};
  late String tokenshard;

  void getHomeData() async {
    String token = await SharedPeference.getData(key: 'token');
    String tokenshard = await SharedPeference.getData(key: 'token');
    emit(GetHomeDataLoading());
    print('gettin Home Data');
    DioHelper.getData(
      url: 'home',
      lang: 'ar',
      token: token,
    ).then((value) {
      // print(value.data['data']);
      emit(GetHomeDataSuccess());
      homeModel = HomeModel.fromJson(value.data);
      homeModel.homeModelDatadata.productsList.forEach((element) {
        favoriteProducts.addAll({'${element.id}': element.in_favorites});
        loadinProdcts.addAll({'${element.id}': false});
      });
    }).catchError((error) {
      emit(GetHomeDataFailure());
      print(error);
    });
  }

  late CategoriesModel categoriesModel = CategoriesModel();

  void getCategoriesData() {
    DioHelper.getData(
      url: 'categories',
      lang: 'ar',
    ).then((value) {
      emit(GetCategoriesDataSuccess());
      // print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);
    }).catchError((error) {
      emit(GetCategoriesDataFailure());
      index = 999999;
      print(error);
    });
  }

  late FavoriteModel favoriteModel = FavoriteModel();
  late PostFavoriteModel postFavoriteModel = PostFavoriteModel();

  void getFavoritesData() async {
    String token = await SharedPeference.getData(key: 'token');
    print(token);
    emit(GetFavoritesDataLoading());
    await DioHelper.getData(
      url: 'favorites',
      lang: 'en',
      token: '$token',
    ).then((value) {
      emit(GetFavoritesDataSuccess());
      index = 999999;
      favoriteModel = FavoriteModel.fromJson(value.data);
      print('getting favorties success');
      print(value.data);
    }).catchError((error) {
      emit(GetFavoritesDataFailure());
      index = 99999;
      print('error is $error');
    });
  }

  bool favelement = false;
  bool loadinIcon = false;

  void postFavoritesData(int id, context) async {
    String token = await SharedPeference.getData(key: 'token');
    print('Posting to Favorits Data');
    emit(postFavoritesDataLoading());
    await DioHelper.postData(
      url: 'favorites',
      data: {'product_id': id},
      token: token,
      lang: 'ar',
    ).then((value) {
      emit(postFavoritesDataSuccess());
      print('posting data success');
      loadinProdcts['$id'] = false;
      changeIcon(id);
      index = 99999;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value.data['message'].toString())));
      print('to her its okey');
      // favelement = homeModel.homeModelDatadata.productsList[id].in_favorites;
      print(value.data);
      postFavoriteModel = PostFavoriteModel.fromJson(value.data);
      // favoriteModel = FavoriteModel.fromJson(value.data);
      // favelement = homeModel.homeModelDatadata.productsList[id].in_favorites;
      print(id);
      // print('favelement is $favelement');
      getFavoritesData();
    }).catchError((error) {
      emit(postFavoritesDataFailure());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'error at adding to favorites check the internet and try later')));
      loadinProdcts['$id'] = false;
      print('error at postin to favorites $error');
    });
  }

  Icon FavoIcon = Icon(
    Icons.favorite_border,
    size: 16.0,
  );
  Icon favorIconNotpressed = Icon(
    Icons.favorite_border,
    size: 16.0,
  );
  Icon favorIconpressed = Icon(
    Icons.favorite,
    color: Colors.red,
    size: 16.0,
  );

  changeIcon(id) {
    favoriteProducts.update('$id', (value) {
      bool? x = favoriteProducts['$id'];
      x = !x!;
      print('x is $x');
      return x;
    });
    print(favoriteProducts);

    emit(ChangeIconFav());
  }

  ProductsModel gettingProductDetails(id) {
    print(id);
    var index = homeModel.homeModelDatadata.productsList.indexWhere((element) {
      print(element.id);
      return element.id== id ? true:false;
    });
    print(index);
    return homeModel.homeModelDatadata.productsList[index];
  }

  TextEditingController searchController = TextEditingController();
  SearchModel searchModel = SearchModel();

  searchProducts(String value) async {
    String token = await SharedPeference.getData(key: 'token');
    emit(postsearchLoading());
    print('searching products');
    DioHelper.postData(
      url: 'products/search',
      lang: 'ar',
      token: token,
      data: {'text': searchController.text},
    ).then((value) {
      print('searching products success');
      print(value);
      searchModel = SearchModel.fromJson(value.data);
      print('searchModel status is ${searchModel.status}');
      emit(postsearchSuccess());
    }).catchError((error) {
      emit(postsearchFailure());
      print('search error $error');
    });
  }
}
