import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SeniorCitizenInfoForm extends StatelessWidget {
  const SeniorCitizenInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.seniorCitizenInfo)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

