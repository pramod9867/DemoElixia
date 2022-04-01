import 'package:demo_elixia/bloc/weather_bloc/weather_bloc.dart';
import 'package:demo_elixia/bloc/weather_bloc/weather_event.dart';
import 'package:demo_elixia/bloc/weather_bloc/weather_state.dart';
import 'package:demo_elixia/model/city.dart';
import 'package:demo_elixia/model/request/weatherrequest.dart';
import 'package:demo_elixia/utils/constants/appcontants.dart';
import 'package:demo_elixia/widget/app_widget/error_widget.dart';
import 'package:demo_elixia/widget/app_widget/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController searchField = TextEditingController(text: "");

  static List<City> _userOptions = <City>[
    City('London'),
    City('Mumbai'),
    City('Delhi'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.top -
            MediaQuery.of(context).viewInsets.bottom,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: Autocomplete<City>(
                displayStringForOption: _displayStringForOption,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  searchField.text = textEditingValue.text;
                  if (textEditingValue.text == '') {
                    return const Iterable<City>.empty();
                  }
                  return _userOptions.where((City option) {
                    return option.name
                        .toLowerCase()
                        .toString()
                        .startsWith(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (City selection) {
                  context
                      .read<WeatherBloc>()
                      .add(FetchFinalWeatherEvents(selection.name));
                },
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherStates>(
                builder: (BuildContext context, WeatherStates state) {
              if (state is WeatherErrorEvent) {
                return AppErrorWidget();
              }
              if (state is WeatherLoadedEvenet) {
                print("Into the WeatherLoadedEvenet ");
                WeatherResponseModel weatherResponseModel =
                    state.weatherResponseModel!;
                return _showWeatherResponse(weatherResponseModel);
              }
              if (searchField.text == "") {
                return Center(
                  child: Text(AppConstants.appMessages.notes),
                );
              }

              return AppLoaderWidget();
            }),
          ],
        ),
      ),
    );
  }

  Widget _showWeatherResponse(WeatherResponseModel weatherResponseModel) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                  weatherResponseModel.location!.name.toString() +
                      " " +
                      "Weather",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ),
            Text(
              "Location Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name"),
                            Text(weatherResponseModel.location!.name.toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("region"),
                            Text(weatherResponseModel.location!.region
                                .toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("country"),
                            Text(weatherResponseModel.location!.country
                                .toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("lat"),
                            Text(weatherResponseModel.location!.lat.toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("lon"),
                            Text(weatherResponseModel.location!.lon.toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("tz_id"),
                            Text(weatherResponseModel.location!.tzId.toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("localtime_epoch"),
                            Text(weatherResponseModel.location!.localtimeEpoch
                                .toString())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Current Weather Data",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("tempC"),
                            Text(weatherResponseModel.current!.tempC.toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("tempF"),
                            Text(weatherResponseModel.current!.tempF.toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("condition"),
                            Text(weatherResponseModel.current!.condition!.text
                                .toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("windMph"),
                            Text(weatherResponseModel.current!.windMph
                                .toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("windDegree"),
                            Text(weatherResponseModel.current!.windDegree
                                .toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("pressureMb"),
                            Text(weatherResponseModel.current!.pressureMb
                                .toString())
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("feelslikeC"),
                            Text(weatherResponseModel.current!.feelslikeC
                                .toString())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  static String _displayStringForOption(City option) => option.name;
}

// class AutocompleteExampleApp extends StatelessWidget {
//   const AutocompleteExampleApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: AutocompleteBasicUserExample(),
//     );
//   }
// }

// @immutable
// class User {
//   const User({
//     required this.email,
//     required this.name,
//   });

//   final String email;
//   final String name;

//   @override
//   String toString() {
//     return '$name, $email';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (other.runtimeType != runtimeType) {
//       return false;
//     }
//     return other is User && other.name == name && other.email == email;
//   }

//   @override
//   int get hashCode => hashValues(email, name);
// }

// class AutocompleteBasicUserExample extends StatelessWidget {
//   const AutocompleteBasicUserExample({Key? key}) : super(key: key);

//   static const List<User> _userOptions = <User>[
//     User(name: 'Alice', email: 'alice@example.com'),
//     User(name: 'Bob', email: 'bob@example.com'),
//     User(name: 'Charlie', email: 'charlie123@gmail.com'),
//   ];

//   static String _displayStringForOption(User option) => option.name;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 25),
//       child: Autocomplete<User>(
//         displayStringForOption: _displayStringForOption,
//         optionsBuilder: (TextEditingValue textEditingValue) {
//           if (textEditingValue.text == '') {
//             return const Iterable<User>.empty();
//           }
//           return _userOptions.where((User option) {
//             return option
//                 .toString()
//                 .contains(textEditingValue.text.toLowerCase());
//           });
//         },
//         onSelected: (User selection) {
//           debugPrint('You just selected ${_displayStringForOption(selection)}');
//         },
//       ),
//     );
//   }
// }
