import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/blocs/dashboardbloc/bloc/dashboard_bloc.dart';
import 'package:weather/core/appcolors.dart';
import 'package:weather/core/routeArguments.dart';
import 'package:weather/core/textstyles.dart';
import 'package:weather/data/model/fivedayweather.dart';
import 'package:weather/data/model/weathermodel.dart';
import 'package:weather/presentation/screens/locationpick/locationpick.dart';
import 'package:weather/presentation/screens/map/mapscreen.dart';
import 'package:weather/presentation/widgets/dateparse.dart';
import 'package:weather/presentation/widgets/forecastlist.dart';
import 'package:weather/presentation/widgets/speedconvert.dart';
import 'package:weather/utils/constants.dart';

// ignore: must_be_immutable
class DashBoardScreen extends StatelessWidget {
  static const dashboardRoute = "dashboard";

  DashBoardScreen({super.key});

  WeatherModel weatherModel = WeatherModel();

  FiveDayForecastModel fiveDayForecastModel = FiveDayForecastModel();

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DashboardSucceed) {
              weatherModel = state.weatherModel;
              fiveDayForecastModel = state.fiveDayForecastModel;
            }
          },
          builder: (context, state) {
            if (state is DashboardLoading) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: AppColors.buttonColor, size: 40),
              );
            }
            if (state is DashboardLoadingError) {
              return Center(
                  child: Text(
                state.error,
                style: TextStyles.error,
              ));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoctationPick.routename, (route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.buttonColor,
                          ),
                          Text(
                            weatherModel.name!,
                            style: TextStyles.heading3,
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      weatherModel.weather![0].main!,
                      style: TextStyles.heading3,
                    )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                                          context, MapScreen.mapRoute,
                                          arguments: MapArguments(
                                              weatherModel.main!.temp
                                                  .toString(),
                                              weatherModel.main!.humidity
                                                  .toString(),
                                              weatherModel.coord!.lat!,
                                              weatherModel.coord!.lon!));
                      },
                      child: Image.network(
                        "$iconUrl${weatherModel.weather![0].icon}@4x.png",
                        height: 160,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Center(
                        child: Text(
                      "${weatherModel.main!.temp} \u2103",
                      style: TextStyles.heading1,
                    )),
                    Center(
                        child: Text(
                      DateTimeParse.parsedate(
                          timestamp: weatherModel.dt.toString()),
                      style: TextStyles.heading3,
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        color: AppColors.cardColor,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    weatherModel.main!.pressure.toString(),
                                    style: TextStyles.heading3,
                                  ),
                                  Text(
                                    "Pressure",
                                    style: TextStyles.heading3,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${weatherModel.main!.humidity}%",
                                    style: TextStyles.heading3,
                                  ),
                                  Text(
                                    "Humidity",
                                    style: TextStyles.heading3,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    SpeedConvert.getspeed(
                                            speed: weatherModel.wind!.speed!)
                                        .toString()
                                        .substring(0, 4),
                                    style: TextStyles.heading3,
                                  ),
                                  Text(
                                    "Wind Speed",
                                    style: TextStyles.heading3,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          height: 150,
                          child: ForecastList(
                              fiveDayForecastModel: fiveDayForecastModel)),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
