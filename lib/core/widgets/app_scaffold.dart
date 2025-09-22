import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/utils/get_it_utils.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/background-beam/background_beam_demo.dart';
import 'package:nomix/features/app/routing/route_path.dart';

class AppScaffold extends StatefulWidget {
  final String title;
  final String? photoUrl;
  final Widget body;
  final Widget? leadingWidget;

  const AppScaffold({super.key, required this.title, this.photoUrl, this.leadingWidget, required this.body});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: AppBar(
          leadingWidth: 40,
          backgroundColor: AppColors.bgWhite,
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(
              minWidth: kToolbarHeight,
              minHeight: kToolbarHeight,
            ),
            child: widget.leadingWidget ??
                TapAnimator(
                  onTap: () {
                    context.goNamed(RoutePath.debugMenuPath);
                  },
                  child: SvgPicture.asset(
                    VectorAssets.notif,
                    width: 24,
                    height: 24,
                  ),
                ),
          ),
          centerTitle: true,
          title: Text(
            widget.title,
            style: AppTypography.font15Regular.copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              constraints: const BoxConstraints(
                minWidth: kToolbarHeight,
                minHeight: kToolbarHeight,
              ),
              child: TapAnimator(
                  onTap: () {
                    // действие по нажатию на аватар
                  },
                  child: _buildAvatar(widget.photoUrl)),
            ),
          ],
        ),
        body: Stack(
          children: [
            // BackgroundBeamDemo(),
            widget.body,
          ],
        ));
  }

  String _proxySvgUrl(String original) {
    final encoded = Uri.encodeComponent(original);
    GetItUtils.logger.w('encodedencodedencoded:$encoded');

    return 'https://api.allorigins.win/raw?url=$encoded';
  }

  Widget _buildAvatar(String? photoUrl) {
    if (photoUrl == null || photoUrl.isEmpty) {
      return _placeholder(); // твоя заглушка
    }

    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage(photoUrl),
      onBackgroundImageError: (_, __) => setState(() => photoUrl = null),
    );
  }

  Widget _placeholder() => const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Text('🐼'),
      );
}
