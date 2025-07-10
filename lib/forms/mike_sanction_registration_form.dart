import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class MikeSanctionRegistrationForm extends StatefulWidget {
  const MikeSanctionRegistrationForm({super.key});

  @override
  _MikeSanctionRegistrationFormState createState() => _MikeSanctionRegistrationFormState();
}

class _MikeSanctionRegistrationFormState extends State<MikeSanctionRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  // Add new common police app parameters
  String? applicantName;
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? name;
  String? event;
  String? location;
  String? date;
  String? details;
  String? email;
  String? altContact;
  String? gender;
  DateTime? dob;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.mikeSanctionRegistration)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}
