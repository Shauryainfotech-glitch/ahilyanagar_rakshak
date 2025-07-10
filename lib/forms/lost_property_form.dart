import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class LostPropertyForm extends StatefulWidget {
  const LostPropertyForm({super.key});

  @override
  _LostPropertyFormState createState() => _LostPropertyFormState();
}

class _LostPropertyFormState extends State<LostPropertyForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? contact;
  String? propertyType;
  String? lostDate;
  String? location;
  String? description;
  String? email;
  String? altContact;
  String? gender;
  DateTime? dob;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.lostProperty)),
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
                onSaved: (value) => contact = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantEmail),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmail : null,
                onSaved: (value) => email = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Property Type'),
                items: [
                  'Mobile Phone',
                  'Wallet',
                  'Keys',
                  'Documents',
                  'Jewelry',
                  'Electronics',
                  'Vehicle',
                  'Other'
                ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => propertyType = value),
                validator: (value) => value == null ? 'Please select property type' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date Lost'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter date lost' : null,
                onSaved: (value) => lostDate = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Where Lost'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter location' : null,
                onSaved: (value) => location = value,
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
                decoration: InputDecoration(labelText: 'Alternative Contact'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => altContact = value,
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
