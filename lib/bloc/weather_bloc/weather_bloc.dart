import 'dart:io';

import 'package:demo_elixia/bloc/weather_bloc/weather_event.dart';
import 'package:demo_elixia/bloc/weather_bloc/weather_state.dart';
import 'package:demo_elixia/framework/network/service/weatherservice.dart';
import 'package:demo_elixia/model/request/weatherrequest.dart';
import 'package:demo_elixia/utils/constants/appcontants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<FetchWeatherEvent, WeatherStates> {
  WeatherResponseModel? weatherResponseModel;
  final WeatherRepo? weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherInitEvent()) {
    on<FetchFinalWeatherEvents>(fetchWhetherData);
  }

  fetchWhetherData(FetchFinalWeatherEvents fetchFinalWeatherEvents,
      Emitter<WeatherStates> emit) async {
    emit(WeatherLoadingEvent());
    try {
      weatherResponseModel = await weatherRepo!
          .getWeatherResponse(city: fetchFinalWeatherEvents.data);
      emit(WeatherLoadedEvenet(weatherResponseModel: weatherResponseModel));
    } on SocketException {
      emit(WeatherErrorEvent(message: AppConstants.appMessages.error_message));
    } on HttpException {
      emit(WeatherErrorEvent(message: AppConstants.appMessages.error_message));
    } on FormatException {
    } catch (e) {
      emit(WeatherErrorEvent(message: AppConstants.appMessages.error_message));
    }
  }
}
