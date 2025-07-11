import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:firebase_database/firebase_database.dart';

class ComplaintRegistrationForm extends StatefulWidget {
  const ComplaintRegistrationForm({super.key});

  @override
  _ComplaintRegistrationFormState createState() =>
      _ComplaintRegistrationFormState();
}

class _ComplaintRegistrationFormState extends State<ComplaintRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? complainantName;
  String? complainantContact;
  String? complainantEmail;
  String? complainantAddress;
  String? complaintType;
  String? subject;
  String? description;
  String? incidentDate;
  String? incidentLocation;
  String? evidence;
  String? expectedResolution;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.complaintRegistration),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.applicantName,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.enterYourName
                    : null,
                onSaved: (value) => complainantName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(
                    context,
                  )!.applicantContactNumber,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.enterContactNumber
                    : null,
                onSaved: (value) => complainantContact = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.applicantEmail,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.enterEmail
                    : null,
                onSaved: (value) => complainantEmail = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.address,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.enterAddress
                    : null,
                onSaved: (value) => complainantAddress = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Complaint Type'),
                items:
                    [
                          'Theft',
                          'Assault',
                          'Fraud',
                          'Harassment',
                          'Traffic Violation',
                          'Property Damage',
                          'Cyber Crime',
                          'Other',
                        ]
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => complaintType = value),
                validator: (value) =>
                    value == null ? 'Please select complaint type' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject of Complaint'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter subject'
                    : null,
                onSaved: (value) => subject = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Detailed Description'),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please provide detailed description'
                    : null,
                onSaved: (value) => description = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Incident Date'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter incident date'
                    : null,
                onSaved: (value) => incidentDate = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Incident Location'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter incident location'
                    : null,
                onSaved: (value) => incidentLocation = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Evidence/Supporting Documents',
                ),
                maxLines: 2,
                onSaved: (value) => evidence = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Expected Resolution'),
                maxLines: 2,
                onSaved: (value) => expectedResolution = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.idProofType,
                ),
                items:
                    [
                          AppLocalizations.of(context)!.aadhaar,
                          AppLocalizations.of(context)!.pan,
                          AppLocalizations.of(context)!.voterId,
                          AppLocalizations.of(context)!.passport,
                          AppLocalizations.of(context)!.other,
                        ]
                        .map(
                          (id) => DropdownMenuItem(value: id, child: Text(id)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => idProofType = value),
                validator: (value) => value == null
                    ? AppLocalizations.of(context)!.selectIdProofType
                    : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.idProofNumber,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.enterIdProofNumber
                    : null,
                onSaved: (value) => idProofNumber = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.emergencyContactName,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.enterEmergencyContactName
                    : null,
                onSaved: (value) => emergencyContactName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(
                    context,
                  )!.emergencyContactNumber,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.enterEmergencyContactNumber
                    : null,
                onSaved: (value) => emergencyContactNumber = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _submitForm();
                  }
                },
                child: Text(AppLocalizations.of(context)!.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final data = {
        'complainantName': complainantName,
        'complainantContact': complainantContact,
        'complainantEmail': complainantEmail,
        'complainantAddress': complainantAddress,
        'complaintType': complaintType,
        'subject': subject,
        'description': description,
        'incidentDate': incidentDate,
        'incidentLocation': incidentLocation,
        'evidence': evidence,
        'expectedResolution': expectedResolution,
        'idProofType': idProofType,
        'idProofNumber': idProofNumber,
        'emergencyContactName': emergencyContactName,
        'emergencyContactNumber': emergencyContactNumber,
        'submittedAt': DateTime.now().toIso8601String(),
      };
      try {
        await FirebaseDatabase.instance
            .ref('forms/complaint_registration')
            .push()
            .set(data);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.formSubmitted),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Form submission failed!')));
        }
      }
    }
  }
}
