import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/models/profile_model/profile_model.dart';
import 'package:shopapp/modules/profile_screen/profile_screen.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late LoginModel loginModel;
  late ProfileModel profileModel;

  @override
  initState()  {
    print('started initState');
    getData();
  }
  getData()async{
    String token = await SharedPeference.getData(key: 'token');
    await DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      nameController.text = value.data['data']['name'];
      emailController.text = value.data['data']['email'];
      // passwordController.text = value.data['data']['password'];
      phoneController.text = value.data['data']['phone'];
    }).catchError((error) {
      print('error at init State $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    late ProfileModel profileModel ;
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('updat'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'please enter email';
                    }
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      'name',
                    ),
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
                      'email',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                // SizedBox(
                //   height: 20.0,
                // ),
                // TextFormField(
                //   validator: (value) {
                //     if (value!.isEmpty || value == null) {
                //       return 'please enter password';
                //     }
                //   },
                //   controller: passwordController,
                //   keyboardType: TextInputType.visiblePassword,
                //   decoration: InputDecoration(
                //     label: Text(
                //       'password',
                //     ),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     prefixIcon: Icon(Icons.lock),
                //   ),
                // ),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            String token =
                                await SharedPeference.getData(key: 'token');
                            await DioHelper.updateData(
                              url: 'update-profile',
                              data: {
                                'name': nameController.text,
                                'email': emailController.text,
                                // 'password': passwordController.text,
                                'phone': phoneController.text,
                              },
                              token: token,
                            ).then((value)async {
                              print('updated Successfully');
                              if (value.data['status']) {
                                print(value.data);
                                await LoginModel.fromJson(value.data);
                                profileModel = await ProfileModel.fromJson(value.data);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('${value.data['message']}')));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen(profileModel)));
                              }
                            }).catchError((error) {
                              print('error at updating $error');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('error at updating $error')));
                            });
                          }
                        },
                        child: Text('Save'),
                        color: Colors.grey[200],
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                        color: Colors.grey[200],
                        splashColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
