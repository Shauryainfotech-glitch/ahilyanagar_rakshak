import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:firebase_database/firebase_database.dart';

class AccidentGDForm extends StatefulWidget {
  const AccidentGDForm({super.key});

  @override
  _AccidentGDFormState createState() => _AccidentGDFormState();
}

class _AccidentGDFormState extends State<AccidentGDForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
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
      body: Center(child: Text(AppLocalizations.of(context)!.formComingSoon)),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final data = {
        // 'name': _nameController.text,
        // ...बाकी फील्ड्स
        'submittedAt': DateTime.now().toIso8601String(),
      };
      try {
        await FirebaseDatabase.instance
            .ref('forms/accident_gd')
            .push()
            .set(data);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form submitted successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Form submission failed!')));
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }
}
