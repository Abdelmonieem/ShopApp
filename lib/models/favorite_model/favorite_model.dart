//to get data from the api
class FavoriteModel{
  late bool status;
  late FavoriteModelData favoriteModelData;
  FavoriteModel();
  FavoriteModel.fromJson(Map<String,dynamic> data){
    status=data['status'];
    favoriteModelData = FavoriteModelData.fromJson(data['data']) ;


  }
}
class FavoriteModelData{
  // late int currentpage;
  List<FavoritePreModelData> favoritePreModelData=[];
  FavoriteModelData.fromJson(Map<String,dynamic> data){
    // currentpage = data['current_page'];
    data['data'].forEach((element){
      favoritePreModelData.add(FavoritePreModelData.fromJson(element));
    });
  }
}
class FavoritePreModelData{
  late int id;
  late FavoriteModelProductData favoriteModelProductData;
  FavoritePreModelData.fromJson(Map<String,dynamic> data){
    id = data['id'];
    favoriteModelProductData = FavoriteModelProductData.fromJson(data['product']);
  }

}
class FavoriteModelProductData{
late int id;
late dynamic price;
late dynamic old_price;
late dynamic discount;
late String image;
late String name;
  FavoriteModelProductData.fromJson(Map<String,dynamic> data){
    id=data['id'];
    price=data['price'];
    old_price=data['old_price'];
    discount=data['discount'];
    image=data['image'];
    name=data['name'];
  }
}
// to post data to api
class PostFavoriteModel{
  late bool status;
  late PostFavoriteModelData favoriteModelData;
  PostFavoriteModel();
  PostFavoriteModel.fromJson(Map<String,dynamic> data){
    status=data['status'];
    favoriteModelData = PostFavoriteModelData.fromJson(data['data']) ;
  }
}
class PostFavoriteModelData{
  late int id ;
  // List<PostFavoriteModelProductData> postfavoritePreModelData=[];
  PostFavoriteModelData.fromJson(Map<String,dynamic> data){

    // data['product'].forEach((element){
    //   postfavoritePreModelData.add(PostFavoriteModelProductData.fromJson(element));
    // });
  }
}
class PostFavoriteModelProductData{
  late int id;
  late double price;
  late double old_price;
  late double discount;
  late String image;
  // late String name;
  PostFavoriteModelProductData.fromJson(Map<String,dynamic> data){
    id=data['id'];
    price=data['price'];
    old_price=data['old_price'];
    discount=data['discount'];
    image=data['image'];
    // name=data['name'];
  }
}


