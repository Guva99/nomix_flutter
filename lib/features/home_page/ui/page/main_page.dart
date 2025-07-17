import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/app_scaffold.dart';
import 'package:nomix/core/widgets/list_title_container_widget.dart';
import 'package:nomix/features/app/routing/route_path.dart';
import 'package:nomix/features/home_page/ui/widgets/spending_chart_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'NOMIX AI',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TapAnimator(
              onTap: () {},
              child: Container(
                height: 130,
                decoration: BoxDecoration(borderRadius: AppCorners.radius10, gradient: AppColors.gradient),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Добавить чек',
                        style:
                            AppTypography.font26Regular.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Image(image: AssetImage(ImageAssets.scann))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SpendingChart(),
            ),
            ListTileContainerWidget(
              onTap: () {
                context.pushNamed(RoutePath.detailPageStatisticPath);
              },
              leadingPath: ImageAssets.statistic,
              title: 'Детальная статистика ',
            ),
            const ListTileContainerWidget(
              leadingPath: ImageAssets.reciepts,
              title: 'Мои чеки',
            ),
            const ListTileContainerWidget(
              leadingPath: ImageAssets.techique,
              title: 'Техническая поддержка',
            ),
          ],
        ),
      ),
    );
  }
}
