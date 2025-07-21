

import 'package:intl/intl.dart';
import 'package:nomix/core/enums/filtered_date_enum.dart';

abstract class BusinessUtils {


  ///Static AppVersion
  static const appVersion = '0.1.0';

 static String formatPeriod(FilteredDateEnum filter, String iso) {
    final now = DateTime.now();
    final weekAgo  = now.subtract(Duration(days: 7));
    final monthAgo = now.subtract(Duration(days: 30));

    final dfDay   = DateFormat('dd.MM.yy');
    final dfShort = DateFormat('dd.MM');

    switch (filter) {
      case FilteredDateEnum.Day:
      // выводим именно день из iso (или просто today)
        return dfDay.format(DateTime.parse(iso));
      case FilteredDateEnum.Week:
        return '${dfShort.format(weekAgo)} - ${dfShort.format(now)}';
      case FilteredDateEnum.Month:
        return '${dfShort.format(monthAgo)} - ${dfShort.format(now)}';
    }
  }
}
