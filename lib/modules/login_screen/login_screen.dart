import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/home_screen/home_screen.dart';
import 'package:shopapp/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:shopapp/modules/login_screen/login_cubit/login_states.dart';
import 'package:shopapp/modules/signup_screen/signup_screen.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/shared/styles.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (BuildContext context, state) {
            print(state);
            if(state is LoginSuccessState){
              if(state.loginModel.status){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }else{

              }
            }
            if(state is LoginFauilerState){

            }
          },
          builder: (BuildContext context, Object? state) {
            LoginCubit cubit = LoginCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TitlesTextStyle(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defTextFormFeild(
                        textController: cubit.emailController,
                        context: context,
                        lable: Text('email'),
                        prefixIcon: Icon(Icons.email),
                        onTap: () {},
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the email';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defTextFormFeild(
                        textController: cubit.passwordController,
                        context: context,
                        type: TextInputType.visiblePassword,
                        lable: Text('password'),
                        sufixIcon: IconButton(
                            onPressed: () {
                              cubit.changePassword();
                            },
                            icon: Icon(cubit.iconPassword)),
                        prefixIcon: Icon(Icons.lock),
                        obscureText: cubit.obsecuretext,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onTap: () {},
                        onChange: (value) {},
                      ), //defaulTextFormField
                      SizedBox(
                        height: 20.0,
                      ),
                      DefButton(
                        text: 'Login',
                        style: ButtonsTextStyle(),
                        onTap: ()async {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.userlogin(
                              email: cubit.emailController.text,
                              password: cubit.passwordController.text,
                            );
                          } else {
                            print('insert data');
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have Account?'),
                          SizedBox(
                            width: 20.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            },
                            child: Text(
                              'Register',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
