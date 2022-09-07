import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/login_screen/login_cubit/login_states.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context)=> BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool obsecuretext = true;
  IconData iconPassword= Icons.remove_red_eye;
  late LoginModel loginModel ;

  changePassword(){
    obsecuretext = !obsecuretext;
    if(obsecuretext){
      iconPassword = Icons.remove_red_eye;
    }else{
      iconPassword = Icons.remove_red_eye_outlined;
    }
    emit(changePasswordstate());
  }

  userlogin({required String email,required String password}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: 'login',
        data: {
          'email':'$email',
          'password':'$password',
        },
    ).then((value){
      // print(value);
      loginModel=LoginModel.fromJson(value.data);
      print(loginModel.data.token);
      SharedPeference.setData(key: 'token', value: loginModel.data.token).then((value){
        print('token saved in the sharedpreference successfuly');
        SharedPeference.setData(key: 'islogedin', value: true).then((value){
        }).catchError((error){});
      }).catchError((error){print(error);});
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error);
      emit(LoginFauilerState(error));
    });
  }


}