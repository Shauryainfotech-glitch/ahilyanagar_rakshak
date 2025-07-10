import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ArrestSearchForm extends StatefulWidget {
  const ArrestSearchForm({super.key});

  @override
  _ArrestSearchFormState createState() => _ArrestSearchFormState();
}

class _ArrestSearchFormState extends State<ArrestSearchForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? searchType;
  String? personName;
  String? personAge;
  String? personAddress;
  DateTime? lastSeenDate;
  String? description;
  String? idProofType;
  String? idProofNumber;

  final List<String> _searchTypes = [
    'By Name',
    'By Address',
    'By Description',
  ];

  Future<void> _selectLastSeenDate(BuildContext context) async {
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
    if (picked != null && picked != lastSeenDate) {
      setState(() {
        lastSeenDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.arrestSearch)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text('Applicant Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantName,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterYourName : null,
              onSaved: (value) => applicantName = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantContactNumber,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterContactNumber : null,
              onSaved: (value) => applicantContact = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantEmail,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterEmail : null,
              onSaved: (value) => applicantEmail = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.address,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_on),
              ),
              maxLines: 2,
              validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.enterAddress : null,
              onSaved: (value) => applicantAddress = value,
            ),
            const SizedBox(height: 24),
            Text('Search Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[800])),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Search Type',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.search),
              ),
              items: _searchTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              onChanged: (value) => setState(() => searchType = value),
              validator: (value) => value == null ? 'Please select search type' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Person Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter person name' : null,
              onSaved: (value) => personName = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Person Age',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.cake),
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty ? 'Please enter person age' : null,
              onSaved: (value) => personAge = value,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Person Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.home),
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter person address' : null,
              onSaved: (value) => personAddress = value,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _selectLastSeenDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Seen Date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: lastSeenDate == null ? '' : '${lastSeenDate!.day}/${lastSeenDate!.month}/${lastSeenDate!.year}'
                  ),
                  validator: (value) => lastSeenDate == null ? 'Please select last seen date' : null,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Please enter description' : null,
              onSaved: (value) => description = value,
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
                      title: const Text('Search Submitted'),
                      content: Text('Your arrest search request has been submitted successfully.'),
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
                  const Icon(Icons.search),
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

