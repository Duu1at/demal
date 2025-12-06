import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:upload_repository/upload_repository.dart';

class PartnerVerificationView extends StatelessWidget {
  const PartnerVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnerVerificationCubit(
        profileRepository: context.read<ProfileRepository>(),
        uploadRepository: context.read<UploadRepository>(),
        imagePickerService: ImagePickerService(ImagePicker()),
      ),
      child: const _PartnerVerificationViewBody(),
    );
  }
}

class _PartnerVerificationViewBody extends StatefulWidget {
  const _PartnerVerificationViewBody();

  @override
  State<_PartnerVerificationViewBody> createState() => _PartnerVerificationViewBodyState();
}

class _PartnerVerificationViewBodyState extends State<_PartnerVerificationViewBody> {
  late final PartnerVerificationCubit _cubit;
  late final TextEditingController _companyNameCtlr;
  late final TextEditingController _descriptionCtlr;
  late final TextEditingController _cardNumberCtlr;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PartnerVerificationCubit>();
    _companyNameCtlr = TextEditingController();
    _descriptionCtlr = TextEditingController();
    _cardNumberCtlr = TextEditingController();
  }

  @override
  void dispose() {
    _companyNameCtlr.dispose();
    _descriptionCtlr.dispose();
    _cardNumberCtlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PartnerVerificationCubit, PartnerVerificationState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.read<AuthCubit>().refreshProfile().then((_) {
            if (!context.mounted) return;
            context.go(AppRoutes.partnerVerificationStatus);
          });
        }

        if (state.error != null) {
          final e = context.read<ErrorHandler>().parseErrorMessage(state.error ?? '');
          AppSnackbar.showError(context: context, title: e);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Верификация')),
          body: SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EditableAvatar(
                          avatarUrl: state.avatarUrl,
                          onUpdate: (image) => _cubit.updateAvatarUrl(image.path),
                          size: 80,
                        ),
                        const SizedBox(height: AppSpacing.xxlg),
                        AppTextField(
                          label: const Text('Название компании'),
                          controller: _companyNameCtlr,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          inputFormatters: [LengthLimitingTextInputFormatter(50)],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.sm,
                          ),
                          maxLength: 50,
                          hintText: 'Например, ООО "Турклуб"',
                          onChanged: _cubit.updateCompanyName,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: const Text('Описание'),
                          controller: _descriptionCtlr,
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          inputFormatters: [LengthLimitingTextInputFormatter(255)],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.sm,
                          ),
                          hintText: 'Например, Мы предлагаем туры в горы, в лес, в пустыню и т.д.',
                          onChanged: _cubit.updateDescription,
                          maxLength: 255,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: const Text('Номер карты'),
                          controller: _cardNumberCtlr,
                          keyboardType: TextInputType.number,
                          inputFormatters: [InputFormatters.cardNumberFormatter],
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.sm,
                          ),
                          hintText: 'XXXX XXXX XXXX XXXX',
                          onChanged: _cubit.updateCardNumber,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        PartnerVerificationDocuments(state: state, cubit: _cubit),
                        const SizedBox(height: AppSpacing.md),
                        PartnerVerificationAgreement(
                          isChecked: state.isTermsAccepted,
                          onChanged: _cubit.toggleTermsAccepted,
                        ),
                        const SizedBox(height: AppSpacing.xxxxxxlg),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: AppButton(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            isLoading: state.isSubmitting,
            onPressed: _cubit.submitVerification,
            child: const Text('Отправить на проверку'),
          ),
        );
      },
    );
  }
}
