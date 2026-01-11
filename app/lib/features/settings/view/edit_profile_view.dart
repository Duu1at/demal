import 'dart:io';
import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app/widgets/widgets.dart';
import 'package:core/core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:profile_repository/profile_repository.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> with SettingsChangeMixin<EditProfileView> {
  late final AuthState _authState;

  @override
  void initState() {
    super.initState();
    _authState = context.read<AuthCubit>().state;
  }

  void _updateProfile({
    String? fullName,
    String? description,
    String? phoneNumber,
    File? imageFile,
  }) {
    final param = ProfileUpdateParam(
      fullName: fullName ?? _authState.user.fullName,
      description: description ?? _authState.user.partnerProfile?.description,
      phoneNumber: phoneNumber ?? _authState.user.phoneNumber,
    );

    context.read<UpdateProfileCubit>().updateProfile(
      param: param,
      imageFile: imageFile,
      onSuccess: () {
        context.read<AuthCubit>().updateProfile();
        AppSnackbar.showSuccess(context: context, title: 'Профиль успешно обновлен');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UpdateProfileCubit, RequestStatus<UserModel>>(
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            final user = authState.user;
            final isPartner = user.role == RoleEnum.PARTNER;

            return ScaffoldWithBgImage(
              appBar: AppBar(
                title: Text(context.l10n.profile, style: theme.textTheme.titleLarge),
              ),
              body: ScrollableBody(
                listViewPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                listViewChildren: [
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    alignment: Alignment.center,
                    child: EditableAvatar(
                      avatarUrl: user.imageUrl,
                      size: 120,
                      expand: true,
                      isReadOnly: false,
                      onDelete: () => _updateProfile(imageFile: null),
                      onUpdate: (file) => _updateProfile(imageFile: file),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    key: Key('name_${user.fullName}'),
                    initialValue: user.fullName,
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    label: Text(isPartner ? 'Название компании' : 'Имя'),
                    textInputAction: TextInputAction.done,
                    suffixIcon: const Icon(Icons.edit, size: 20),
                    onFieldSubmitted: (v) {
                      if (v.trim().isEmpty || v.trim() == user.fullName) return;
                      _updateProfile(fullName: v.trim());
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    key: Key('phone_${user.phoneNumber}'),
                    initialValue: user.phoneNumber,
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    label: const Text('Номер телефона'),
                    textInputAction: TextInputAction.done,
                    prefix: const Text('+996 '),
                    suffixIcon: const Icon(Icons.edit, size: 20),
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '(###) ##-##-##',
                        filter: {'#': RegExp('[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                    ],
                    onFieldSubmitted: (v) {
                      if (v.trim().isEmpty || v.trim() == user.phoneNumber) return;
                      _updateProfile(phoneNumber: v.trim());
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    initialValue: user.email ?? 'Не указан',
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    label: const Text('Email'),
                    readOnly: true,
                    suffixIcon: const Icon(Icons.lock, size: 20),
                  ),

                  if (isPartner) ...[
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      key: Key('desc_${user.partnerProfile?.description}'),
                      initialValue: user.partnerProfile?.description,
                      contentPadding: const EdgeInsets.all(AppSpacing.sm),
                      label: const Text('Описание'),
                      maxLength: 100,
                      maxLines: 3,
                      textInputAction: TextInputAction.done,
                      suffixIcon: const Icon(Icons.edit, size: 20),
                      onFieldSubmitted: (v) {
                        if (v.trim().isEmpty || v.trim() == user.partnerProfile?.description) return;
                        _updateProfile(description: v.trim());
                      },
                    ),
                  ],
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                ],
                columnChildren: const [],
              ),
            );
          },
        );
      },
    );
  }
}
