import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nomix/core/enums/filtered_date_enum.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/app_scaffold.dart';
import 'package:nomix/features/app/routing/route_path.dart';
import 'package:nomix/features/detail_statistic_page/domain/entity.dart';
import 'package:nomix/features/detail_statistic_page/ui/state/detail_statistic_bloc.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/category_element_widget.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/stats_card_widget.dart';
import 'package:nomix/features/home_page/ui/page/home_page.dart';

class DetailStatisticPage extends StatefulWidget {
  const DetailStatisticPage({super.key});

  @override
  State<DetailStatisticPage> createState() => _DetailStatisticPageState();
}

class _DetailStatisticPageState extends State<DetailStatisticPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    context.read<DetailStatisticBloc>().add(const GetDetailStatisticData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      leadingWidget: TapAnimator(
        onTap: () {
          context.pushNamed(RoutePath.mainPage);
        },
        child: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      title: 'Статистика',
      body: BlocBuilder<DetailStatisticBloc, DetailStatisticState>(
        builder: (context, state) {
          if (state is DetailStatisticSuccess) {
            final cats = state.category;
            final filters = state.filters;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: false,
                  floating: false,
                  snap: false,
                  automaticallyImplyLeading: false,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: StatsCard(),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final cat = cats[index];
                        final filter = filters[cat.id]!;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CategoryElementWidget(
                            data: cat,
                            scrollController: _scrollController,
                            selectedFilter: filter,
                            onFilterChanged: (newFilter) {
                              context.read<DetailStatisticBloc>().add(FilterCategoryChanged(cat.id, newFilter));
                            },
                          ),
                        );
                      },
                      childCount: cats.length,
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
