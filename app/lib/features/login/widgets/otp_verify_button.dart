import 'package:app/app/app.dart';
import 'package:app/features/login/login.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpVerifyButton extends StatelessWidget {
  const OtpVerifyButton({
    required this.email,
    required this.formKey,
    required this.pinController,
    required this.focusNode,
    super.key,
  });

  final String email;
  final GlobalKey<FormState> formKey;
  final TextEditingController pinController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (p, c) => p.verifyStatus != c.verifyStatus,
      listener: (context, state) {
        final verifyStatus = state.verifyStatus;
        if (verifyStatus is RequestSuccess<String>) {
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
        if (verifyStatus is RequestFailure<String>) {
          context.read<ErrorHandler>().handleError(
            verifyStatus.exception,
            context,
          );
          pinController.clear();
          focusNode.requestFocus();
        }
      },
      buildWhen: (p, c) => p.verifyStatus != c.verifyStatus,
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            final isOtpLoading = state.verifyStatus is RequestLoading;
            final isAuthLoading = authState.status == AuthStatus.loading;
            final isLoading = isOtpLoading || isAuthLoading;

            return AppButton(
              isLoading: isLoading,
              onPressed: () {
                focusNode.unfocus();
                if (formKey.currentState!.validate()) {
                  final pin = pinController.text.trim();
                  if (pin.length != 6) return;
                  context.read<OtpCubit>().verifyOtpCode(
                    email: email,
                    pin: pin,
                  );
                }
              },
              child: Text(context.l10n.verify),
            );
          },
        );
      },
    );
  }
}
