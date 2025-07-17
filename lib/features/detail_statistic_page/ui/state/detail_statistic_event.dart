part of 'detail_statistic_bloc.dart';

@immutable
abstract class DetailStatisticEvent extends Equatable {
  const DetailStatisticEvent();

  @override
  List<Object?> get props => [];
}


class GetDetailStatisticData  extends DetailStatisticEvent {
  const GetDetailStatisticData();
}

 class FilterCategoryChanged extends DetailStatisticEvent {
  final int categoryId;
  final FilteredDateEnum filter;

  const FilterCategoryChanged(this.categoryId, this.filter);
}
