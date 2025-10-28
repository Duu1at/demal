import 'package:app/app/router/app_router.dart';
import 'package:app/login/cubit/otp_cubit.dart';
import 'package:app/utils/utils.dart';
import 'package:app_ui/app_ui.dart';
import 'package:auth/auth.dart';
import 'package:core/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      bgImageTop: true,
      appBar: AppBar(elevation: 0),
      body: BlocProvider(
        create: (context) => OtpCubit(getIt<AuthRepository>()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),

                Text(
                  'Подвердите свой номер телефона',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                Text(
                  'Мы отправим вам SMS с кодом\n на номер +996 ${_phoneController.text.isNotEmpty ? _phoneController.text : '(___) ___ ___'}',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                PhoneField(
                  controller: _phoneController,
                  inputFormatters: [InputFormatters.phoneFormatter],
                  validator: InputValidators.phoneValidatorWithout996,
                ),
                const SizedBox(height: AppSpacing.lg),
                BlocConsumer<OtpCubit, OtpState>(
                  listener: (context, state) {
                    final status = state.status;
                    if (status == OtpStatus.success) {
                      context.goNamed(
                        AppRouter.otp,
                        extra: _phoneController.text.trim(),
                      );
                    } else if (status == OtpStatus.failure) {}
                  },
                  builder: (context, state) {
                    return AppButton(
                      isLoading: state.status == OtpStatus.loading,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<OtpCubit>().sendOtp(
                            phone: _phoneController.text.trim(),
                          );
                        }
                      },
                      child: const Text('Подтверждать'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
