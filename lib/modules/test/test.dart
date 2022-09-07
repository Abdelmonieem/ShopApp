import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopapp/modules/test/test_cubit.dart';
import 'package:shopapp/modules/test/test_states.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TestCubit cubit = TestCubit.get(context);
          return ConditionalBuilder(
              condition: true,
            builder: (context) {
                return Scaffold(
              appBar: AppBar(),
              body: ListView.builder(
                dragStartBehavior: DragStartBehavior.start,
                itemBuilder: (context, index) {
                  // cubit.iconstest.addAll({index:false});
                  return IconButton(
                    onPressed: (){
                      print(cubit.iconstest);
                      cubit.changeIcon(index);
                      //cubit.iconstest[index] = !cubit.iconstest[index]!;
                    },
                    icon: cubit.iconstest[index]!?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite),
                  );
                },
                itemCount: 30,
              ),
            );},
              fallback: (context) {return Center(child: SpinKitCircle(size: 50.0 ,color: Colors.red,));},
          );
        },
      );
  }
}
