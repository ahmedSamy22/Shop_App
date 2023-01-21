import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {  @override
Widget build(BuildContext context) {

  var searchController=TextEditingController();
  var formKey=GlobalKey<FormState>();



  return  BlocProvider(
    create: (context) => SearchCubit(),
    child: BlocConsumer<SearchCubit,SearchStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        int? length =0;

        if(SearchCubit.get(context).searchModel?.data?.data != null)
        {
          length = SearchCubit.get(context).searchModel?.data?.data?.length;
        }else{
          length = 0; //return value if str is null
        }
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    keyboardTybe: TextInputType.text,
                    prefixIcon: Icons.search,
                    label: 'Enter any keyword',
                    onChange: (value){

                    },
                    onSubmit: (value){
                        SearchCubit.get(context).getSearch(value);
                    },
                    validator: (value)
                    {
                      if(value==null || value.isEmpty)
                      {
                        return 'Search field can\'t be empty';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10.0,),
                  if(state is SearchLoadingState)
                    LinearProgressIndicator(),

                  if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildSearchItem(SearchCubit.get(context).searchModel?.data?.data![index],context,index),
                        separatorBuilder: (context, index) => listDivider(),
                        itemCount: length!,
                  ),
                    ),
                ],
              ),
            ),
          ),


        );
      },

    ),
  );

}

Widget buildSearchItem(Product? product,context,index)
{
  int? id=product?.id;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product?.image),
                width: 120.0,
                height: 120.0,
              ),

            ],

          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product?.name}',
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
                        '${product?.price} L.E',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),

                      Spacer(),
                      IconButton(
                        onPressed: (){

                          ShopCubit.get(context).changeFavourites(product?.id);

                        },
                        icon: CircleAvatar(
                          backgroundColor: SearchCubit.get(context).searchModel?.data?.data![index].inFavorites ? Colors.red:Colors.grey ,
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
}
