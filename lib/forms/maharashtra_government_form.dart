import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class MaharashtraGovernmentForm extends StatelessWidget {
  const MaharashtraGovernmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.maharashtraGovernment)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

