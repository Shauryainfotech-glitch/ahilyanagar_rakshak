import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class EventPerformanceForm extends StatefulWidget {
  const EventPerformanceForm({super.key});

  @override
  _EventPerformanceFormState createState() => _EventPerformanceFormState();
}

class _EventPerformanceFormState extends State<EventPerformanceForm> {
  final _formKey = GlobalKey<FormState>();
  String? eventName;
  String? organizer;
  String? date;
  String? location;
  String? performanceDetails;
  String? remarks;
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.eventPerformance)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}
