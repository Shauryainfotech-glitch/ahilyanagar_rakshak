import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class RatePoliceStationForm extends StatelessWidget {
  const RatePoliceStationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.ratePoliceStation)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

