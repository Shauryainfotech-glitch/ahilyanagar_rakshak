import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? contact;
  String? email;
  String? feedbackType;
  String? rating;
  String? feedback;
  String? suggestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.feedback)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.applicantName),
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterYourName : null,
                onSaved: (value) => name = value,
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
                decoration: InputDecoration(labelText: 'Feedback Type'),
                items: [
                  'General Feedback',
                  'Service Complaint',
                  'Appreciation',
                  'Suggestion',
                  'Bug Report',
                  'Other'
                ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (value) => setState(() => feedbackType = value),
                validator: (value) => value == null ? 'Please select feedback type' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Rating'),
                items: [
                  'Excellent (5 stars)',
                  'Very Good (4 stars)',
                  'Good (3 stars)',
                  'Fair (2 stars)',
                  'Poor (1 star)'
                ].map((rating) => DropdownMenuItem(value: rating, child: Text(rating))).toList(),
                onChanged: (value) => setState(() => rating = value),
                validator: (value) => value == null ? 'Please select a rating' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Your Feedback'),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty ? 'Please provide your feedback' : null,
                onSaved: (value) => feedback = value,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Suggestions for Improvement'),
                maxLines: 3,
                onSaved: (value) => suggestions = value,
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
