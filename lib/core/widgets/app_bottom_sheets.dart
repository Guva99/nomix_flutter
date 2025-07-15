import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/dismiss_keyboard_tapper.dart';


class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.child,
    this.maxHeight,
    this.minHeight = 0,
    this.padding = EdgeInsets.zero,
    this.color,
    super.key,
  });

  final Widget child;
  final double? maxHeight;
  final double minHeight;
  final EdgeInsetsGeometry padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color ?? AppColors.gray,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          ),
          child: Padding(
            padding: padding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? MediaQuery.of(context).size.height - kToolbarHeight - 48,
                minHeight: minHeight,
              ),
              child: child,
            ),
          ),
        ),
        Positioned(
          top: 14,
          child: Container(
            height: 4,
            width: 52,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              color: AppColors.black50,
            ),
          ),
        ),
      ],
    );
  }
}

Future<T?> showCustomSheet<T>({
  required BuildContext context,
  String? title,
  Color? bgColor,
  Widget? titleWidget,
  EdgeInsets padding = EdgeInsets.zero,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = true,
  Alignment titleAlign = Alignment.center,
}) async {
  return _showBaseSheet<T>(
    color: AppColors.white,
    context: context,
    padding: padding,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useRootNavigator: useRootNavigator,
    builder:
        (BuildContext context) => SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (titleWidget != null) titleWidget,
                if (title != null && title.isNotEmpty == true)
                  Align(
                    alignment: titleAlign,
                    child: Text(
                      title,
                      style: AppTypography.font18Regular.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: (title != null && title.isNotEmpty == true) ? 16 : 0, bottom: 0),
                  child: builder(context),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
  );
}

Future<T?> _showBaseSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  EdgeInsets padding = EdgeInsets.zero,
  bool isDismissible = true,
  bool enableDrag = true,
  bool isScrollable = true,
  bool useRootNavigator = true,
  Color? color = AppColors.white,
}) {
  return _showBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext bottomSheetContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: DismissKeyboardTapper(
          child: AppBottomSheet(
            color: color,
            padding: EdgeInsets.only(top: padding.top),
            child: SingleChildScrollView(
              padding: padding.copyWith(top: 0),
              physics: isScrollable ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
              child: builder(bottomSheetContext),
            ),
          ),
        ),
      );
    },
  );
}

Future<T?> _showBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useRootNavigator = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.white.withOpacity(0.6),
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: true,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext bottomSheetContext) {
      return builder(bottomSheetContext);
    },
  );
}
