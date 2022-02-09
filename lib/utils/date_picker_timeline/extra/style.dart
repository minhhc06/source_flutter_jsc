import 'package:flutter/material.dart';
import 'package:project_flutter/utils/date_picker_timeline/extra/color.dart';
import 'package:project_flutter/utils/date_picker_timeline/extra/dimen.dart';

const TextStyle defaultMonthTextStyle = TextStyle(
  color: AppColors.defaultMonthColor,
  fontSize: Dimen.monthTextSize,
  fontWeight: FontWeight.w500,
);

const TextStyle defaultDateTextStyle = TextStyle(
  color: AppColors.defaultDateColor,
  fontSize: Dimen.dateTextSize,
  fontWeight: FontWeight.w500,
);

const TextStyle defaultTodayTextStyle = TextStyle(
  color: AppColors.defaultToDayColor,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

const TextStyle defaultTodayTextStyleIsSelected = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

const TextStyle defaultDayTextStyle = TextStyle(
  color: AppColors.defaultDayColor,
  fontSize: Dimen.dayTextSize,
  fontWeight: FontWeight.w500,
);
