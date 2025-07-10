import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class SearchPoliceStationForm extends StatelessWidget {
  const SearchPoliceStationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.searchPoliceStation)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

