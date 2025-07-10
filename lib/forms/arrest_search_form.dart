import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ArrestSearchForm extends StatefulWidget {
  const ArrestSearchForm({super.key});

  @override
  _ArrestSearchFormState createState() => _ArrestSearchFormState();
}

class _ArrestSearchFormState extends State<ArrestSearchForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? searchType;
  String? personName;
  String? personAge;
  String? personAddress;
  String? lastSeenDate;
  String? description;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.arrestSearch)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}

