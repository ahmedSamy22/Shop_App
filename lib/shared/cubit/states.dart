import '../../models/shop_model/change_fav_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopHomeDataLoadingState extends ShopStates{}

class ShopHomeDataSuccessState extends ShopStates{}

class ShopHomeDataErrorState extends ShopStates{}

class ShopCategoriesDataSuccessState extends ShopStates{}

class ShopCategoriesDataErrorState extends ShopStates{}

class ShopChangeFavState extends ShopStates{}

class ShopChangeFavSuccessState extends ShopStates{

   final ChangeFavModel model;
  ShopChangeFavSuccessState(this.model);

}

class ShopChangeFavErrorState extends ShopStates{}

class ShopGetFavouritesLoadingState extends ShopStates{}

class ShopGetFavouritesSuccessState extends ShopStates{}

class ShopGetFavouritesErrorState extends ShopStates{}

class ShopGetProfileLoadingState extends ShopStates{}

class ShopGetProfileSuccessState extends ShopStates{}

class ShopGetProfileErrorState extends ShopStates{}

class ShopUpdateProfileLoadingState extends ShopStates{}

class ShopUpdateProfileSuccessState extends ShopStates{}

class ShopUpdateProfileErrorState extends ShopStates{}


