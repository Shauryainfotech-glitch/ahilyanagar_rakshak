import 'package:flutter/material.dart';

class TrackMyTripForm extends StatefulWidget {
  const TrackMyTripForm({super.key});

  @override
  _TrackMyTripFormState createState() => _TrackMyTripFormState();
}

class _TrackMyTripFormState extends State<TrackMyTripForm> {
  final _formKey = GlobalKey<FormState>();
  String? serviceType;
  String? serviceDescription;
  DateTime? preferredDate;
  TimeOfDay? preferredTime;
  String? location;
  String? additionalNotes;

  // New fields for applicant details
  String? applicantName;
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track My Trip')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                decoration: InputDecoration(labelText: 'Address'),
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
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Service Type'),
                items: [
                  'Police Verification',
                  'NOC',
                  'Character Certificate',
                  'Event Permission',
                  'Other'
                ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => serviceType = value),
                validator: (value) => value == null ? 'Select service type' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description of Service Needed'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Enter service description' : null,
                onSaved: (value) => serviceDescription = value,
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) setState(() => preferredDate = picked);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Preferred Date',
                      hintText: preferredDate == null ? 'Select date' : preferredDate.toString().split(' ')[0],
                    ),
                    validator: (value) => preferredDate == null ? 'Select preferred date' : null,
                  ),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) setState(() => preferredTime = picked);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Preferred Time',
                      hintText: preferredTime == null ? 'Select time' : preferredTime!.format(context),
                    ),
                    validator: (value) => preferredTime == null ? 'Select preferred time' : null,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location/Address'),
                validator: (value) => value == null || value.isEmpty ? 'Enter location/address' : null,
                onSaved: (value) => location = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Additional Notes (optional)'),
                maxLines: 2,
                onSaved: (value) => additionalNotes = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted!')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
