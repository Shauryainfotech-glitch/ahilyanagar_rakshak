import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class MaharashtraGovernmentForm extends StatefulWidget {
  const MaharashtraGovernmentForm({super.key});

  @override
  _MaharashtraGovernmentFormState createState() => _MaharashtraGovernmentFormState();
}

class _MaharashtraGovernmentFormState extends State<MaharashtraGovernmentForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? contact;
  String? email;
  String? address;
  String? serviceType;
  String? department;
  String? serviceDetails;
  String? requiredDocuments;

  final List<String> _serviceTypes = [
    'Government Schemes',
    'Documents',
    'Certificates',
    'Licenses',
    'Complaints',
    'Information Request',
    'Other',
  ];

  final List<String> _departments = [
    'Home Department',
    'Revenue Department',
    'Transport Department',
    'Education Department',
    'Health Department',
    'Agriculture Department',
    'Urban Development',
    'Rural Development',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.maharashtraGovernment)),
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
            Text('Service Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Service Type',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.work),
              ),
              items: _serviceTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) => setState(() => serviceType = value),
              validator: (value) => value == null ? 'Please select service type' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Department/Office',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.business),
              ),
              items: _departments.map((dept) => DropdownMenuItem(value: dept, child: Text(dept))).toList(),
              onChanged: (value) => setState(() => department = value),
              validator: (value) => value == null ? 'Please select department' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Service Details/Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Please enter service details' : null,
              onSaved: (value) => serviceDetails = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Required Documents (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.file_copy),
              ),
              maxLines: 2,
              onSaved: (value) => requiredDocuments = value,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Service Request Submitted'),
                      content: Text('Your Maharashtra Government service request has been submitted successfully.'),
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

