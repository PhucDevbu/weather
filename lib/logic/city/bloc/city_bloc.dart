import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/models/city_model.dart';
import 'package:weather/data/repositories/city_repository.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityRepository keyRepository = CityRepository();
  CityBloc() : super(CityLoadingState()) {
    on<CityEvent>((event, emit) {});
    on<FecthCityEvent>(
      (event, emit) async {
        try {
          List<CityModel> citys = await keyRepository.fetchKeys();
          emit(CityLoadedState(citys: citys));
        } on DioError catch (ex) {
          if (ex.type == DioErrorType.other) {
            emit(CityErrorState(
                "Can't fetch Key please check your internet connection!"));
          } else {
            emit(CityErrorState(ex.error.toString()));
          }
        }
      },
    );
  }
}
