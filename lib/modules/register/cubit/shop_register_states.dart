import 'package:shop_app/models/shop_model/login_model.dart';

abstract class RegisterStates{}

class ShopRegisterInitialState extends RegisterStates{}

class ShopRegisterLoadingState extends RegisterStates{}

class ShopRegisterSuccessState extends RegisterStates{
  final LoginModel registerModel;
  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends RegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopChangeRegisterPasswordState extends RegisterStates{}