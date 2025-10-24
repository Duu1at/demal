import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({
    super.key,
    required this.nameController,
    required this.emailController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Details', style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.lg),

        AppTextField(
          hintText: 'Full Name',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.icons.user.svg(
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          controller: nameController,
        ),

        const SizedBox(height: AppSpacing.md),
        AppTextField(
          hintText: 'Email',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.icons.email.svg(
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          controller: emailController,
        ),
      ],
    );
  }
}
