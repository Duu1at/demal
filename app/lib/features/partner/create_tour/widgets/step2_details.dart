import 'package:app/features/partner/create_tour/cubit/create_tour_cubit.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step2Details extends StatelessWidget {
  const Step2Details({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTourCubit, CreateTourState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                hintText: 'Подробное описание тура',
                maxLines: 5,
                controller: TextEditingController(text: state.description)
                  ..selection = TextSelection.collapsed(offset: state.description.length),
                onChanged: (value) => context.read<CreateTourCubit>().updateDescription(value),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                label: const Text('Точка встречи'),
                hintText: 'Адрес места встречи',
                controller: TextEditingController(text: state.meetingPointAddress)
                  ..selection = TextSelection.collapsed(offset: state.meetingPointAddress.length),
                onChanged: (value) => context.read<CreateTourCubit>().updateMeetingPointAddress(value),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                label: const Text('Координаты (опционально)'),
                hintText: 'Широта, долгота',
                controller: TextEditingController(text: state.meetingPointCoordinates)
                  ..selection = TextSelection.collapsed(offset: state.meetingPointCoordinates.length),
                onChanged: (value) => context.read<CreateTourCubit>().updateMeetingPointCoordinates(value),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                label: const Text('Что взять с собой'),
                hintText: 'Рекомендации для участников',
                maxLines: 3,
                controller: TextEditingController(text: state.whatToBring)
                  ..selection = TextSelection.collapsed(offset: state.whatToBring.length),
                onChanged: (value) => context.read<CreateTourCubit>().updateWhatToBring(value),
              ),
              const SizedBox(height: AppSpacing.lg),
              _WhatsIncludedSection(
                items: state.whatsIncluded,
                onAdd: (item) => context.read<CreateTourCubit>().addWhatsIncluded(item),
                onRemove: (index) => context.read<CreateTourCubit>().removeWhatsIncluded(index),
              ),
              const SizedBox(height: AppSpacing.lg),
              _WhatsNotIncludedSection(
                items: state.whatsNotIncluded,
                onAdd: (item) => context.read<CreateTourCubit>().addWhatsNotIncluded(item),
                onRemove: (index) => context.read<CreateTourCubit>().removeWhatsNotIncluded(index),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WhatsIncludedSection extends StatefulWidget {
  const _WhatsIncludedSection({
    required this.items,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> items;
  final void Function(String) onAdd;
  final void Function(int) onRemove;

  @override
  State<_WhatsIncludedSection> createState() => _WhatsIncludedSectionState();
}

class _WhatsIncludedSectionState extends State<_WhatsIncludedSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Что включено *',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                hintText: 'Добавить пункт',
                controller: _controller,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  widget.onAdd(_controller.text);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...widget.items.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Expanded(
                  child: Chip(
                    label: Text(entry.value),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => widget.onRemove(entry.key),
                ),
              ],
            ),
          );
        }),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              'Добавьте хотя бы один пункт',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _WhatsNotIncludedSection extends StatefulWidget {
  const _WhatsNotIncludedSection({
    required this.items,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> items;
  final void Function(String) onAdd;
  final void Function(int) onRemove;

  @override
  State<_WhatsNotIncludedSection> createState() => _WhatsNotIncludedSectionState();
}

class _WhatsNotIncludedSectionState extends State<_WhatsNotIncludedSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Что не включено *',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                hintText: 'Добавить пункт',
                controller: _controller,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  widget.onAdd(_controller.text);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.add),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...widget.items.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Expanded(
                  child: Chip(
                    label: Text(entry.value),
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => widget.onRemove(entry.key),
                ),
              ],
            ),
          );
        }),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              'Добавьте хотя бы один пункт',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
