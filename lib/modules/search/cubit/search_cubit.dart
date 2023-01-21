import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearch(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text ,
        },
    ).then((value) {

      searchModel=SearchModel.fromJson(value.data);
      print(searchModel?.data?.data![0].name);
      emit(SearchSuccessState());
    }).catchError((error){

      print(error.toString());
      emit(SearchErrorState());
    });
  }

}
