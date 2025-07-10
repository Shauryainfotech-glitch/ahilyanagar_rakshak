import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class FIRDownloadForm extends StatefulWidget {
  const FIRDownloadForm({super.key});

  @override
  _FIRDownloadFormState createState() => _FIRDownloadFormState();
}

class _FIRDownloadFormState extends State<FIRDownloadForm> {
  final _formKey = GlobalKey<FormState>();
  String? firNumber;
  String? applicantName;
  String? contact;
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.firDownload)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}
