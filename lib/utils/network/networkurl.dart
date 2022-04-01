import 'package:demo_elixia/utils/network/urlconstant.dart';


// url of the application
class NetworkUrl{

  String getBaseUrlApplication(){
    return UrlConstants.baseurl;
  }

  String getCurrentWeatherDetails(){
    return UrlConstants.currentWeather;
  }
}