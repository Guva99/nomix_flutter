import 'package:flutter/material.dart';
import 'package:nomix/core/widgets/app_scaffold.dart';
import 'package:nomix/features/detail_statistic_page/domain/entity.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/category_element_widget.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/stats_card_widget.dart';
import 'package:nomix/features/home_page/ui/page/main_page.dart';

class DetailStatisticPage extends StatefulWidget {
  const DetailStatisticPage({super.key});

  @override
  State<DetailStatisticPage> createState() => _DetailStatisticPageState();
}

class _DetailStatisticPageState extends State<DetailStatisticPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Статистика',
      body: CustomScrollView(
        controller: _scrollController,
        // ← здесь
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
                  final data = categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CategoryElementWidget(
                      data: data,
                      scrollController: _scrollController, // ← и сюда
                    ),
                  );
                },
                childCount: categories.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
