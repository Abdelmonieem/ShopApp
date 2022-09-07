class CategoriesModel{
bool status = false;
late CategoriesModelData categoriesModelData;
CategoriesModel(){}
  CategoriesModel.fromJson(Map<String,dynamic> data){
  status = data['status'];
  categoriesModelData = CategoriesModelData.fromJson(data['data']);
  }

}
class CategoriesModelData{
  late int currentPage;
  late List<CategoriesData> categorisDataLis = [];

   CategoriesModelData.fromJson(Map<String,dynamic> data){
     currentPage=data['current_page'];
     data['data'].forEach((element){
       categorisDataLis.add(CategoriesData.fromJson(element));
     });
   }
}
class CategoriesData{
  late int id ;
  late String name;
  late String image;
  CategoriesData.fromJson(Map<String,dynamic> data){
    id= data['id'];
    name= data['name'];
    image= data['image'];
  }

}