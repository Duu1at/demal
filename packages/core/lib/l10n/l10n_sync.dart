import 'package:core/l10n/app_localizations.dart';
import 'package:core/l10n/l10n_service.dart';
import 'package:flutter/material.dart';

class L10nSync extends StatelessWidget {
  const L10nSync({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _L10nSyncDelegate(child: child);
  }
}

class _L10nSyncDelegate extends StatefulWidget {
  const _L10nSyncDelegate({required this.child});

  final Widget child;

  @override
  State<_L10nSyncDelegate> createState() => _L10nSyncDelegateState();
}

class _L10nSyncDelegateState extends State<_L10nSyncDelegate> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localizations = Localizations.of<AppLocalizations>(context, AppLocalizations);
    if (localizations != null) {
      L10nService.instance.localizations = localizations;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
