import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nomix/features/app/state/app_page_bloc.dart';
import 'package:nomix/features/approve_receipts_page/ui/state/approve_reciepts_bloc.dart';
import 'package:nomix/features/detail_statistic_page/ui/state/detail_statistic_bloc.dart';
import 'package:nomix/features/home_page/ui/state/home_page_bloc.dart';

List<BlocProvider> buildListProviders({required GetIt locator}) {
  return <BlocProvider>[
    BlocProvider<DetailStatisticBloc>(create: (context) => locator<DetailStatisticBloc>()),
    BlocProvider<AppPageBloc>(create: (context) => locator<AppPageBloc>()),
    BlocProvider<HomePageBloc>(create: (context) => locator<HomePageBloc>()),
    BlocProvider<ApproveReceiptsBloc>(create: (context) => locator<ApproveReceiptsBloc>()),
  ];
}
