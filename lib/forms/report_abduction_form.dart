import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ReportAbductionForm extends StatelessWidget {
  const ReportAbductionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.reportAbduction)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

