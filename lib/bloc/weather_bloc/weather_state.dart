import 'package:demo_elixia/model/request/weatherrequest.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherStates extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherInitEvent extends WeatherStates {}

class WeatherLoadingEvent extends WeatherStates {}

class WeatherErrorEvent extends WeatherStates {
  String? message;
  WeatherErrorEvent({this.message});

  WeatherErrorEvent copyWith({
    String? message,
  }) {
    return WeatherErrorEvent(
      message: message ?? this.message,
    );
  }
}

class WeatherLoadedEvenet extends WeatherStates {
  WeatherResponseModel? weatherResponseModel;
  WeatherLoadedEvenet({this.weatherResponseModel});

  WeatherLoadedEvenet copyWith({
    WeatherResponseModel? weatherResponseModel,
  }) {
    return WeatherLoadedEvenet(
      weatherResponseModel: weatherResponseModel ?? this.weatherResponseModel,
    );
  }
}
