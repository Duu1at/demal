import 'package:app/app/app.dart';
import 'package:app/widgets/widgets.dart';
import 'package:core/core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> with SettingsChangeMixin<EditProfileView> {
  late final AuthState _authState;
  late TextEditingController _fullNameCtl;
  late TextEditingController _emailCtl;
  late TextEditingController _titleCtl;

  @override
  void initState() {
    super.initState();
    _authState = context.read<AuthCubit>().state;
    _fullNameCtl = TextEditingController(text: _authState.user.fullName);
    _emailCtl = TextEditingController(text: _authState.user.email);
    _titleCtl = TextEditingController(text: _authState.user.partnerProfile?.description);
  }

  @override
  void dispose() {
    _fullNameCtl.dispose();
    _titleCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: Text(context.l10n.profile, style: theme.textTheme.titleLarge),
      ),
      body: ScrollableForm(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        listViewChildren: [
          const SizedBox(height: AppSpacing.sm),
          Container(
            alignment: Alignment.center,
            child: EditableAvatar(
              size: 120,
              expand: true,
              onUpdate: (byte) {
                debugPrint('byte: $byte');
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
            controller: _fullNameCtl,
            label: Text(_authState.user.role == RoleEnum.PARTNER ? 'Название компании' : 'Имя'),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
            controller: _emailCtl,
            label: const Text('Email'),
          ),
          if (_authState.user.role == RoleEnum.PARTNER) ...[
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
              controller: _titleCtl,
              label: const Text('Описание '),
              maxLength: 100,
              maxLines: 3,
            ),
          ],
        ],
        columnChildren: [
          AppButton(
            onPressed: () {},
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
