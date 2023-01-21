class HomeModel
{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}


class BannerModel
{
  late int id;
  late String image;
  BannerModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }

}
class ProductModel
{
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic in_favorites;
  dynamic in_cart;

  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}