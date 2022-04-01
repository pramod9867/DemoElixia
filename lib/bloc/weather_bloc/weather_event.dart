import 'package:equatable/equatable.dart';

abstract class FetchWeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFinalWeatherEvents extends FetchWeatherEvent {
  final String data;

  FetchFinalWeatherEvents(this.data);
}
