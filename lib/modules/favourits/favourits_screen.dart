import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/favourites_models.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {  @override
Widget build(BuildContext context) {

  return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context, state) {},
    builder: (context, state) {

      int? lenght = ShopCubit.get(context).favouritesModel?.data?.data?.length;

      return ConditionalBuilder(
        condition: (state is! ShopGetFavouritesLoadingState),
        builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favouritesModel?.data?.data![index],context),
          separatorBuilder: (context, index) => listDivider(),
          itemCount: lenght!,
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),

      );
    },
  );
}


Widget buildFavItem(FavouritesData? model,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model?.product?.image),
              width: 120.0,
              height: 120.0,
            ),
            if(model?.product?.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0,),
                color: Colors.red,
                child: const Text(
                  'Discount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),
              ),
          ],

        ),
        SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model?.product?.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                  children:[
                    Text(
                      '${model?.product?.price} L.E',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    if(model?.product?.discount != 0)
                      Text(
                        '${model?.product?.oldPrice}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),

                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){

                         ShopCubit.get(context).changeFavourites(model?.product?.id);

                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favourite[model?.product?.id]!? Colors.red:Colors.grey ,
                        child: Icon((Icons.favorite_border),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
}