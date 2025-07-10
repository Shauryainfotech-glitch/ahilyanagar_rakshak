import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AccidentGDForm extends StatefulWidget {
  const AccidentGDForm({super.key});

  @override
  _AccidentGDFormState createState() => _AccidentGDFormState();
}

class _AccidentGDFormState extends State<AccidentGDForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? vehicleNumber;
  String? accidentDate;
  String? location;
  String? description;
  String? email;
  String? altContact;
  String? gender;
  DateTime? dob;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  // Add new common police app parameters
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.accidentGd)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}
