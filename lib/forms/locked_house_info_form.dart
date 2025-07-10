import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class LockedHouseInfoForm extends StatelessWidget {
  const LockedHouseInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.lockedHouseInfo)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

