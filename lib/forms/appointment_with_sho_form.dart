import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:firebase_database/firebase_database.dart';

class AppointmentWithSHOForm extends StatefulWidget {
  const AppointmentWithSHOForm({super.key});

  @override
  State<AppointmentWithSHOForm> createState() => _AppointmentWithSHOFormState();
}

class _AppointmentWithSHOFormState extends State<AppointmentWithSHOForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appointmentWithSho),
      ),
      body: Center(child: Text(AppLocalizations.of(context)!.formComingSoon)),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final data = {
        // 'field1': _controller1.text,
        // ...बाकी फील्ड्स
        'submittedAt': DateTime.now().toIso8601String(),
      };
      try {
        await FirebaseDatabase.instance
            .ref('forms/appointment_with_sho')
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
