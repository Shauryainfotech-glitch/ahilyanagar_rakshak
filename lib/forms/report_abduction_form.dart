import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ReportAbductionForm extends StatefulWidget {
  const ReportAbductionForm({super.key});

  @override
  _ReportAbductionFormState createState() => _ReportAbductionFormState();
}

class _ReportAbductionFormState extends State<ReportAbductionForm> {
  final _formKey = GlobalKey<FormState>();
  String? reporterName;
  String? reporterContact;
  String? reporterAddress;
  String? victimName;
  String? victimAge;
  String? victimGender;
  String? victimAddress;
  DateTime? abductionDate;
  String? abductionPlace;
  String? description;
  String? suspectDetails;
  String? emergencyContact;

  final List<String> _genders = ['Male', 'Female', 'Other'];

  Future<void> _selectAbductionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
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
    if (picked != null && picked != abductionDate) {
      setState(() {
        abductionDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.reportAbduction)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('Reporter Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
              onSaved: (value) => reporterName = value,
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
              onSaved: (value) => reporterContact = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_on),
              ),
              maxLines: 2,
              validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
              onSaved: (value) => reporterAddress = value,
            ),
            const SizedBox(height: 24),
            Text('Victim Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Victim Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter victim name' : null,
              onSaved: (value) => victimName = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Victim Age',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.cake),
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty ? 'Please enter victim age' : null,
              onSaved: (value) => victimAge = value,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Victim Gender',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.wc),
              ),
              items: _genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (value) => setState(() => victimGender = value),
              validator: (value) => value == null ? 'Please select victim gender' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Victim Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_on),
              ),
              maxLines: 2,
              validator: (value) => value == null || value.isEmpty ? 'Please enter victim address' : null,
              onSaved: (value) => victimAddress = value,
            ),
            const SizedBox(height: 24),
            Text('Abduction Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _selectAbductionDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Abduction Date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: abductionDate == null ? '' : '${abductionDate!.day}/${abductionDate!.month}/${abductionDate!.year}'
                  ),
                  validator: (value) => abductionDate == null ? 'Please select abduction date' : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Abduction Place',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.place),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter abduction place' : null,
              onSaved: (value) => abductionPlace = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description of Incident',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Please enter description' : null,
              onSaved: (value) => description = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Suspect Details (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person_search),
              ),
              maxLines: 2,
              onSaved: (value) => suspectDetails = value,
            ),
            const SizedBox(height: 24),
            Text('Emergency Contact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Emergency Contact Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty ? 'Please enter emergency contact number' : null,
              onSaved: (value) => emergencyContact = value,
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
                      content: Text('Your abduction report has been submitted successfully.'),
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

