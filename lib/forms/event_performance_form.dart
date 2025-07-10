import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class EventPerformanceForm extends StatefulWidget {
  const EventPerformanceForm({super.key});

  @override
  _EventPerformanceFormState createState() => _EventPerformanceFormState();
}

class _EventPerformanceFormState extends State<EventPerformanceForm> {
  final _formKey = GlobalKey<FormState>();
  String? eventName;
  String? organizer;
  DateTime? eventDate;
  String? location;
  String? performanceDetails;
  String? remarks;
  String? idProofType;
  String? idProofNumber;

  Future<void> _selectEventDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[800]!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != eventDate) {
      setState(() {
        eventDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.eventPerformance)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('Event Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.event),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter event name' : null,
              onSaved: (value) => eventName = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Organizer Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter organizer name' : null,
              onSaved: (value) => organizer = value,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _selectEventDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event Date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: eventDate == null ? '' : '${eventDate!.day}/${eventDate!.month}/${eventDate!.year}'
                  ),
                  validator: (value) => eventDate == null ? 'Please select event date' : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Event Location',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_city),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter event location' : null,
              onSaved: (value) => location = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Performance Details',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.info_outline),
              ),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Please enter performance details' : null,
              onSaved: (value) => performanceDetails = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Remarks (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.comment),
              ),
              maxLines: 2,
              onSaved: (value) => remarks = value,
            ),
            const SizedBox(height: 24),
            Text('ID Proof', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.idProofType,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.credit_card),
              ),
              items: [
                AppLocalizations.of(context)!.aadhaar,
                AppLocalizations.of(context)!.pan,
                AppLocalizations.of(context)!.voterId,
                AppLocalizations.of(context)!.passport,
                AppLocalizations.of(context)!.other,
              ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) => setState(() => idProofType = value),
              validator: (value) => value == null ? 'Please select ID proof type' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'ID Proof Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.numbers),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter ID proof number' : null,
              onSaved: (value) => idProofNumber = value,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Report Submitted'),
                      content: Text('Your event performance report has been submitted successfully.'),
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
                  const Icon(Icons.send),
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
}
