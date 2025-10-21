import 'package:app_ui/app_ui.dart';
import 'package:example/main.dart';
import 'package:example/notifier/natifier.dart';
import 'package:flutter/material.dart' hide Divider;
import 'package:flutter/services.dart';

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

  final _formKey = GlobalKey<FormState>();
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
          Form(
            key: _formKey,
            child: AppContainerWithLbl(
              label: 'Номер телефона',
              child: AppTextField(
                controller: _phoneController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
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
            isLoading: false,
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: const Text('Dialog'),
          ),
          const DividerHorisontal(),
          CardDrawerTile(
            title: 'test',
            icon: Assets.icons.tickCircle.svg(),
            subtitle: 'test',
          ),
          const DividerHorisontal(),
          CardDrawerTile(
            title: 'test',
            icon: Assets.icons.tickCircle.svg(),
            subtitle: 'test',
            onTap: () {},
          ),
          const DividerHorisontal(),
          ReusableTextButton(
            label: 'Get duulat',
            onPressed: () {},
            icon: const Icon(Icons.close),
          ),
          const DividerHorisontal(),
          AppContainerWithLbl(
            label: 'Номер телефона',
            child: AppTextField(
              controller: _phoneController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          const DividerHorisontal(),
          const AppCard(
            child: Column(children: [Text('testetaf'), Text('testetaf')]),
          ),
          const SizedBox(height: 300),
        ],
      ),
    );
  }

  void alirt() {
    AlertDialogs.alertDialog(
      context: context,
      typeAlertDialog: AlertDialogType.info,
    );
  }
}
