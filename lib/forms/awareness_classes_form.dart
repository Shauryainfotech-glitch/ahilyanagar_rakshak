import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AwarenessClassesForm extends StatefulWidget {
  const AwarenessClassesForm({super.key});

  @override
  _AwarenessClassesFormState createState() => _AwarenessClassesFormState();
}

class _AwarenessClassesFormState extends State<AwarenessClassesForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? classType;
  String? preferredDate;
  String? preferredTime;
  String? location;
  String? participants;
  String? purpose;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.awarenessClasses)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantName),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterYourName : null,
                onSaved: (value) => applicantName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantContactNumber),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterContactNumber : null,
                onSaved: (value) => applicantContact = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantEmail),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmail : null,
                onSaved: (value) => applicantEmail = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.address),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterAddress : null,
                onSaved: (value) => applicantAddress = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Type of Awareness Class'),
                items: [
                  'Cyber Security',
                  'Traffic Safety',
                  'Women Safety',
                  'Child Protection',
                  'Senior Citizen Safety',
                  'Financial Fraud Prevention',
                  'Drug Abuse Prevention',
                  'Other'
                ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => classType = value),
                validator: (value) => value == null ? 'Please select class type' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preferred Date'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter preferred date' : null,
                onSaved: (value) => preferredDate = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preferred Time'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter preferred time' : null,
                onSaved: (value) => preferredTime = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preferred Location'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter preferred location' : null,
                onSaved: (value) => location = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of Participants'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter number of participants' : null,
                onSaved: (value) => participants = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Purpose of Class'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Please provide purpose' : null,
                onSaved: (value) => purpose = value,
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

