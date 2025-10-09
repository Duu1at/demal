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
  PhoneFieldState state = PhoneFieldState.normal;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
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
          PhoneNumberField(
            controller: _phoneController,
            state: state,
            onChanged: (value) {
              _phoneController.text = value;
              _phoneController.text.isEmpty
                  ? state = PhoneFieldState.normal
                  : state = PhoneFieldState.focused;
              setState(() {});
            },
          ),
          const SizedBox(height: 8),
          AppButton(
            variant: AppButtonVariant.primary,
            onPressed: alirt,
            isLoading: false,
            child: const Text('Alert'),
          ),

          const SizedBox(height: 8),
          AppButton(
            variant: AppButtonVariant.primary,
            onPressed: dialot,
            isLoading: false,
            child: const Text('Dialog'),
          ),
          LinkTextButton(text: 'Get started', onPressed: () {}),
          const SizedBox(height: 8),
          const DrawerTile(title: 'test', icon: Icon(Icons.abc_outlined)),

          const CustomDivider(),

          const CustomTextField(hintText: 'test '),
          const SizedBox(height: 300),
        ],
      ),
    );
  }

  void alirt() {
    AlertDialogs.showAmen(context: context, content: 'test');
  }

  void dialot() {
    BottomSheets.showModalSettingsSheet(
      context: context,
      showDragHandle: true,
      child: const Text('test'),
    );
  }
}
