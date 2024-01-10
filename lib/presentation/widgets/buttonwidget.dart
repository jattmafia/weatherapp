import 'package:flutter/material.dart';
import 'package:weather/core/appcolors.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CommonButton({required this.onPressed,required this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed,
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: AppColors.buttonColor,
    minWidth: double.infinity,
    height: 50,
    child: Text(text,),
    
    );
  }
}