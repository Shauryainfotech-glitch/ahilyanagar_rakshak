import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AhilyanagarPoliceForm extends StatefulWidget {
  const AhilyanagarPoliceForm({super.key});

  @override
  _AhilyanagarPoliceFormState createState() => _AhilyanagarPoliceFormState();
}

class _AhilyanagarPoliceFormState extends State<AhilyanagarPoliceForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? inquiryType;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.ahilyanagarPolice)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

