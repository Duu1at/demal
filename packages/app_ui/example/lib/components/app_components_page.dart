import 'package:app_ui/app_ui.dart';
import 'package:example/main.dart';
import 'package:example/notifier/natifier.dart';
import 'package:flutter/material.dart' hide Divider;

class AppComponentsPage extends StatefulWidget {
  const AppComponentsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppComponentsPage());
  }

  @override
  State<AppComponentsPage> createState() => _AppComponentsPageState();
}

class _AppComponentsPageState extends State<AppComponentsPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: const Text('App Components'),
        leading: Switch(
          value: isDark,
          onChanged: (value) {
            isDark = value;
            themeProvider!.changeTheme(
              isDark ? AppUiType.dark : AppUiType.light,
            );
            setState(() {});
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        children: [
          PhoneField(controller: _phoneController),
          const DividerHorisontal(),
          AppButton(
            variant: AppButtonVariant.primary,
            onPressed: alirt,
            isLoading: false,
            child: const Text('Alert'),
          ),

          const DividerHorisontal(),
          AppButton(
            variant: AppButtonVariant.primary,
            onPressed: dialot,
            isLoading: false,
            child: const Text('Dialog'),
          ),
          const DividerHorisontal(),
          DrawerTile(
            title: 'test',
            icon: Assets.icons.tickCircle.svg(),
            subtitle: 'test',
          ),
          const DividerHorisontal(),
          DrawerTile(
            title: 'test',
            icon: Assets.icons.tickCircle.svg(),
            subtitle: 'test',
          ),
          const DividerHorisontal(),
          ReusableTextButton(
            label: 'Get duulat',
            onPressed: () {},
            icon: const Icon(Icons.close),
          ),
          const DividerHorisontal(),
          CustomTextField(controller: _phoneController),
          const SizedBox(height: 300),
        ],
      ),
    );
  }

  void alirt() {
    AlertDialogs.alertDialog(
      context: context,
      typeAlertDialog: AlertDialogType.error,
    );
  }

  void dialot() {
    BottomSheets.showModalSettingsSheet(
      context: context,
      showDragHandle: true,
      child: const ModalBaseComponent(),
    );
  }
}
