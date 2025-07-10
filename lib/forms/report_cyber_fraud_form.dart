import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ReportCyberFraudForm extends StatefulWidget {
  const ReportCyberFraudForm({super.key});

  @override
  _ReportCyberFraudFormState createState() => _ReportCyberFraudFormState();
}

class _ReportCyberFraudFormState extends State<ReportCyberFraudForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? contact;
  String? email;
  String? address;
  String? fraudType;
  DateTime? incidentDate;
  String? description;
  String? suspectDetails;
  String? evidence;
  String? emergencyContact;

  final List<String> _fraudTypes = [
    'Phishing',
    'OTP Fraud',
    'UPI Scam',
    'Social Media',
    'Other',
  ];

  Future<void> _selectIncidentDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[800]!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != incidentDate) {
      setState(() {
        incidentDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.reportCyberFraud)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('Complainant Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
              onSaved: (value) => name = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty ? 'Please enter your contact number' : null,
              onSaved: (value) => contact = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty ? 'Please enter your email' : null,
              onSaved: (value) => email = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_on),
              ),
              maxLines: 2,
              validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
              onSaved: (value) => address = value,
            ),
            const SizedBox(height: 24),
            Text('Fraud Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Type of Cyber Fraud',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.security),
              ),
              items: _fraudTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) => setState(() => fraudType = value),
              validator: (value) => value == null ? 'Please select fraud type' : null,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _selectIncidentDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Incident Date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: incidentDate == null ? '' : '${incidentDate!.day}/${incidentDate!.month}/${incidentDate!.year}'
                  ),
                  validator: (value) => incidentDate == null ? 'Please select incident date' : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description of Incident',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Please enter description' : null,
              onSaved: (value) => description = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Suspect Details (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person_search),
              ),
              maxLines: 2,
              onSaved: (value) => suspectDetails = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Evidence/Attachments (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.attach_file),
              ),
              maxLines: 2,
              onSaved: (value) => evidence = value,
            ),
            const SizedBox(height: 24),
            Text('Emergency Contact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Emergency Contact Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty ? 'Please enter emergency contact number' : null,
              onSaved: (value) => emergencyContact = value,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Report Submitted'),
                      content: Text('Your cyber fraud report has been submitted successfully.'),
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
                  const Icon(Icons.send),
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

