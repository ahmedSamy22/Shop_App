class SearchModel {
  final bool? status;
  final dynamic message;
  final Data? data;

  SearchModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'],
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
}

class Data {
  final int? currentPage;
  final List<Product>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;


  Data.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        data = (json['data'] as List?)?.map((dynamic e) => Product.fromJson(e as Map<String,dynamic>)).toList(),
        firstPageUrl = json['first_page_url'] ,
        from = json['from'] ,
        lastPage = json['last_page'] ,
        lastPageUrl = json['last_page_url'] ,
        nextPageUrl = json['next_page_url'],
        path = json['path'] ,
        perPage = json['per_page'] ,
        prevPageUrl = json['prev_page_url'],
        to = json['to'],
        total = json['total'] ;


}

class Product {
  final dynamic id;
  final dynamic price;
  final dynamic image;
  final dynamic name;
  final dynamic description;
  final List<dynamic>? images;
  final dynamic inFavorites;
  final bool? inCart;

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] ,
        price = json['price'],
        image = json['image'] ,
        name = json['name'],
        description = json['description'] ,
        images = (json['images'] as List?)?.map((dynamic e) => e as String).toList(),
        inFavorites = json['in_favorites'] ,
        inCart = json['in_cart'];

}