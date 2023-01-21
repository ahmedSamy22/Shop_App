import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {

        int? catLength = ShopCubit.get(context).categoriesModel?.data?.data.length;

        return ListView.separated(
          itemBuilder: (context, index) => catListItem(
              ShopCubit.get(context).categoriesModel?.data?.data[index]),
          separatorBuilder: (context, index) => listDivider(),
          itemCount: catLength!,
        );
      },
    );
  }

  Widget catListItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model?.image),
              fit: BoxFit.cover,
              width: 80.0,
              height: 80.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              model?.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
