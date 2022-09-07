import 'package:shopapp/models/login_model/login_model.dart';

abstract class LoginStates{}
class InitialLoginState extends LoginStates {}

class changePasswordstate extends LoginStates {}


class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  late LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginFauilerState extends LoginStates {
  LoginFauilerState(error){
    print(error);
  }
}