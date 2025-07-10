import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class BloodRequestForm extends StatefulWidget {
  const BloodRequestForm({super.key});

  @override
  _BloodRequestFormState createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<BloodRequestForm> {
  final _formKey = GlobalKey<FormState>();
  String? requesterName;
  String? requesterContact;
  String? requesterEmail;
  String? requesterAddress;
  String? patientName;
  String? patientAge;
  String? bloodGroup;
  String? unitsRequired;
  String? hospitalName;
  String? hospitalAddress;
  String? urgency;
  String? reason;
  String? requiredDate;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.bloodRequest)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Requester Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter requester name' : null,
                onSaved: (value) => requesterName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantContactNumber),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterContactNumber : null,
                onSaved: (value) => requesterContact = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantEmail),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmail : null,
                onSaved: (value) => requesterEmail = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.address),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterAddress : null,
                onSaved: (value) => requesterAddress = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Patient Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter patient name' : null,
                onSaved: (value) => patientName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Patient Age'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter patient age' : null,
                onSaved: (value) => patientAge = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Required Blood Group'),
                items: [
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'AB+',
                  'AB-',
                  'O+',
                  'O-'
                ].map((group) => DropdownMenuItem(value: group, child: Text(group))).toList(),
                onChanged: (value) => setState(() => bloodGroup = value),
                validator: (value) => value == null ? 'Please select blood group' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Units Required'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter units required' : null,
                onSaved: (value) => unitsRequired = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hospital Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter hospital name' : null,
                onSaved: (value) => hospitalName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hospital Address'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter hospital address' : null,
                onSaved: (value) => hospitalAddress = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Urgency Level'),
                items: [
                  'Emergency (Within 2 hours)',
                  'Urgent (Within 6 hours)',
                  'Normal (Within 24 hours)',
                  'Planned (More than 24 hours)'
                ].map((urgency) => DropdownMenuItem(value: urgency, child: Text(urgency))).toList(),
                onChanged: (value) => setState(() => urgency = value),
                validator: (value) => value == null ? 'Please select urgency level' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reason for Blood Requirement'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Please provide reason' : null,
                onSaved: (value) => reason = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Required Date'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter required date' : null,
                onSaved: (value) => requiredDate = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.idProofType),
                items: [
                  AppLocalizations.of(context)!.aadhaar,
                  AppLocalizations.of(context)!.pan,
                  AppLocalizations.of(context)!.voterId,
                  AppLocalizations.of(context)!.passport,
                  AppLocalizations.of(context)!.other
                ].map((id) => DropdownMenuItem(value: id, child: Text(id))).toList(),
                onChanged: (value) => setState(() => idProofType = value),
                validator: (value) => value == null ? AppLocalizations.of(context)!.selectIdProofType : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.idProofNumber),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterIdProofNumber : null,
                onSaved: (value) => idProofNumber = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.emergencyContactName),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmergencyContactName : null,
                onSaved: (value) => emergencyContactName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.emergencyContactNumber),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmergencyContactNumber : null,
                onSaved: (value) => emergencyContactNumber = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.formSubmitted)),
                    );
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
}

