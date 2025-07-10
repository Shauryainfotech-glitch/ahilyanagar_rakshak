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
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? idProofType;
  String? idProofNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.firDownload)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('FIR Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'FIR Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.numbers),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter FIR number' : null,
              onSaved: (value) => firNumber = value,
            ),
            const SizedBox(height: 24),
            Text('Applicant Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantName,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterYourName : null,
              onSaved: (value) => applicantName = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantContactNumber,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterContactNumber : null,
              onSaved: (value) => applicantContact = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantEmail,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmail : null,
              onSaved: (value) => applicantEmail = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.address,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_on),
              ),
              maxLines: 2,
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterAddress : null,
              onSaved: (value) => applicantAddress = value,
            ),
            const SizedBox(height: 24),
            Text('ID Proof', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.idProofType,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.credit_card),
              ),
              items: [
                AppLocalizations.of(context)!.aadhaar,
                AppLocalizations.of(context)!.pan,
                AppLocalizations.of(context)!.voterId,
                AppLocalizations.of(context)!.passport,
                AppLocalizations.of(context)!.other,
              ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) => setState(() => idProofType = value),
              validator: (value) => value == null ? 'Please select ID proof type' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'ID Proof Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.numbers),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter ID proof number' : null,
              onSaved: (value) => idProofNumber = value,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Request Submitted'),
                      content: Text('Your FIR download request has been submitted successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.download),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.submit, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
