import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/categories_model.dart';
import 'package:shop_app/models/shop_model/favourites_models.dart';
import 'package:shop_app/models/shop_model/home_model.dart';
import 'package:shop_app/models/shop_model/login_model.dart';
import 'package:shop_app/modules/favourits/favourits_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/shop_model/change_fav_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../components/constants.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> bottomScreens=
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(index)
  {
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int,bool> favourite={};

  void getHomeData()
  {
    emit(ShopHomeDataLoadingState());

    DioHelper.getData(url: HOME,token: token,)
        .then((value)
    {

      homeModel=HomeModel.fromJson(value.data);
     // print(homeModel?.data?.banners[0].image);

      homeModel?.data?.products.forEach((element) {
        favourite.addAll({
          element.id : element.in_favorites,
        });
      });

      print(favourite.toString());

      emit(ShopHomeDataSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopHomeDataErrorState());

    });



  }



  CategoriesModel? categoriesModel;

  void getCategoriesData()
  {
    DioHelper.getData(url: CATEGORIES,)
        .then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
     // print(categoriesModel?.data?.data[0].image);

      emit(ShopCategoriesDataSuccessState());
    }).catchError((error)
    {
      print(error.toString());
        emit(ShopCategoriesDataErrorState());

    });



  }

  ChangeFavModel? changeFavModel;

  void changeFavourites(int productId)
  {
    favourite[productId]= !favourite[productId]!;
    emit(ShopChangeFavState());

    DioHelper.postData(
        url: FAVOURITES,
        data: {
          'product_id': productId,
        },
       token: token,
    ).
    then((value) {

      changeFavModel=ChangeFavModel.fromJson(value.data);
      print(value.data);

      if(!changeFavModel?.status)
        {
          favourite[productId]= !favourite[productId]!;
        }else
        {
        getFavourites();
      }

      emit(ShopChangeFavSuccessState(changeFavModel!));

    }).catchError((error){

      favourite[productId]= !favourite[productId]!;
      emit(ShopChangeFavErrorState());
    });
  }


  FavouritesModel? favouritesModel;

  void getFavourites()
  {
    emit(ShopGetFavouritesLoadingState());

    DioHelper.getData(url: FAVOURITES,token: token,)
        .then((value)
    {
      favouritesModel=FavouritesModel.fromJson(value.data);
     // print(value.data.toString());

      emit(ShopGetFavouritesSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetFavouritesErrorState());

    });



  }

  LoginModel? profileModel;

  void getProfile()
  {
    emit(ShopGetProfileLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    )
        .then((value)
    {
      profileModel=LoginModel.fromJson(value.data);
      print(value.data.toString());

      emit(ShopGetProfileSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopGetProfileErrorState());

    });



  }

  void updateProfile(
      {
        required String name,
        required String email,
        required String phone,
      })
  {
    emit(ShopUpdateProfileLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    )
        .then((value)
    {
      profileModel=LoginModel.fromJson(value.data);
      print(value.data.toString());

      emit(ShopUpdateProfileSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopUpdateProfileErrorState());

    });



  }
}