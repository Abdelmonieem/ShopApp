class ProfileModel {
  late bool status;
  late ProfileModelData profileModelData;
  ProfileModel(){}
  ProfileModel.fromJson(Map<String,dynamic> data){
    status = data['status'];
    profileModelData = ProfileModelData.fromJson(data['data']);
  }
}
class ProfileModelData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  ProfileModelData.fromJson(Map<String,dynamic> data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    token = data['token'];
    }
}
