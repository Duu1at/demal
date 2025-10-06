import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: const Text('App Components')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        children: [
          PhoneNumberField(
            controller: _phoneController,
            state: state,
            onChanged: (value) {
              setState(() {
                _phoneController.text = value;
                _phoneController.text.isEmpty ? state = PhoneFieldState.normal : state = PhoneFieldState.focused;
              });
            },
          ),

          const SizedBox(height: 8),
          AppButton(variant: AppButtonVariant.primary, child: Text('Get started'), onPressed: () {}, isLoading: false),
LinkTextButton(text: 'Get started', onPressed: () {}),
          const SizedBox(height: 300),
        ],
      ),
    );
  }
}
