import 'package:app/app/app.dart';
import 'package:app/features/features.dart';
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
              context.pushNamed(AppRouteNames.clientHome);
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
        return AppButton(
          isLoading: state.verifyStatus is RequestLoading,
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
          child: const Text('Проверить'),
        );
      },
    );
  }
}
