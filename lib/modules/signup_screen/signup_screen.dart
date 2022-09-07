import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_screen/home_screen.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  late LoginModel loginModel ;
  bool loadin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Text(
                  'SignUp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'please enter the name';
                    }
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      'Name',
                    ),
                    hintText: 'name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'please enter email';
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                    ),
                    hintText: 'emial',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'please enter password';
                    }
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Password',
                    ),
                    hintText: 'password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'please enter phone';
                    }
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text(
                      'phone',
                    ),
                    hintText: 'phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: loadin?CircularProgressIndicator(color: Colors.blue,) :ElevatedButton(
                    onPressed: () async{

                      if (formkey.currentState!.validate()) {
                        setState((){
                          loadin =true;
                        });
                        DioHelper.postData(
                          url: 'register',
                          data: {
                            'name': nameController.text,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'phone': phoneController.text,
                          },
                        ).then((value) async{
                          setState((){
                            loadin =false;
                          });
                          if(value.data['status']){
                            loginModel = await LoginModel.fromJson(value.data);
                            print(loginModel.data.token);
                            await SharedPeference.setData(key: 'token', value: loginModel.data.token).then((value){
                              print('token saved in the sharedpreference successfuly');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            }).catchError((error){print(error);});
                            await SharedPeference.setData(key: 'islogedin', value: true);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.data['message'].toString())));

                        }).catchError((error) {
                          setState((){
                            loadin =false;
                          });
                          print('error at signup $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('${error.toString()}'),),
                          );
                        });
                      }
                    },
                    child: Text('Signup'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
