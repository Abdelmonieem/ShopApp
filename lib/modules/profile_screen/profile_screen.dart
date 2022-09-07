import 'package:flutter/material.dart';
import 'package:shopapp/models/profile_model/profile_model.dart';
import 'package:shopapp/modules/profile_screen/profile_update_screen.dart';
import 'package:shopapp/network/local/shared_preference.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class ProfileScreen extends StatelessWidget {
  ProfileModel profileModel = ProfileModel();

  ProfileScreen(ProfileModel this.profileModel, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage:
                  NetworkImage(profileModel.profileModelData.image),
                ),
              ),
              Divider(
                height: 40.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10.0),
                  Text(
                    "Name :",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Expanded(
                    child: Text(
                      '${profileModel.profileModelData.name}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 1.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 10.0),
                  Text(
                    "Email :",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      '${profileModel.profileModelData.email}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 2.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 10.0),
                  Text(
                    "phone :",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '${profileModel.profileModelData.phone}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: 2.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdateScreen()));
                  },
                  child: Text(
                    'Update',
                  ),
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                   ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getprofile() async {
    String token = await SharedPeference.getData(key: 'token');
    await DioHelper.getData(
      url: 'profile',
    ).then((value) {}).catchError((error) {
      print('error at gettin profile $error');
    });
  }
}
