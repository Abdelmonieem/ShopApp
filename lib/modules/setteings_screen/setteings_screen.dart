import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/models/profile_model/profile_model.dart';
import 'package:shopapp/modules/login_screen/login_screen.dart';
import 'package:shopapp/modules/profile_screen/profile_screen.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class Settings extends StatelessWidget {
   Settings({Key? key}) : super(key: key);
  late ProfileModel profileModel = ProfileModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(
                    'https://media-exp2.licdn.com/dms/image/C4D03AQES19k-gWMH1Q/profile-displayphoto-shrink_800_800/0/1652244814527?e=1660780800&v=beta&t=MK8Kd5E0b2lwHq2vX4RHhZ_gKbQTYwvU-Wfbhy48qh0',
                  )),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: () async{
                  String token = await SharedPeference.getData(key: 'token');
                  await DioHelper.getData(
                    url: 'profile',
                    token: token,
                  ).then((value) {

                    profileModel = ProfileModel.fromJson(value.data);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProfileScreen(profileModel)));
                  }).catchError((error) {
                    print('error at gettin profile $error');
                  });


                },
                child: Text('Profile'),
                color: Colors.grey[300],
                minWidth: double.infinity,
                height: 40.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: () async{
                  String token = await SharedPeference.getData(key: 'token');
                  print(token);
                  // await SharedPeference.setData(key: 'token', value: '');
                  // await SharedPeference.setData(key: 'onBoareding', value: false);
                  // await SharedPeference.setData(key: 'islogedin', value: false);
                  DioHelper.postData(
                    url: 'logout',
                    data: {'fcm_token':token},
                  ).then((value)async {
                    print('loged out succesffuly');
                    print(value);
                    // await SharedPeference.setData(key: 'token', value: null);
                    await SharedPeference.setData(key: 'onBoareding', value: false);
                    await SharedPeference.setData(key: 'islogedin', value: false);

                    SystemNavigator.pop();
                  }).catchError((error) {
                    print("error at logout $error");
                  });
                },
                child: Text('LogOut'),
                color: Colors.grey[300],
                minWidth: double.infinity,
                height: 40.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
