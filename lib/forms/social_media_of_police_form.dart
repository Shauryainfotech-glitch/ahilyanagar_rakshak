import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SocialMediaOfPoliceForm extends StatelessWidget {
  const SocialMediaOfPoliceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.socialMediaOfPolice)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

