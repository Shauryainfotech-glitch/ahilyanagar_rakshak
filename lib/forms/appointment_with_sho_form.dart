import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AppointmentWithSHOForm extends StatefulWidget {
  const AppointmentWithSHOForm({super.key});

  @override
  _AppointmentWithSHOFormState createState() => _AppointmentWithSHOFormState();
}

class _AppointmentWithSHOFormState extends State<AppointmentWithSHOForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Personal Information
  String? applicantName;
  String? applicantContactNumber;
  String? applicantEmail;
  String? applicantAddress;
  String? idProofType;
  String? idProofNumber;
  
  // Appointment Details
  DateTime? preferredDate;
  TimeOfDay? preferredTime;
  String? appointmentPurpose;
  String? urgencyLevel;
  String? additionalNotes;
  
  // Available time slots
  final List<String> _timeSlots = [
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
    '04:00 PM - 05:00 PM',
  ];
  
  // Appointment purposes
  final List<String> _appointmentPurposes = [
    'General Inquiry',
    'Complaint Registration',
    'Case Follow-up',
    'Document Verification',
    'Character Certificate',
    'NOC Application',
    'Police Verification',
    'Other',
  ];
  
  // Urgency levels
  final List<String> _urgencyLevels = [
    'Low Priority',
    'Normal Priority',
    'High Priority',
    'Urgent',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
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
    if (picked != null && picked != preferredDate) {
      setState(() {
        preferredDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
    if (picked != null && picked != preferredTime) {
      setState(() {
        preferredTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appointmentWithSho),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 48,
                    color: Colors.blue[800],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Book Appointment with SHO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Schedule a meeting with the Station House Officer',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Personal Information Section
            _buildSectionHeader('Personal Information', Icons.person),
            const SizedBox(height: 12),
            
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) => value == null || value.isEmpty 
                  ? AppLocalizations.of(context)!.enterYourName 
                  : null,
              onSaved: (value) => applicantName = value,
            ),
            const SizedBox(height: 12),
            
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantContactNumber,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty 
                  ? AppLocalizations.of(context)!.enterContactNumber 
                  : null,
              onSaved: (value) => applicantContactNumber = value,
            ),
            const SizedBox(height: 12),
            
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.applicantEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty 
                  ? AppLocalizations.of(context)!.enterEmail 
                  : null,
              onSaved: (value) => applicantEmail = value,
            ),
            const SizedBox(height: 12),
            
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.address,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.location_on),
              ),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty 
                  ? AppLocalizations.of(context)!.enterAddress 
                  : null,
              onSaved: (value) => applicantAddress = value,
            ),
            const SizedBox(height: 12),
            
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.idProofType,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.numbers),
              ),
              validator: (value) => value == null || value.isEmpty 
                  ? 'Please enter ID proof number' 
                  : null,
              onSaved: (value) => idProofNumber = value,
            ),
            
            const SizedBox(height: 24),
            
            // Appointment Details Section
            _buildSectionHeader('Appointment Details', Icons.schedule),
            const SizedBox(height: 12),
            
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Purpose of Appointment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.assignment),
              ),
              items: _appointmentPurposes.map((purpose) => 
                DropdownMenuItem(value: purpose, child: Text(purpose))
              ).toList(),
              onChanged: (value) => setState(() => appointmentPurpose = value),
              validator: (value) => value == null ? 'Please select appointment purpose' : null,
            ),
            const SizedBox(height: 12),
            
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Urgency Level',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.priority_high),
              ),
              items: _urgencyLevels.map((level) => 
                DropdownMenuItem(value: level, child: Text(level))
              ).toList(),
              onChanged: (value) => setState(() => urgencyLevel = value),
              validator: (value) => value == null ? 'Please select urgency level' : null,
            ),
            const SizedBox(height: 12),
            
            // Date and Time Selection
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.blue[800]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              preferredDate == null 
                                  ? AppLocalizations.of(context)!.selectPreferredDate
                                  : '${preferredDate!.day}/${preferredDate!.month}/${preferredDate!.year}',
                              style: TextStyle(
                                color: preferredDate == null ? Colors.grey[600] : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blue[800]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              preferredTime == null 
                                  ? AppLocalizations.of(context)!.selectPreferredTime
                                  : preferredTime!.format(context),
                              style: TextStyle(
                                color: preferredTime == null ? Colors.grey[600] : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Additional Notes (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.note),
              ),
              maxLines: 3,
              onSaved: (value) => additionalNotes = value,
            ),
            
            const SizedBox(height: 24),
            
            // Information Box
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange[800]),
                      const SizedBox(width: 8),
                      Text(
                        'Important Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Please arrive 10 minutes before your scheduled appointment\n'
                    '• Bring all relevant documents and ID proof\n'
                    '• Dress appropriately for the meeting\n'
                    '• You will receive a confirmation SMS/Email',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Appointment Confirmation'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: $applicantName'),
                            Text('Contact: $applicantContactNumber'),
                            Text('Purpose: $appointmentPurpose'),
                            Text('Date: ${preferredDate?.day}/${preferredDate?.month}/${preferredDate?.year}'),
                            Text('Time: ${preferredTime?.format(context)}'),
                            const SizedBox(height: 16),
                            const Text(
                              'Your appointment request has been submitted successfully. You will receive a confirmation shortly.',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppLocalizations.of(context)!.formSubmitted)),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.submit,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue[800], size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
      ],
    );
  }
}

