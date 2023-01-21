// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/
// v2/everything?
// q=tesla
// &
// apiKey=2c2fc412c9c94a80acf417a3c42ec89a

import '../../modules/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value!)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

String? token= ' ';

// firebase token= 1//03ClhM5I4muEMCgYIARAAGAMSNwF-L9IrXvV0ctzX7VtTLOB0jfu0MaP7-pUkEHDc2kwvgWldgvxt_tTmAWrA43inCUVDkTEqoUM