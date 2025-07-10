import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ReportCyberFraudForm extends StatelessWidget {
  const ReportCyberFraudForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.reportCyberFraud)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

