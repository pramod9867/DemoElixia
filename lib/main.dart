import 'package:demo_elixia/bloc/weather_bloc/weather_bloc.dart';
import 'package:demo_elixia/bloc/weather_bloc/weather_event.dart';
import 'package:demo_elixia/framework/network/service/weatherservice.dart';
import 'package:demo_elixia/screens/weather_screen/weatherscreen.dart';
// import 'package:demo_elixia/screens/weather_screen/weather_main.dart';
import 'package:demo_elixia/widget/base_widget.dart/app_base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Google Place API are paid so i added dummy text inside city tab ====>

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Demo App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AppBaseView(
          child: BlocProvider(
        create: (_) => WeatherBloc(
          WeatherService(),
        ),
        child: WeatherScreen(),
      )),
    );
  }
}
