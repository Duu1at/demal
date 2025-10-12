import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class InitialSettingsView  extends StatelessWidget{
  const InitialSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
  return ScaffoldWithBgImage(
    appBar: AppBar(elevation: 0),
    body: Center(
      child: Text('Initial Settings', style: Theme.of(context).textTheme.headlineLarge),
    ),
  );
  }

}