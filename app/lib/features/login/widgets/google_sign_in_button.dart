import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleSignCubit, RequestStatus<void>>(
      listener: (context, state) {
        if (state is RequestSuccess<void>) {
          context.read<AuthCubit>().checkUser().then((value) {
            if (context.mounted) {
              final user = context.read<AuthCubit>().state.user;
              if (user.isPartner) {
                context.goNamed(AppRouteNames.partner);
                return;
              }
              context.goNamed(AppRouteNames.client);
            }
          });
        }
        if (state is RequestFailure<void>) {
          context.read<ErrorHandler>().handleError(state.exception, context);
        }
      },
      builder: (context, state) {
        return AppButton(
          variant: AppButtonVariant.outline,
          onPressed: () => context.read<GoogleSignCubit>().signInWithGoogle(),
          isLoading: state is RequestLoading,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.google.svg(
                width: 24,
                height: 24,
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                context.l10n.signInGoogle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
