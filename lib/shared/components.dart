import 'package:flutter/material.dart';
import 'package:shopapp/models/home_model/home_model.dart';

Widget defTextFormFeild({
  required TextEditingController textController,
  required BuildContext context,
  required TextInputType type,
  Text? lable,
  Function? onTap,
  Function? onChange,
  Function? validate,
  Function? onFileSubmited,
  bool obscureText = false,
  double radiuc = 20.0,
  TextStyle? style,
  String? hint,
  Widget? prefixIcon,
  Widget? sufixIcon,
  Widget? suffixOnTap,
}) {
  return TextFormField(
    controller: textController,
    obscureText: obscureText,
    keyboardType: type,
    onTap: () {onTap!();},
    onFieldSubmitted: (value) {onFileSubmited!(value);},
    onChanged: (value) {onChange!(value);},
    validator: (value) {return validate!(value);},
    decoration: InputDecoration(
      prefixIcon:prefixIcon,
      suffixIcon: sufixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiuc),
      ),
      label: lable,
      hintText: hint,
    ),
  );
}

Widget DefButton({
  required String text,
  TextStyle? style,
  Function? onTap,

}){
  return Container(
    width: double.infinity,
    height: 40.0,
    child: ElevatedButton(
      onPressed: (){onTap!();},
      child: Text(
        '$text',
        style: style,
      ),
    ),
  );
}

Widget ProudctItemBuilder(ProductsModel productsModel) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              height: 200.0,
              fit: BoxFit.cover,
              image: NetworkImage(productsModel.image),
            ),
            if (productsModel.discount != 0)
              Container(
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          productsModel.name,
          style: const TextStyle(
            fontSize: 14.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Text(
              '${productsModel.price}',
              style: const TextStyle(),
            ),
            const SizedBox(
              width: 10.0,
            ),
            if (productsModel.discount != 0)
              Text(
                '${productsModel.old_price}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                ),
              ),
            const Spacer(),
            IconButton(
              onPressed: () {
              },
              icon: const Icon(
                Icons.favorite_border,
                size: 16.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

