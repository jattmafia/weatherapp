import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/selectlocation/bloc/selectlocation_bloc.dart';
import 'package:weather/core/appcolors.dart';
import 'package:weather/core/textstyles.dart';
import 'package:weather/presentation/screens/dashboard/dashboardscreen.dart';
import 'package:weather/presentation/widgets/buttonwidget.dart';
import 'package:weather/presentation/widgets/textfieldwidget.dart';

import '../../../blocs/dashboardbloc/bloc/dashboard_bloc.dart';

class LoctationPick extends StatelessWidget {
  static const String routename = "LocationPick";
  LoctationPick({super.key});
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<SelectlocationBloc, SelectlocationState>(
            listener: (context, state) {
              if (state is SelectlocationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyles.error,
                    ),
                    backgroundColor: AppColors.errorColor,
                  ),
                );
              }
              if(state is SelectLocationSucceed){
                 context.read<DashboardBloc>().add(DashboardgetWeatherRequest());
                Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.dashboardRoute, (route) => false);
                
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 250,
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonTextField(
                      controller: _cityController, labelText: "City"),
                  const SizedBox(
                    height: 12,
                  ),
                  CommonTextField(
                    controller: _zipController,
                    labelText: "Zip Code",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  state is SelectLocationLoading
                      ? CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        )
                      : CommonButton(
                          onPressed: () {
                            context.read<SelectlocationBloc>().add(
                                LocationRequest(
                                    city: _cityController.text,
                                    zipCode: _zipController.text));
                          },
                          text: "Select Location"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OR",
                    style: TextStyles.heading2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state is SelectLocationLoadingCurrent
                      ? CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        )
                      : CommonButton(
                          onPressed: () {
                            context
                                .read<SelectlocationBloc>()
                                .add(CurrentLocationRequest());
                          },
                          text: "Current Location"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
