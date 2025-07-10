import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class RatePoliceStationForm extends StatefulWidget {
  const RatePoliceStationForm({super.key});

  @override
  _RatePoliceStationFormState createState() => _RatePoliceStationFormState();
}

class _RatePoliceStationFormState extends State<RatePoliceStationForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? contact;
  String? email;
  String? policeStationName;
  String? location;
  String? comments;
  
  double serviceQualityRating = 0;
  double responseTimeRating = 0;
  double professionalismRating = 0;
  double overallExperienceRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.ratePoliceStation)),
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
            Text('Police Station Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Police Station Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.local_police),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter police station name' : null,
              onSaved: (value) => policeStationName = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Location/Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_on),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter location' : null,
              onSaved: (value) => location = value,
            ),
            const SizedBox(height: 24),
            Text('Ratings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            _buildRatingRow('Service Quality', serviceQualityRating, (rating) {
              setState(() => serviceQualityRating = rating);
            }),
            const SizedBox(height: 12),
            _buildRatingRow('Response Time', responseTimeRating, (rating) {
              setState(() => responseTimeRating = rating);
            }),
            const SizedBox(height: 12),
            _buildRatingRow('Professionalism', professionalismRating, (rating) {
              setState(() => professionalismRating = rating);
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
                      content: Text('Your rating for $policeStationName has been submitted successfully.'),
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
                constraints: const BoxConstraints(), // Remove default min size
                padding: EdgeInsets.zero, // Remove extra padding
              );
            }),
          ),
        ),
      ],
    );
  }

  bool _validateRatings() {
    if (serviceQualityRating == 0 || responseTimeRating == 0 || 
        professionalismRating == 0 || overallExperienceRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide ratings for all categories')),
      );
      return false;
    }
    return true;
  }
}
