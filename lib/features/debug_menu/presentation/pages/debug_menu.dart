import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/features/app/routing/route_path.dart';
import 'package:nomix/features/debug_menu/presentation/pages/network_logs.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:logger/src/logger_list_class.dart';

class DebugMenu extends StatefulWidget {
  const DebugMenu({required this.backRoutePath, super.key});

  static String name = RoutePath.debugMenuPath;

  final String backRoutePath;

  @override
  State<DebugMenu> createState() => _MadInspectorViewState();
}

class _MadInspectorViewState extends State<DebugMenu> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black50,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        leadingWidth: 30,
        title: Text(
          'V1.0.0+5',
          style: AppTypography.font14Regular.copyWith(color: AppColors.white),
        ),
        leading: TapAnimator(
            onTap: () {
              context.pushNamed(RoutePath.initPagePath);
            },
            child: const Icon(
              Icons.keyboard_backspace_rounded,
              size: 50,
            )),
        toolbarHeight: 40.0,
        backgroundColor: AppColors.black50,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.red,
          tabs: <Widget>[
            Tab(
              icon: Text(
                "Deatail net",
                style: AppTypography.font16Regular.copyWith(fontSize: 16, color: AppColors.white),
              ),
            ),
            Tab(
              icon: Text('Network', style: AppTypography.font16Regular.copyWith(fontSize: 16, color: AppColors.white)),
            ),
            Tab(
              icon: Text(
                'Local log',
                style: AppTypography.font16Regular.copyWith(fontSize: 16, color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const Center(
            child: Text('data'),
          ),
          const Center(child: NetworkLogs()),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: LocalLoggerList.loggerModelStringList.length,
                itemBuilder: (context, index) {
                  final data =
                      LocalLoggerList.loggerModelStringList[LocalLoggerList.loggerModelStringList.length - 1 - index];
                  return Container(
                    decoration: BoxDecoration(borderRadius: AppCorners.radius15, color: getLogColor(data.color)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRichText('StackTrace', data.stackTrace.toString()),
                          buildRichText('Message', data.message.toString()),
                          buildRichText('Error', data.error.toString()),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getLogColor(LogColor? logColor) {
    switch (logColor) {
      case LogColor.i:
        return AppColors.primaryBlueLight.withOpacity(0.5);
      case LogColor.w:
        return AppColors.orangeFood.withOpacity(0.5);
      case LogColor.d:
        return AppColors.pinkAccent.withOpacity(0.5);
      case LogColor.e:
        return AppColors.red.withOpacity(0.5);
      default:
        return AppColors.gray.withOpacity(0.5);
    }
  }

  RichText buildRichText(String title, String value) {
    return RichText(
      text: TextSpan(
        style: AppTypography.font14Regular,
        children: [
          TextSpan(
            text: '$title:    ',
            style: AppTypography.font14Regular.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
