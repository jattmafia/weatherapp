class SpeedConvert {
  static String getspeed({required double speed}) {
    var newspeed = speed * 3.6;

    return newspeed.toString();
  }
}
