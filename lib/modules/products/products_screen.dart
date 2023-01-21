import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/categories_model.dart';
import 'package:shop_app/models/shop_model/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopChangeFavSuccessState)
          {
            if (!state.model.status)
              {
                showToast(
                    text: state.model.message,
                    state: ToastStates.ERROR,
                );
              }
          }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).homeModel != null &&
            ShopCubit.get(context).categoriesModel !=null,
        builder: (context) => productsBuilder(ShopCubit.get(context).homeModel,
            ShopCubit.get(context).categoriesModel,context),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) {

    int? length = model?.data?.products.length;

    int? catLength =categoriesModel?.data?.data.length;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data?.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: Duration(
                seconds: 1,
              ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(categoriesModel?.data?.data[index]),
                      separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                      itemCount: catLength!,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                length!,
                (index) => buildGridProduct(model?.data?.products[index],context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel? model,context) => Container(
    color: Colors.white,
    child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model?.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if(model?.discount != 0)
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
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model?.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children:[
                      Text(
                        '${model?.price.round()} L.E',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      if(model?.discount != 0)
                        Text(
                        '${model?.old_price.round()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),

                      ),
                      Spacer(),
                      IconButton(
                          onPressed: (){

                            ShopCubit.get(context).changeFavourites(model?.id);
                            print('iddddd : ${model?.id}');
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context).favourite![model?.id]! ? Colors.red :Colors.grey ,
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
  );

  Widget buildCategoriesItem(DataModel? model)=>Stack(
    alignment: Alignment.bottomCenter,
    children:  [
       Image(
        image: NetworkImage(model?.image),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.6),
        child: Text(model?.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),),
      ),
    ],

  );
}
