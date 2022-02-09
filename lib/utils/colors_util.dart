import 'package:flutter/material.dart';
import 'package:project_flutter/utils/convert_color_util.dart';

class ColorsUtil{
  static String colorApp = '#ffc107';
  static String yellowColorDialog = '#FFFF00';
  static String backgroundGray = '#F0F3F8';

  static String orange = '#F7AB2F';
  static String green = '#0A6836';
  static String blue = '#0d63f5';
  static String greenBottom = '#41AD49';
  static String purple = '#6F61FF';
  static String red = '#680A0A';
  static String redBottom = '#E86565';
  static String toastOtpColor = '#FFF7DA';
  static String toastOtpTextColor = '#E89806';
  static int colorGreen = 900;
  static int colorRed = 900;
  static String toastColorWarning = '#FFE7EC';
  static String toastTextColorWarning = '#E93C3C';

  static const Color grayColor = Colors.grey;
  static const Color blackColorBtn = Colors.black;
  static const Color whiteColorBtn = Colors.white;


  static  Color colorYellowDialog =  ConvertColorUtil(ColorsUtil.colorApp);
  static  Color colorOnTopGreen =  ConvertColorUtil(ColorsUtil.green);
  static  Color colorOnTopRed =  ConvertColorUtil(ColorsUtil.red);
  static  Color colorDownBottomGreen = ConvertColorUtil(ColorsUtil.greenBottom);
  static  Color colorDownBottomRed = ConvertColorUtil(ColorsUtil.redBottom);
}

