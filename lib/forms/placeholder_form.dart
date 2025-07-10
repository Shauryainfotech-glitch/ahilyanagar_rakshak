import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class PlaceholderForm extends StatelessWidget {
  final String serviceName;
  const PlaceholderForm({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.placeholder)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

