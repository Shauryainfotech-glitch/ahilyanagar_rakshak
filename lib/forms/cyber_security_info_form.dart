import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CyberSecurityInfoForm extends StatelessWidget {
  const CyberSecurityInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.cyberSecurityInfo)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

