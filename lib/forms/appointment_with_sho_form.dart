import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AppointmentWithSHOForm extends StatelessWidget {
  const AppointmentWithSHOForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appointmentWithSho)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

