class ChangeFavModel
{
  dynamic status;
  dynamic message;
  ChangeFavModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    message=json['message'];
  }

}