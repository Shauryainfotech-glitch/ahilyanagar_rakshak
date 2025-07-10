import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class GrievanceRedressalForm extends StatefulWidget {
  const GrievanceRedressalForm({super.key});

  @override
  _GrievanceRedressalFormState createState() => _GrievanceRedressalFormState();
}

class _GrievanceRedressalFormState extends State<GrievanceRedressalForm> {
  final _formKey = GlobalKey<FormState>();
  String? complainantName;
  String? complainantContact;
  String? complainantEmail;
  String? complainantAddress;
  String? grievanceType;
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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.grievanceRedressal)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantName),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterYourName : null,
                onSaved: (value) => complainantName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantContactNumber),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterContactNumber : null,
                onSaved: (value) => complainantContact = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantEmail),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmail : null,
                onSaved: (value) => complainantEmail = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.address),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterAddress : null,
                onSaved: (value) => complainantAddress = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Grievance Type'),
                items: [
                  'Service Related',
                  'Staff Behavior',
                  'Corruption',
                  'Delay in Service',
                  'Incorrect Information',
                  'Infrastructure Issue',
                  'Other'
                ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => grievanceType = value),
                validator: (value) => value == null ? 'Please select grievance type' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject of Grievance'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter subject' : null,
                onSaved: (value) => subject = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Detailed Description'),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty ? 'Please provide detailed description' : null,
                onSaved: (value) => description = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Incident Date'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter incident date' : null,
                onSaved: (value) => incidentDate = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Incident Location'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter incident location' : null,
                onSaved: (value) => incidentLocation = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Evidence/Supporting Documents'),
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

