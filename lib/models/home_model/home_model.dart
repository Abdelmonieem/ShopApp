class HomeModel{
  late  bool status = false;
  late final String message;
  late HomeModelData homeModelDatadata ;
  HomeModel();
  HomeModel.fromJson(Map<String,dynamic> data){
    status = data['status'];
    // message = data['message'];
    homeModelDatadata = HomeModelData.fromJson(data['data']);
  }

}
class HomeModelData{
  List<BannerModel> banners = [];
  List<ProductsModel> productsList=[];
  HomeModelData.fromJson(Map<String,dynamic> data){
    data['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });
    data['products'].forEach((element){
      productsList.add(ProductsModel.fromJson(element));
    });
  }
}
class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
  }
}
class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool in_favorites;
  late bool in_cart;
  ProductsModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
