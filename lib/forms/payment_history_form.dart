import 'package:flutter/material.dart';

class PaymentHistoryForm extends StatefulWidget {
  const PaymentHistoryForm({super.key});

  @override
  _PaymentHistoryFormState createState() => _PaymentHistoryFormState();
}

class _PaymentHistoryFormState extends State<PaymentHistoryForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? paymentId;
  String? date;
  String? amount;
  String? details;
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
      appBar: AppBar(title: Text('Payment History')),
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
                decoration: InputDecoration(labelText: 'Payment ID'),
                validator: (value) => value == null || value.isEmpty ? 'Enter payment ID' : null,
                onSaved: (value) => paymentId = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date'),
                onSaved: (value) => date = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => amount = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Details'),
                maxLines: 3,
                onSaved: (value) => details = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? 'Enter email' : null,
                onSaved: (value) => email = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alternate Contact Number'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => altContact = value,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (value) => setState(() => gender = value),
                validator: (value) => value == null ? 'Select gender' : null,
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => dob = picked);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: dob == null ? 'Select date' : dob.toString().split(' ')[0],
                    ),
                    validator: (value) => dob == null ? 'Select date of birth' : null,
                  ),
                ),
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
                      SnackBar(content: Text('Payment history submitted!')),
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
