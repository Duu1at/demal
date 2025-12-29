import 'package:flutter/material.dart';

class ScrollableForm extends StatelessWidget {
  const ScrollableForm({
    required this.listViewChildren,
    required this.columnChildren,
    this.contentPadding = const EdgeInsets.all(16),
    this.formKey,
    this.listViewKey,
    this.listViewContentPadding,
    super.key,
  });

  final GlobalKey<FormState>? formKey;
  final List<Widget> listViewChildren;
  final List<Widget> columnChildren;
  final Key? listViewKey;
  final EdgeInsets contentPadding;
  final EdgeInsets? listViewContentPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: listViewContentPadding,
                key: listViewKey,
                children: listViewChildren,
              ),
            ),
            ...columnChildren,
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}

class ScrollableBody extends StatelessWidget {
  const ScrollableBody({
    required this.listViewChildren,
    required this.columnChildren,
    this.columnPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.listViewPadding = const EdgeInsets.symmetric(horizontal: 16),
    super.key,
  });

  final List<Widget> listViewChildren;
  final List<Widget> columnChildren;
  final EdgeInsets columnPadding;
  final EdgeInsets listViewPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: listViewPadding,
            children: listViewChildren,
          ),
        ),
        Padding(
          padding: columnPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: columnChildren,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}

class ScrollableStack extends StatelessWidget {
  const ScrollableStack({
    required this.listViewChildren,
    required this.columnChildren,
    this.listViewContentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.columnContentPadding = const EdgeInsets.symmetric(horizontal: 16),
    super.key,
  });

  final List<Widget> listViewChildren;
  final List<Widget> columnChildren;
  final EdgeInsets listViewContentPadding;
  final EdgeInsets columnContentPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: listViewContentPadding,
          children: listViewChildren,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: columnContentPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: columnChildren,
            ),
          ),
        ),
      ],
    );
  }
}
