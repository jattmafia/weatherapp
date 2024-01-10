import 'package:flutter/material.dart';
import 'package:weather/core/routeArguments.dart';
import 'package:weather/presentation/screens/dashboard/dashboardscreen.dart';
import 'package:weather/presentation/screens/locationpick/locationpick.dart';
import 'package:weather/presentation/screens/map/mapscreen.dart';

class Routes {
  static Route? ongeneratedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case DashBoardScreen.dashboardRoute:
        return MaterialPageRoute(builder: (context) => DashBoardScreen());

      case LoctationPick.routename:
        return MaterialPageRoute(builder: (context) => LoctationPick());

      case MapScreen.mapRoute:
       var args = settings.arguments as MapArguments;
        return MaterialPageRoute(builder: (context) => MapScreen(args));

      default:
        return null;
    }
  }
}
