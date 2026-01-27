import 'package:app/core/core.dart';
import 'package:app_ui/spacing/app_spacing.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConnectivityAppBar({
    required this.title,
    super.key,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, InternetStatus>(
      builder: (context, state) {
        return AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state == InternetStatus.disconnected) ...[
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CupertinoActivityIndicator(),
                ),
                const SizedBox(width: AppSpacing.md),
                Text(
                  context.l10n.waitingForNetwork,
                  style: Theme.of(context).primaryTextTheme.labelSmall,
                ),
              ] else ...[
                Text(title),
              ],
            ],
          ),
          leading: leading,
          actions: actions,
          centerTitle: centerTitle,
          backgroundColor: backgroundColor,
          elevation: elevation,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
