import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CyberDoneForm extends StatefulWidget {
  const CyberDoneForm({super.key});

  @override
  _CyberDoneFormState createState() => _CyberDoneFormState();
}

class _CyberDoneFormState extends State<CyberDoneForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? contact;
  String? email;
  String? address;
  String? incidentType;
  DateTime? incidentDate;
  TimeOfDay? incidentTime;
  String? description;
  String? evidence;

  final List<String> _incidentTypes = [
    'Online Fraud',
    'Social Media Harassment',
    'Data Theft',
    'Phishing',
    'Ransomware',
    'Cyber Bullying',
    'Online Scam',
    'Identity Theft',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.cyberDone)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('Your Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
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
                labelText: 'Email (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
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
            Text('Cyber Incident Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Incident Type',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.security),
              ),
              items: _incidentTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) => setState(() => incidentType = value),
              validator: (value) => value == null ? 'Please select incident type' : null,
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => incidentDate = date);
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Incident Date',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  incidentDate == null 
                    ? 'Select Date' 
                    : '${incidentDate!.day}/${incidentDate!.month}/${incidentDate!.year}',
                  style: TextStyle(
                    color: incidentDate == null ? Colors.grey[600] : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() => incidentTime = time);
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Incident Time (Optional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.access_time),
                ),
                child: Text(
                  incidentTime == null 
                    ? 'Select Time' 
                    : incidentTime!.format(context),
                  style: TextStyle(
                    color: incidentTime == null ? Colors.grey[600] : Colors.black,
                  ),
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
              maxLines: 4,
              validator: (value) => value == null || value.isEmpty ? 'Please enter incident description' : null,
              onSaved: (value) => description = value,
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cyber Incident Reported'),
                      content: Text('Your cyber incident has been reported successfully.'),
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
                  const Icon(Icons.security),
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

