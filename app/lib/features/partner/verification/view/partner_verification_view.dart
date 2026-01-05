import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
        if (state.requestStatus.isFailure) {
          context.read<ErrorHandler>().handleError(state.requestStatus, context);
        }
        if (state.requestStatus.isSuccess) {
          context.goNamed(AppRouteNames.partnerVerificationStatus);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.partnerVerificationTitle)),
          body: ScrollableForm(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            listViewChildren: [
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: Text(context.l10n.companyNameLabel),
                controller: _companyNameCtlr,
                maxLines: 2,
                keyboardType: TextInputType.text,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                maxLength: 50,
                hintText: context.l10n.companyNameHint,
                onChanged: _cubit.updateCompanyName,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: Text(context.l10n.descriptionLabel),
                controller: _descriptionCtlr,
                maxLines: 5,
                keyboardType: TextInputType.text,
                inputFormatters: [LengthLimitingTextInputFormatter(255)],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                hintText: context.l10n.descriptionHint,
                onChanged: _cubit.updateDescription,
                maxLength: 255,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: Text(context.l10n.cardNumberLabel),
                controller: _cardNumberCtlr,
                keyboardType: TextInputType.number,
                inputFormatters: [InputFormatters.cardNumberFormatter],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
                hintText: context.l10n.cardNumberHint,
                onChanged: _cubit.updateCardNumber,
              ),
              const SizedBox(height: AppSpacing.md),
              PartnerVerificationDocument(state: state, cubit: _cubit),
            ],
            columnChildren: [
              CheckboxListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                value: state.isTermsAccepted,
                onChanged: (_) => _cubit.toggleTermsAccepted(),
                subtitle: Text(
                  context.l10n.termsAgreement,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                isLoading: state.requestStatus.isLoading,
                onPressed: state.isValid ? _cubit.submitVerification : null,
                child: Text(context.l10n.submitForVerification),
              ),
            ],
          ),
        );
      },
    );
  }
}
