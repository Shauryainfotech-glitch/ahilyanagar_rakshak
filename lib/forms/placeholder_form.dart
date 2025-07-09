import 'package:flutter/material.dart';

class PlaceholderForm extends StatelessWidget {
  final String serviceName;
  const PlaceholderForm({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(serviceName)),
      body: Center(
        child: Text('Form for $serviceName will be implemented soon.', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

