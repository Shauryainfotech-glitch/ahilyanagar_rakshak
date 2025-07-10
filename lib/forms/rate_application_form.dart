import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class RateApplicationForm extends StatelessWidget {
  const RateApplicationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.rateApplication)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

