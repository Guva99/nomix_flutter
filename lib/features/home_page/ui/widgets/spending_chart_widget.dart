import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:nomix/core/enums/time_frame.dart';

import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';

class SpendingChart extends StatefulWidget {
  const SpendingChart({super.key});

  @override
  _SpendingChartState createState() => _SpendingChartState();
}

class _SpendingChartState extends State<SpendingChart> {
  TimeFrameEnum _selected = TimeFrameEnum.Week;
  late List<double> _points;
  late List<String> _labels;
  late List<DateTime> _dates;
  late double _total;

  static const List<String> _rusWeekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  static const List<String> _rusMonths = [
    'янв',
    'фев',
    'мар',
    'апр',
    'май',
    'июн',
    'июл',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек'
  ];

  @override
  void initState() {
    super.initState();
    _loadData(_selected);
  }

  void _loadData(TimeFrameEnum tf) {
    final data = _getDataForTimeFrame(tf);
    setState(() {
      _selected = tf;
      _points = data.points;
      _labels = data.labels;
      _dates = data.dates;
      _total = data.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildToggle(),
        const SizedBox(height: 24),
        _buildChart(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Всего трат', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        Text('${_total.toStringAsFixed(0)} ₽', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildToggle() {
    final labels = ['День', 'Неделя', 'Месяц', 'Год'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: TimeFrameEnum.values.map((tf) {
        final idx = TimeFrameEnum.values.indexOf(tf);
        final isSel = tf == _selected;
        return GestureDetector(
          onTap: () => _loadData(tf),
          child: Column(
            children: [
              Text(labels[idx],
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      color: isSel ? Colors.black : Colors.grey)),
              if (isSel)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 2,
                  width: 20,
                  color: Colors.black,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChart() {
    final spots = List<FlSpot>.generate(
      _points.length,
      (i) => FlSpot(i.toDouble(), _points[i]),
    );

    return SizedBox(
      height: 240,
      child: LineChart(LineChartData(
        minX: 0,
        maxX: (_points.length - 1).toDouble(),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= _labels.length) return const SizedBox();
                switch (_selected) {
                  case TimeFrameEnum.Day:
                    if (idx % 3 != 0) return const SizedBox();
                    break;
                  case TimeFrameEnum.Week:
                    break;
                  case TimeFrameEnum.Month:
                    final mid = (_labels.length / 2).floor();
                    if (idx != 0 && idx != mid && idx != _labels.length - 1) {
                      return const SizedBox();
                    }
                    break;
                  case TimeFrameEnum.Year:
                    final date = _dates[idx];
                    if (date.day == 1 && (date.month - 1) % 3 == 0) {
                      const rus = ['Янв', 'Апр', 'Июл', 'Окт'];
                      return textWidget(rus[(date.month - 1) ~/ 3]);
                    }
                    return const SizedBox();
                }
                return textWidget(_labels[idx]);
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.accentColor,
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: true, gradient: AppColors.gradient2),
          ),
        ],
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => Colors.white,
            tooltipRoundedRadius: 4,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((t) {
                final i = t.x.toInt();
                final date = _dates[i];
                final formatted = _formatTooltipDate(date, _selected);
                final value = _points[i].toStringAsFixed(0);
                return LineTooltipItem(
                  '$formatted\n$value ₽',
                  const TextStyle(color: Colors.black, fontSize: 12),
                );
              }).toList();
            },
          ),
          getTouchedSpotIndicator: (bar, spots) => spots.map((spot) {
            return TouchedSpotIndicatorData(
              FlLine(color: Colors.white, strokeWidth: 1, dashArray: [4, 4]),
              FlDotData(show: true),
            );
          }).toList(),
        ),
      )),
    );
  }

  Widget textWidget(String idx) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0,left: 35,right: 25,),
      child: Text(idx, style: AppTypography.font12Regular),
    );
  }

  String _formatTooltipDate(DateTime dt, TimeFrameEnum tf) {
    switch (tf) {
      case TimeFrameEnum.Day:
        return '${dt.hour.toString().padLeft(2, '0')}:00';
      case TimeFrameEnum.Week:
        return _rusWeekdays[dt.weekday - 1];
      case TimeFrameEnum.Month:
        return dt.day.toString();
      case TimeFrameEnum.Year:
        // Добавляем год в формат
        final day = dt.day;
        final month = _rusMonths[dt.month - 1];
        final year = dt.year;
        return '$day $month $year';
    }
  }

  TimeFrameData getEmptyDataForTimeFrame(TimeFrameEnum tf) {
    final now = DateTime.now();
    late List<double> pts;
    late List<String> lbls;
    late List<DateTime> dates;

    switch (tf) {
      case TimeFrameEnum.Day:
        // часы с 0 до текущего
        final count = now.hour + 1;
        dates = List.generate(count, (i) => DateTime(now.year, now.month, now.day, i));
        lbls = List.generate(count, (i) => '${i}ч');
        pts = List.filled(count, 0.0);
        break;

      case TimeFrameEnum.Week:
        // понедельник–воскресенье
        final start = now.subtract(Duration(days: now.weekday - 1));
        dates = List.generate(7, (i) => start.add(Duration(days: i)));
        lbls = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
        pts = List.filled(7, 0.0);
        break;

      case TimeFrameEnum.Month:
        // все дни месяца
        final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        dates = List.generate(daysInMonth, (i) => DateTime(now.year, now.month, i + 1));
        lbls = List.generate(daysInMonth, (i) => '${i + 1}');
        pts = List.filled(daysInMonth, 0.0);
        break;

      case TimeFrameEnum.Year:
        // от 1 января до сегодня
        final startOfYear = DateTime(now.year, 1, 1);
        final daysCount = now.difference(startOfYear).inDays + 1;
        dates = List.generate(daysCount, (i) => startOfYear.add(Duration(days: i)));
        lbls = List.generate(daysCount, (i) => '${dates[i].day}');
        pts = List.filled(daysCount, 0.0);
        break;
    }

    // Общая сумма = 0
    return TimeFrameData(pts, lbls, dates, 0.0);
  }

  TimeFrameData _getDataForTimeFrame(TimeFrameEnum tf) {
    final now = DateTime.now();
    late List<double> pts;
    late List<String> lbls;
    late List<DateTime> dates;

    switch (tf) {
      case TimeFrameEnum.Day:
        final count = now.hour + 1;
        pts = List.generate(count, (i) => (i * 5.0 % 120) + 20);
        lbls = List.generate(count, (i) => '${i}ч');
        dates = List.generate(count, (i) => DateTime(now.year, now.month, now.day, i));
        break;

      case TimeFrameEnum.Week:
        final start = now.subtract(Duration(days: now.weekday - 1));
        pts = [600, 540, 610, 580, 620, 590, 630].map((e) => e.toDouble()).toList();
        lbls = _rusWeekdays;
        dates = List.generate(7, (i) => start.add(Duration(days: i)));
        break;

      case TimeFrameEnum.Month:
        final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        pts = List.generate(daysInMonth, (i) => (i * 10.0 % 500) + 100);
        lbls = List.generate(daysInMonth, (i) => '${i + 1}');
        dates = List.generate(daysInMonth, (i) => DateTime(now.year, now.month, i + 1));
        break;

      case TimeFrameEnum.Year:
        // 1 января –– до сегодня включительно
        final startOfYear = DateTime(now.year, 1, 1);
        final daysCount = now.difference(startOfYear).inDays + 1;

        // 1) Формируем сами даты:
        dates = List.generate(
          daysCount,
          (i) => startOfYear.add(Duration(days: i)),
        );

        // 2) Метки — просто номер дня (рендерить вы будете только первые/средние/последние)
        lbls = List.generate(
          daysCount,
          (i) => '${dates[i].day}',
        );

        // 3) Точки графика (статично; позже замените на бэкенд-данные)
        pts = List.generate(
          daysCount,
          (i) => (i * 50.0 % 2000) + 500,
        );
        break;
    }

    final total = pts.fold(0.0, (sum, v) => sum + v);
    return TimeFrameData(pts, lbls, dates, total);
  }
}

class TimeFrameData {
  final List<double> points;
  final List<String> labels;
  final List<DateTime> dates;
  final double total;

  TimeFrameData(this.points, this.labels, this.dates, this.total);
}
