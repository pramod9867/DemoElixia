import 'package:demo_elixia/framework/network/dio_client.dart';
import 'package:demo_elixia/model/request/weatherrequest.dart';
// import 'package:demo_elixia/model/suggestion.dart';
import 'package:demo_elixia/utils/constants/appcontants.dart';
import 'package:demo_elixia/utils/network/index.dart';
import 'package:dio/dio.dart';

abstract class WeatherRepo {
  Future<WeatherResponseModel> getWeatherResponse({String city = "London"});

  // Future<List<Suggestion>> getListOfSuggestion();
}

class WeatherService extends WeatherRepo {
  @override
  Future<WeatherResponseModel> getWeatherResponse(
      {String city = "London"}) async {
    print("Into the weather Service");
    ApiClient apiClient = ApiClient.defaultClient();

    Response response = await apiClient.dioClient!.get(
        AppConstants.networkUrl.getCurrentWeatherDetails(),
        queryParameters: {
          'key': '37890e656ebc48c393e180850223003',
          'q': city,
          'aqi': 'no',
        });

    WeatherResponseModel weatherResponseModel =
        WeatherResponseModel.fromJson(response.data);

    return weatherResponseModel;
  }

  // @override
  // Future<List<Suggestion>> getListOfSuggestion(
  //   //   {String input = "London",
  //   //   String lang = "en",
  //   //   String apiKey = "",
  //   //   String sessionToken = ""}) async {
  //   // //  ApiClient apiClient = ApiClient.defaultClient();

  //   // //   Response response = await apiClient.dioClient!.get(
  //   // //     '/current.json?key=37890e656ebc48c393e180850223003&q=London&aqi=no',
  //   // //   );
  //   // //   print("Response is");
  //   // //   print(response.data.toString());

  //   // //   WeatherResponseModel weatherResponseModel =
  //   // //       WeatherResponseModel.fromJson(response.data);
  //   // ApiClient apiClient = ApiClient.googleClient();

  //   // Response response = await apiClient.dioClient!.get(
  //   //   'json?input=$input&types=address&language=$lang&components=country:ch&key=$apiKey&sessiontoken=$sessionToken',
  //   // );

  //   // List<Suggestion> suggestions = [Suggestion("pramod", "patil")];

  //   // return suggestions;
  // }
}
