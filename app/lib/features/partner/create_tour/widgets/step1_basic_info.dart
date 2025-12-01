import 'package:app/features/features.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Step1BasicInfo extends StatelessWidget {
  const Step1BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTourCubit, CreateTourState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                label: const Text('Название тура'),
                hintText: 'Например: Тур по озеру Иссык-Куль',
                controller: TextEditingController(text: state.title)
                  ..selection = TextSelection.collapsed(offset: state.title.length),
                onChanged: (value) => context.read<CreateTourCubit>().updateTitle(value),
                validator: (value) => value?.isEmpty ?? true ? 'Обязательное поле' : null,
                maxLines: 4,
                maxLength: 255,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                label: const Text('Тип тура'),
                hintText: 'Например: Активный отдых, Экскурсия',
                controller: TextEditingController(text: state.tourType)
                  ..selection = TextSelection.collapsed(offset: state.tourType.length),
                onChanged: (value) => context.read<CreateTourCubit>().updateTourType(value),
                validator: (value) => value?.isEmpty ?? true ? 'Обязательное поле' : null,
                maxLength: 55,
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                label: const Text('Местоположение'),
                hintText: 'Где проходит тур',
                controller: TextEditingController(text: state.location)
                  ..selection = TextSelection.collapsed(offset: state.location.length),
                onChanged: (value) => context.read<CreateTourCubit>().updateLocation(value),
                validator: (value) => value?.isEmpty ?? true ? 'Обязательное поле' : null,
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
                          context.read<CreateTourCubit>().updateDate(
                            DateFormat('yyyy-MM-dd').format(date),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: IgnorePointer(
                        child: AppTextField(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.sm,
                          ),
                          label: const Text('Дата'),
                          hintText: 'ДД.ММ.ГГГГ',
                          readOnly: true,
                          controller: TextEditingController(
                            text: state.date.isNotEmpty
                                ? DateFormat('dd.MM.yyyy').format(DateTime.parse(state.date))
                                : '',
                          ),
                          suffixIcon: const Icon(Icons.calendar_today),
                          validator: (value) => value?.isEmpty ?? true ? 'Обязательное поле' : null,
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
                          context.read<CreateTourCubit>().updateTime(
                            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: IgnorePointer(
                        child: AppTextField(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.sm,
                          ),
                          label: const Text('Время'),
                          hintText: 'ЧЧ:ММ',
                          readOnly: true,
                          controller: TextEditingController(text: state.time),
                          suffixIcon: const Icon(Icons.access_time),
                          validator: (value) => value?.isEmpty ?? true ? 'Обязательное поле' : null,
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                      label: const Text('Цена'),
                      hintText: '0',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      controller: TextEditingController(
                        text: state.price > 0 ? state.price.toString() : '',
                      ),
                      onChanged: (value) {
                        final price = double.tryParse(value) ?? 0.0;
                        context.read<CreateTourCubit>().updatePrice(price);
                      },
                      validator: (value) {
                        final price = double.tryParse(value ?? '0') ?? 0.0;
                        return price <= 0 ? 'Цена должна быть больше 0' : null;
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: state.currency,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                        labelText: 'Валюта',
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
                          context.read<CreateTourCubit>().updateCurrency(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                label: const Text('Доступные места'),
                hintText: 'Количество мест',
                keyboardType: TextInputType.number,
                controller: TextEditingController(
                  text: state.availableSpots > 0 ? state.availableSpots.toString() : '',
                ),
                onChanged: (value) {
                  final spots = int.tryParse(value) ?? 0;
                  context.read<CreateTourCubit>().updateAvailableSpots(spots);
                },
                validator: (value) {
                  final spots = int.tryParse(value ?? '0') ?? 0;
                  return spots <= 0 ? 'Количество мест должно быть больше 0' : null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
