import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ShareInformationForm extends StatelessWidget {
  const ShareInformationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.shareInformation)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

