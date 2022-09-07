class SearchModel{
  late bool status =false;
  late SearchModelPreData searchModelPreData;
  SearchModel(){}
  SearchModel.fromJson(Map<String,dynamic>data){
    status = data['status'];
    searchModelPreData = SearchModelPreData.fromJson(data['data']);
  }
}
class SearchModelPreData{
  late int currentPage;
  late List<SearchModelData> searchDataList=[];
  SearchModelPreData.fromJson(Map<String,dynamic> data){
    currentPage = data['current_page'];
    data['data'].forEach((element){
      searchDataList.add(SearchModelData.fromJson(element));
    });


  }
}
class SearchModelData{
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  SearchModelData.fromJson(Map<String,dynamic> data){
    id = data['id'];
    price = data['price'];
    image=data['image'];
    name=data['name'];
    in_favorites=data['in_favorites'];
    in_cart=data['in_cart'];
  }

}