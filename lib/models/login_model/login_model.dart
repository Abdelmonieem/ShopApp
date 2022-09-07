class LoginModel {
  late bool status;
  late String message;
  late UserLoginModel data;
  LoginModel.fromJson(Map<String, dynamic> data) {
    status = data['status'];
    message = data['message'];
    this.data = UserLoginModel.fromJson(data['data']);
  }
}

class UserLoginModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserLoginModel(
      this.id,//
      this.name,//
      this.email,//
      this.phone,//
      this.image,//
      this.points,
      this.credit,
      this.token,//
      );

  UserLoginModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    // points = data['points'];
    // credit = data['credit'];
    token = data['token'];
  }
}
