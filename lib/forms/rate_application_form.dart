import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class RateApplicationForm extends StatefulWidget {
  const RateApplicationForm({super.key});

  @override
  _RateApplicationFormState createState() => _RateApplicationFormState();
}

class _RateApplicationFormState extends State<RateApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? contact;
  String? email;
  String? applicationType;
  String? referenceNumber;
  DateTime? applicationDate;
  String? comments;
  
  double userInterfaceRating = 0;
  double functionalityRating = 0;
  double responseTimeRating = 0;
  double overallExperienceRating = 0;

  final List<String> _applicationTypes = [
    'Complaint Registration',
    'FIR Download',
    'Appointment with SHO',
    'Lost Property',
    'Blood Request',
    'Event Performance',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.rateApplication)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('Your Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
              onSaved: (value) => name = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty ? 'Please enter your contact number' : null,
              onSaved: (value) => contact = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => email = value,
            ),
            const SizedBox(height: 24),
            Text('Application Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Application Type',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.app_registration),
              ),
              items: _applicationTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) => setState(() => applicationType = value),
              validator: (value) => value == null ? 'Please select application type' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Reference Number (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.numbers),
              ),
              onSaved: (value) => referenceNumber = value,
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => applicationDate = date);
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Application Date',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  applicationDate == null 
                    ? 'Select Date' 
                    : '${applicationDate!.day}/${applicationDate!.month}/${applicationDate!.year}',
                  style: TextStyle(
                    color: applicationDate == null ? Colors.grey[600] : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Ratings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            _buildRatingRow('User Interface', userInterfaceRating, (rating) {
              setState(() => userInterfaceRating = rating);
            }),
            const SizedBox(height: 12),
            _buildRatingRow('Functionality', functionalityRating, (rating) {
              setState(() => functionalityRating = rating);
            }),
            const SizedBox(height: 12),
            _buildRatingRow('Response Time', responseTimeRating, (rating) {
              setState(() => responseTimeRating = rating);
            }),
            const SizedBox(height: 12),
            _buildRatingRow('Overall Experience', overallExperienceRating, (rating) {
              setState(() => overallExperienceRating = rating);
            }),
            const SizedBox(height: 24),
            Text('Comments/Feedback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Additional Comments (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.comment),
              ),
              maxLines: 3,
              onSaved: (value) => comments = value,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && _validateRatings()) {
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Rating Submitted'),
                      content: Text('Your rating for $applicationType has been submitted successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.submit, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(String label, double rating, Function(double) onChanged) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          flex: 3,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () => onChanged(index + 1),
                icon: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: index < rating ? Colors.amber : Colors.grey,
                  size: 30,
                ),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              );
            }),
          ),
        ),
      ],
    );
  }

  bool _validateRatings() {
    if (userInterfaceRating == 0 || functionalityRating == 0 || 
        responseTimeRating == 0 || overallExperienceRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide ratings for all categories')),
      );
      return false;
    }
    return true;
  }
}

