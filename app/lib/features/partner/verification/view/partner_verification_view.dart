import 'package:app/features/partner/verification/blocs/blocs.dart';
import 'package:app/features/partner/verification/widgets/widgets.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PartnerVerificationView extends StatefulWidget {
  const PartnerVerificationView({super.key});

  @override
  State<PartnerVerificationView> createState() => _PartnerVerificationViewState();
}

class _PartnerVerificationViewState extends State<PartnerVerificationView> {
  late final TextEditingController _companyNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _cardNumberController;
  final _formKey = GlobalKey<FormState>();

  final _cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {'#': RegExp('[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _checkVerificationStatus();
  }

  void _initializeControllers() {
    _companyNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _cardNumberController = TextEditingController();
    _cardNumberController.addListener(_onCardNumberChanged);
  }

  void _checkVerificationStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PartnerVerificationBloc>().add(
        const PartnerVerificationStatusChecked(),
      );
    });
  }

  void _onCardNumberChanged() {
    final cardNumber = _cardNumberFormatter.getUnmaskedText();
    context.read<PartnerVerificationBloc>().add(
      PartnerVerificationFormChanged(cardNumber: cardNumber),
    );
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _descriptionController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleDocumentPick() async {
    final file = await ImagePickerHelper.pickImage(
      context: context,
      quality: ImageQuality.medium,
    );

    if (file != null && mounted) {
      context.read<PartnerVerificationBloc>().add(
        PartnerVerificationDocumentSelected(file),
      );
    }
  }

  void _handleFormSubmit(PartnerVerificationState state) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<PartnerVerificationBloc>().add(
        const PartnerVerificationFormSubmitted(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: const Text('Верификация'),
        elevation: 0,
      ),
      body: BlocConsumer<PartnerVerificationBloc, PartnerVerificationState>(
        listener: _handleStateChanges,
        builder: (context, state) {
          if (state.isVerified) {
            return _buildVerifiedState();
          }

          return _buildForm(state);
        },
      ),
    );
  }

  void _handleStateChanges(BuildContext context, PartnerVerificationState state) {
    if (state.status == PartnerVerificationStatus.submitted) {
      if (state.isVerified) {
        context.go('/partner');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Заявка отправлена на проверку'),
          ),
        );
      }
    } else if (state.status == PartnerVerificationStatus.error) {
      context.read<ErrorHandler>().handleError(
        Exception(state.error),
        context,
      );
    }
  }

  Widget _buildVerifiedState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/partner');
    });
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildForm(PartnerVerificationState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileAvatar(state),
            const SizedBox(height: AppSpacing.xl),
            _buildCompanyNameField(state),
            const SizedBox(height: AppSpacing.lg),
            _buildDescriptionField(state),
            const SizedBox(height: AppSpacing.lg),
            _buildDocumentUpload(state),
            const SizedBox(height: AppSpacing.lg),
            _buildCardNumberField(state),
            const SizedBox(height: AppSpacing.lg),
            _buildTermsCheckbox(state),
            const SizedBox(height: AppSpacing.xl),
            _buildSubmitButton(state),
            if (state.isPending || state.isRejected) ...[
              const SizedBox(height: AppSpacing.lg),
              _buildStatusCard(state),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(PartnerVerificationState state) {
    return ProfileAvatarSection(
      profileImageFile: state.profileImageFile,
      profileImageUrl: state.profileImageUrl,
      onImageSelected: (file) {
        context.read<PartnerVerificationBloc>().add(
          PartnerVerificationProfileImageSelected(file),
        );
      },
      onEditPressed: () async {
        final file = await ImagePickerHelper.pickImage(
          context: context,
          quality: ImageQuality.medium,
        );
        if (file != null && mounted) {
          context.read<PartnerVerificationBloc>().add(
            PartnerVerificationProfileImageSelected(file),
          );
        }
      },
    );
  }

  Widget _buildCompanyNameField(PartnerVerificationState state) {
    return FormFieldSection(
      label: 'Названия',
      controller: _companyNameController,
      hintText: 'Введите название компании',
      onChanged: (value) {
        context.read<PartnerVerificationBloc>().add(
          PartnerVerificationFormChanged(companyName: value),
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Поле обязательно для заполнения';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField(PartnerVerificationState state) {
    return FormFieldSection(
      label: 'Описание',
      controller: _descriptionController,
      hintText: 'Введите описание',
      onChanged: (value) {
        context.read<PartnerVerificationBloc>().add(
          PartnerVerificationFormChanged(description: value),
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Поле обязательно для заполнения';
        }
        return null;
      },
    );
  }

  Widget _buildDocumentUpload(PartnerVerificationState state) {
    return DocumentUploadSection(
      documentFile: state.documentFile,
      documentUrl: state.documentUrl,
      onPickDocument: _handleDocumentPick,
    );
  }

  Widget _buildCardNumberField(PartnerVerificationState state) {
    return FormFieldSection(
      label: 'Номер карты',
      controller: _cardNumberController,
      hintText: '0000 0000 0000 0000',
      keyboardType: TextInputType.number,
      inputFormatters: [_cardNumberFormatter],
      onChanged: (value) {
        // Обработка через listener
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Поле обязательно для заполнения';
        }
        final unmasked = _cardNumberFormatter.getUnmaskedText();
        if (unmasked.length < 16) {
          return 'Номер карты должен содержать 16 цифр';
        }
        return null;
      },
    );
  }

  Widget _buildTermsCheckbox(PartnerVerificationState state) {
    return TermsCheckboxSection(
      agreedToTerms: state.agreedToTerms,
      onChanged: (value) {
        context.read<PartnerVerificationBloc>().add(
          PartnerVerificationFormChanged(agreedToTerms: value),
        );
      },
    );
  }

  Widget _buildSubmitButton(PartnerVerificationState state) {
    return BlocBuilder<PartnerVerificationBloc, PartnerVerificationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AppButton(
          isLoading: state.status == PartnerVerificationStatus.submitting,
          onPressed: state.isFormValid ? () => _handleFormSubmit(state) : null,
          child: const Text('Отправить на проверку'),
        );
      },
    );
  }

  Widget _buildStatusCard(PartnerVerificationState state) {
    final statusType = state.isPending
        ? VerificationStatusType.pending
        : state.isRejected
        ? VerificationStatusType.rejected
        : VerificationStatusType.verified;

    return VerificationStatusCard(
      status: statusType,
      adminComments: state.adminComments,
    );
  }
}
