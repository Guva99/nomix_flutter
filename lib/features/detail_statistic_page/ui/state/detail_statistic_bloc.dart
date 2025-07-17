import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:nomix/core/enums/filtered_date_enum.dart';
import 'package:nomix/features/detail_statistic_page/domain/entity.dart';
import 'package:tuple/tuple.dart';

part 'detail_statistic_event.dart';

part 'detail_statistic_state.dart';

@lazySingleton
class DetailStatisticBloc extends Bloc<DetailStatisticEvent, DetailStatisticState> {
  DetailStatisticBloc() : super(
    DetailStatisticSuccess(
      category: categories,
      filters: { for (var c in categories) c.id: FilteredDateEnum.Week},
    ),
  ) {
    on<GetDetailStatisticData>(_onGetDetailStatisticData);
    on<FilterCategoryChanged>(_onFilterCategoryChanged); // ← вот это нужно
  }

  final List<CategoryProduct> _originalCategories = categories;

  void _onGetDetailStatisticData(GetDetailStatisticData e, Emitter<DetailStatisticState> emit) {
    emit(DetailStatisticSuccess(
      category: _originalCategories,
      filters: state is DetailStatisticSuccess
          ? (state as DetailStatisticSuccess).filters
          : { for (var c in _originalCategories) c.id: FilteredDateEnum.Week},
    ));
  }

  void _onFilterCategoryChanged(FilterCategoryChanged e, Emitter<DetailStatisticState> emit) {
    final prev = state as DetailStatisticSuccess;
    final newFilters = {...prev.filters, e.categoryId: e.filter};

    final now = DateTime.now().toUtc();
    final periodStart = {
      FilteredDateEnum.Day:   DateTime(now.year, now.month, now.day),
      FilteredDateEnum.Week:  now.subtract(Duration(days: 7)),
      FilteredDateEnum.Month: now.subtract(Duration(days: 30)),
    }[e.filter]!;

    final filteredCats = _originalCategories.map((cat) {
      if (cat.id != e.categoryId) return cat;

      final newPaths = cat.foodPath.map((fp) {
        final list = fp.products.where((p) {
          final dt = DateTime.parse(p.data).toUtc();
          return !dt.isBefore(periodStart) && !dt.isAfter(now);
        }).toList();

        return FoodPath(
          title: fp.title,
          price: fp.price,
          products: list,
        );
      }).toList();

      // Здесь создаём новую категорию через конструктор:
      return CategoryProduct(
        id:       cat.id,
        image:    cat.image,
        title:    cat.title,
        price:    cat.price,
        color:    cat.color,
        foodPath: newPaths,
      );
    }).toList();

    emit(DetailStatisticSuccess(category: filteredCats, filters: newFilters));
  }

}


  Tuple2<DateTime, DateTime> _parseRange(String data) {
  final now = DateTime.now();

  DateTime parseSingle(String s) {
    final parts = s.trim().split('.');
    if (parts.length == 3) {
      // dd.MM.yy
      final d = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      final y = 2000 + int.parse(parts[2]);
      return DateTime(y, m, d);
    } else if (parts.length == 2) {
      // dd.MM
      final d = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      return DateTime(now.year, m, d);
    } else {
      throw FormatException('Invalid date format: $s');
    }
  }

  // Сплитим и на дефис, и на длинное тире:
  final splitter = RegExp(r'\s*[–-]\s*');
  final parts = data.split(splitter);

  if (parts.length == 2) {
    final start = parseSingle(parts[0]);
    final end   = parseSingle(parts[1]);
    return Tuple2(start, end);
  } else {
    final day = parseSingle(data);
    return Tuple2(day, day);
  }
}