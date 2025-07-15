
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsCard extends StatefulWidget {
  @override
  _StatsCardState createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  // Полный список месяцев
  final List<String> _months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];
  String _selectedMonth = 'Май';

  // Ваши категории + цвета
  final Map<String, Color> _categoryColors = {
    'Еда и напитки': Colors.orange,
    'Одежда': Colors.purple,
    'Транспорт': Colors.black87,
    'Здоровье': Colors.yellow,
    'Дом и ЖКХ': Colors.brown, // можно заменить на любой цвет
    'Прочее': Colors.green,
  };

  // Для каждого месяца — список из 6 рандомных значений
  late final Map<String, List<double>> _valuesByMonth;

  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    // Генерируем для каждого месяца свой набор рандомных данных
    _valuesByMonth = {
      for (var m in _months) m: List.generate(_categoryColors.length, (_) => _rnd.nextDouble() * 5000 + 1000)
    };
  }

  @override
  Widget build(BuildContext context) {
    final cats = _categoryColors.keys.toList();
    final colors = _categoryColors.values.toList();
    final vals = _valuesByMonth[_selectedMonth]!;

    // общая сумма
    final total = vals.fold<double>(0, (sum, v) => sum + v);

    // строим группы: по одной колонке на категорию
    final barGroups = List.generate(cats.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: vals[i],
            width: 16, // В ДВА РАЗА ТОНЬШЕ
            color: colors[i],
          ),
        ],
      );
    });

    // определяем верхнюю границу Y с небольшим отступом
    final maxY = (vals.reduce(max) * 1.2).ceilToDouble();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок + сумма + выбор месяца
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Итоговая траты'),
                    const SizedBox(height: 4),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                    ),
                  ],
                ),
                DropdownButton<String>(
                  value: _selectedMonth,
                  underline: const SizedBox(),
                  onChanged: (m) {
                    if (m != null) setState(() => _selectedMonth = m);
                  },
                  items: _months.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // сам график
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  barGroups: barGroups,
                  groupsSpace: 20,
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    horizontalInterval: maxY / 4,
                    getDrawingHorizontalLine: (y) => FlLine(color: Colors.grey.shade300, dashArray: [5, 5]),
                    drawVerticalLine: false,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: const AxisTitles(
                      // sideTitles: SideTitles(
                      //   showTitles: true,
                      //   reservedSize: 36,
                      //   // getTitlesWidget: (v, meta) {
                      //   //   final idx = v.toInt();
                      //   //   return SideTitleWidget(
                      //   //     meta: meta,
                      //   //     space: 4,
                      //   //     child: Text(
                      //   //       '',
                      //   //       style: const TextStyle(
                      //   //           color: Colors.black54, fontSize: 10),
                      //   //       textAlign: TextAlign.center,
                      //   //     ),
                      //   //   );
                      //   // },
                      // ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: maxY / 4,
                        getTitlesWidget: (v, meta) {
                          if (v == 0) return const SizedBox.shrink();
                          return SideTitleWidget(
                            meta: meta,
                            child: Text('\$${v.toInt()}', style: const TextStyle(color: Colors.black54, fontSize: 10)),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      // скругление рамки тултипа
                      tooltipBorderRadius: BorderRadius.circular(8),
                      // паддинги внутри тултипа
                      tooltipPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      // отступ от столбца
                      tooltipMargin: 4,
                      // колбэк для фона тултипа
                      getTooltipColor: (BarChartGroupData group) {
                        // group.x — индекс группы, по нему достаём категорию
                        final idx = group.x;
                        final category = cats[idx];
                        // возвращаем нужный цвет, можно с прозрачностью:
                        return Colors.white;
                      },
                      // колбэк контента тултипа (название + сумма)
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final idx = group.x.toInt();
                        final name = cats[idx];
                        return BarTooltipItem(
                          '$name\n\$${rod.toY.toStringAsFixed(2)}',
                          TextStyle(
                            color: _categoryColors[name],
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}