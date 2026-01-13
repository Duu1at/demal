import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_repository/profile_repository.dart';

class BecomeOrganizerTile extends StatelessWidget {
  const BecomeOrganizerTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<VerifyStatusCubit, RequestStatus<PartnerVerifyStatusModel>>(
      listener: (context, state) {
        if (state is RequestSuccess<PartnerVerifyStatusModel>) {
          final status = state.data?.verificationStatus;
          if (status == PartnerVerifyStatusEnum.notStarted || status == null) {
            UpgradeRoleBottomSheet.show(context);
            return;
          }
          context.pushNamed(AppRouteNames.partnerVerificationStatus);
        }
        if (state is RequestFailure) {
          context.read<ErrorHandler>().handleError(state, context);
        }
      },
      builder: (context, state) {
        return CardDrawerTitle(
          actionIcon: state.isLoading
              ? const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator.adaptive(),
                )
              : null,
          title: context.l10n.roleUpgradeTitle,
          icon: Icon(
            Icons.business_center_outlined,
            color: theme.colorScheme.primary,
          ),
          onTap: () => context.read<VerifyStatusCubit>().getVerifyStatus(),
        );
      },
    );
  }
}
