import 'package:app_ui/app_ui.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TourItemsListInput extends StatefulWidget {
  const TourItemsListInput({
    required this.title,
    required this.items,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });
  final String title;
  final List<String> items;
  final void Function(String) onAdd;
  final void Function(int) onRemove;

  @override
  State<TourItemsListInput> createState() => TourItemsListInputState();
}

class TourItemsListInputState extends State<TourItemsListInput> {
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
          '${widget.title} *',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                hintText: context.l10n.addItemHint,
                controller: _controller,
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
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: widget.items.asMap().entries.map((entry) {
            return InputChip(
              label: Text(entry.value),
              onDeleted: () => widget.onRemove(entry.key),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              deleteIcon: const Icon(Icons.close, size: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide.none,
              ),
            );
          }).toList(),
        ),
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              context.l10n.addAtLeastOneItemError,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
