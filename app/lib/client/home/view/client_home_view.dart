import 'package:flutter/material.dart';

class ClientHomeView extends StatelessWidget {
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Client Home')),
      body: Center(child: Text('Client Home')),
    );
  }
}
