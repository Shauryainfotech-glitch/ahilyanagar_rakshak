import 'package:flutter/material.dart';

class FIRDownloadForm extends StatefulWidget {
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
      appBar: AppBar(title: Text('FIR Download')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Common police app fields
              TextFormField(
                decoration: InputDecoration(labelText: 'Applicant Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => applicantName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Applicant Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? 'Enter contact number' : null,
                onSaved: (value) => applicantContact = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Applicant Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? 'Enter email' : null,
                onSaved: (value) => applicantEmail = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Applicant Address'),
                validator: (value) => value == null || value.isEmpty ? 'Enter address' : null,
                onSaved: (value) => applicantAddress = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'ID Proof Type'),
                items: ['Aadhaar', 'PAN', 'Voter ID', 'Passport', 'Other']
                    .map((id) => DropdownMenuItem(value: id, child: Text(id)))
                    .toList(),
                onChanged: (value) => setState(() => idProofType = value),
                validator: (value) => value == null ? 'Select ID proof type' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'ID Proof Number'),
                validator: (value) => value == null || value.isEmpty ? 'Enter ID proof number' : null,
                onSaved: (value) => idProofNumber = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Emergency Contact Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter emergency contact name' : null,
                onSaved: (value) => emergencyContactName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Emergency Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? 'Enter emergency contact number' : null,
                onSaved: (value) => emergencyContactNumber = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('FIR Download request submitted!')),
                    );
                  }
                },
                child: Text('Download'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
