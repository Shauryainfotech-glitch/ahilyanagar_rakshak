import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CyberDoneForm extends StatelessWidget {
  const CyberDoneForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.cyberDone)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

