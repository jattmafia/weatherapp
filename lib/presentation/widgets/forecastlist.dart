import 'package:flutter/material.dart';
import 'package:weather/core/appcolors.dart';
import 'package:weather/core/textstyles.dart';
import 'package:weather/data/model/fivedayweather.dart';
import 'package:weather/presentation/widgets/dateparse.dart';

import '../../utils/constants.dart';

class ForecastList extends StatelessWidget {
  final FiveDayForecastModel fiveDayForecastModel;
  const ForecastList({super.key, required this.fiveDayForecastModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Card(
              elevation: 5,
              color: AppColors.cardColor,
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        DateTimeParse.parseday(
                            timestamp: fiveDayForecastModel.list![index * 8].dt
                                .toString()),
                        style: TextStyles.heading3,
                      ),
                      Image.network(
                        "$iconUrl${fiveDayForecastModel.list![index * 8].weather![0].icon}@4x.png",
                        height: 80,
                        fit: BoxFit.fitHeight,
                      ),

                      Text(
                    "${fiveDayForecastModel.list![index * 8].main!.temp} \u2103",
                    style: TextStyles.heading3,
                  )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
