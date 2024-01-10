import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/dashboardbloc/bloc/dashboard_bloc.dart';
import 'package:weather/blocs/selectlocation/bloc/selectlocation_bloc.dart';
import 'package:weather/core/routes.dart';
import 'package:weather/presentation/screens/locationpick/locationpick.dart';


import 'core/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectlocationBloc>(
          create: (BuildContext context) => SelectlocationBloc(),
        ),

        BlocProvider<DashboardBloc>(
          create: (BuildContext context) => DashboardBloc(),
        ),

       
      ],
      child: MaterialApp(
       onGenerateRoute: Routes.ongeneratedRoutes,
        initialRoute: LoctationPick.routename,
        title: 'Weather',
        theme: Themes.defaultTheme,
       
      ),
    );
  }
}
