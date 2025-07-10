import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SingleWomenLivingAloneForm extends StatelessWidget {
  const SingleWomenLivingAloneForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.singleWomenLivingAlone)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

