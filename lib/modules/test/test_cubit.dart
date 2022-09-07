import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/test/test_states.dart';

class TestCubit extends Cubit<TestStates>{
  TestCubit() : super(TestInitialState());

  static TestCubit get(context) =>BlocProvider.of(context);

  late Map<int,bool?> iconstest ={};
 late Icon testIcon ;


void setmap(index){
  late Map<int,bool?> iconstest ={};
  print('calling setmap');
  for(int i = 0;i<index+1;i++){
    // iconstest.update(index, (value) => false);
    iconstest[index]=false;
    print(iconstest);
  }
  emit(setMap());
  print(iconstest);
}
 void changeIcon(index){
   bool val = !(iconstest[index]!);
   print('${index} = $val');
   iconstest.update(index, (value) => val);
   print(iconstest);
   emit(TestChangeIcon());
  // testIcon = Icon(Icons.favorite,color: Colors.red,);
 }
}