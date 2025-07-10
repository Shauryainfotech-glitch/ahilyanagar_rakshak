import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class PaymentHistoryForm extends StatefulWidget {
  const PaymentHistoryForm({super.key});

  @override
  _PaymentHistoryFormState createState() => _PaymentHistoryFormState();
}

class _PaymentHistoryFormState extends State<PaymentHistoryForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? paymentId;
  String? date;
  String? amount;
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.paymentHistory)),
      body: Center(
        child: Text(AppLocalizations.of(context)!.formComingSoon),
      ),
    );
  }
}
