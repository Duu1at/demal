import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Step1BasicInfo extends StatefulWidget {
  const Step1BasicInfo({super.key});

  @override
  State<Step1BasicInfo> createState() => _Step1BasicInfoState();
}

class _Step1BasicInfoState extends State<Step1BasicInfo> {
  late final TextEditingController _titleController;
  late final TextEditingController _tourTypeController;
  late final TextEditingController _locationController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  late final TextEditingController _priceController;
  late final TextEditingController _spotsController;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateTourFormCubit>().state;
    _titleController = TextEditingController(text: state.title);
    _tourTypeController = TextEditingController(text: state.tourType);
    _locationController = TextEditingController(text: state.location);
    _dateController = TextEditingController(
      text: state.date.isNotEmpty ? DateFormat('dd.MM.yyyy').format(DateTime.parse(state.date)) : '',
    );
    _timeController = TextEditingController(text: state.time);
    _priceController = TextEditingController(
      text: state.price > 0 ? state.price.toString() : '',
    );
    _spotsController = TextEditingController(
      text: state.availableSpots > 0 ? state.availableSpots.toString() : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTourFormCubit, CreateTourFormState>(
      listenWhen: (previous, current) => previous.tourId != current.tourId,
      listener: (context, state) {
        if (state.title != _titleController.text) {
          _titleController.text = state.title;
        }
      },
      builder: (context, state) {
        return ScrollableBody(
          listViewChildren: [
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              label: Text(context.l10n.tourTitleLabel),
              hintText: context.l10n.tourTitleHint,
              controller: _titleController,
              onChanged: (value) => context.read<CreateTourFormCubit>().updateTitle(value),
              validator: (value) => value?.isEmpty ?? true ? context.l10n.fieldRequired : null,
              maxLines: 4,
              maxLength: 255,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              label: Text(context.l10n.tourTypeLabel),
              hintText: context.l10n.tourTypeExampleHint,
              controller: _tourTypeController,
              onChanged: (value) => context.read<CreateTourFormCubit>().updateTourType(value),
              validator: (value) => value?.isEmpty ?? true ? context.l10n.fieldRequired : null,
              maxLength: 55,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              label: Text(context.l10n.locationLabel),
              hintText: context.l10n.tourLocationHint,
              controller: _locationController,
              onChanged: (value) => context.read<CreateTourFormCubit>().updateLocation(value),
              validator: (value) => value?.isEmpty ?? true ? context.l10n.fieldRequired : null,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: state.date.isNotEmpty ? DateTime.parse(state.date) : DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (context.mounted && date != null) {
                        final formattedDate = DateFormat('yyyy-MM-dd').format(date);
                        context.read<CreateTourFormCubit>().updateDate(formattedDate);
                        _dateController.text = DateFormat('dd.MM.yyyy').format(date);
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: IgnorePointer(
                      child: AppTextField(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.sm,
                        ),
                        label: Text(context.l10n.dateLabel),
                        hintText: context.l10n.dateFormatHint,
                        readOnly: true,
                        controller: _dateController,
                        suffixIcon: const Icon(Icons.calendar_today),
                        validator: (value) => value?.isEmpty ?? true ? context.l10n.fieldRequired : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: state.time.isNotEmpty
                            ? TimeOfDay(
                                hour: int.parse(state.time.split(':')[0]),
                                minute: int.parse(state.time.split(':')[1]),
                              )
                            : TimeOfDay.now(),
                      );
                      if (context.mounted && time != null) {
                        final formattedTime =
                            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                        context.read<CreateTourFormCubit>().updateTime(formattedTime);
                        _timeController.text = formattedTime;
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: IgnorePointer(
                      child: AppTextField(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.sm,
                        ),
                        label: Text(context.l10n.timeLabel),
                        hintText: context.l10n.timeFormatHint,
                        readOnly: true,
                        controller: _timeController,
                        suffixIcon: const Icon(Icons.access_time),
                        validator: (value) => value?.isEmpty ?? true ? context.l10n.fieldRequired : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: AppTextField(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.sm,
                    ),
                    label: Text(context.l10n.priceLabel),
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    onChanged: (value) {
                      final price = int.tryParse(value);
                      if (price != null) {
                        context.read<CreateTourFormCubit>().updatePrice(price);
                      }
                    },
                    validator: (value) {
                      final price = int.tryParse(value ?? '0') ?? 0;
                      return price <= 0 ? context.l10n.priceMustBeGreaterThanZero : null;
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: state.currency,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.sm,
                      ),
                      labelText: context.l10n.currencyLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      filled: true,
                      fillColor: context.inputColors.background,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'KGS', child: Text('KGS')),
                      DropdownMenuItem(value: 'USD', child: Text('USD')),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        context.read<CreateTourFormCubit>().updateCurrency(value);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              label: Text(context.l10n.availableSpotsLabel),
              hintText: context.l10n.spotsCountHint,
              keyboardType: TextInputType.number,
              controller: _spotsController,
              onChanged: (value) {
                final spots = int.tryParse(value);
                if (spots == null) return;
                context.read<CreateTourFormCubit>().updateAvailableSpots(spots);
              },
              validator: (value) {
                final spots = int.tryParse(value ?? '0') ?? 0;
                return spots <= 0 ? context.l10n.spotsMustBeGreaterThanZero : null;
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          ],
          columnChildren: const [],
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _tourTypeController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _priceController.dispose();
    _spotsController.dispose();
    super.dispose();
  }
}
