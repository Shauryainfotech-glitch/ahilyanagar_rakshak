import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class BloodDonorForm extends StatefulWidget {
  const BloodDonorForm({super.key});

  @override
  _BloodDonorFormState createState() => _BloodDonorFormState();
}

class _BloodDonorFormState extends State<BloodDonorForm> {
  final _formKey = GlobalKey<FormState>();
  String? donorName;
  String? donorContact;
  String? donorEmail;
  String? donorAddress;
  String? bloodGroup;
  String? age;
  String? gender;
  String? lastDonationDate;
  String? medicalHistory;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.bloodDonor)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantName),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterYourName : null,
                onSaved: (value) => donorName = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantContactNumber),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterContactNumber : null,
                onSaved: (value) => donorContact = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantEmail),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmail : null,
                onSaved: (value) => donorEmail = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.address),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterAddress : null,
                onSaved: (value) => donorAddress = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Blood Group'),
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
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Please enter age' : null,
                onSaved: (value) => age = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                items: [
                  'Male',
                  'Female',
                  'Other'
                ].map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
                onChanged: (value) => setState(() => gender = value),
                validator: (value) => value == null ? 'Please select gender' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Donation Date (if any)'),
                onSaved: (value) => lastDonationDate = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Medical History'),
                maxLines: 3,
                onSaved: (value) => medicalHistory = value,
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

