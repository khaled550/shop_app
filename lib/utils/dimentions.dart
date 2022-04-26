import 'package:flutter/material.dart';

class Dimentions {
  static Size? size;
  static double dp60 = 60;
  static double dp330 = 330;
  static double dp160 = 160;
  static double dp280 = 280;

  static initDimentions(BuildContext context) {
    size = MediaQuery.of(context).size;
    print("Device height: ${size!.height}");
    print(dp160);

    dp60 = size!.height / getSizeFactor(dp60);
    dp330 = size!.height / getSizeFactor(dp330);
    dp160 = size!.height / getSizeFactor(dp160);
    dp280 = size!.height / getSizeFactor(dp280);
  }

  static double getSizeFactor(double dp) => 926 / dp;
}
