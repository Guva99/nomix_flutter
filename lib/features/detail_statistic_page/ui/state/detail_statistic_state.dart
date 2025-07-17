part of 'detail_statistic_bloc.dart';

@immutable
class DetailStatisticState extends Equatable {
  const DetailStatisticState();

  @override
  List<Object?> get props => <Object?>[];
}

final class DetailStatisticInitial extends DetailStatisticState {}

class DetailStatisticSuccess extends DetailStatisticState {
  final List<CategoryProduct> category;
  final Map<int,FilteredDateEnum> filters;

  const DetailStatisticSuccess({
    required this.category,
    required this.filters,
  });
}

