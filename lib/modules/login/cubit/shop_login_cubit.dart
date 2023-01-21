import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/shop_login_states.dart';
import '../../../models/shop_model/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super (ShopLoginInitialState());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin(
  {
  required String email,
  required String password,
  })
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: 'login',
        lang: 'ar',
        data:
        {
          'email':email,
          'password':password,
        },
    ).then((value)
    {
      loginModel=LoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }


 IconData suffix= Icons.visibility_outlined;
 bool isPassword=true;
  void changePasswordVisability()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.remove_red_eye : Icons.visibility_off_outlined;
    emit(ShopChangePasswordState());

  }



}

