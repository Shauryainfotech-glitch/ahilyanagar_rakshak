import 'package:flutter/material.dart';

class GrievanceRedressalForm extends StatefulWidget {
  const GrievanceRedressalForm({super.key});

  @override
  _GrievanceRedressalFormState createState() => _GrievanceRedressalFormState();
}

class _GrievanceRedressalFormState extends State<GrievanceRedressalForm> {
  final _formKey = GlobalKey<FormState>();
  String? complainantName;
  String? complainantContact;
  String? complainantEmail;
  String? complainantAddress;
  String? grievanceType;
  String? subject;
  String? description;
  String? incidentDate;
  String? incidentLocation;
  String? evidence;
  String? expectedResolution;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grievance Redressal'),
        backgroundColor: Color(0xFF1A1F35),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1A1F35)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFF5722).withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.gavel_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Grievance Redressal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'File your complaint or grievance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                
                // Complainant Information Section
                Text(
                  'Complainant Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Complainant Name',
                    prefixIcon: Icon(Icons.person_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                  onSaved: (value) => complainantName = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Complainant Contact Number',
                    prefixIcon: Icon(Icons.phone_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter contact number' : null,
                  onSaved: (value) => complainantContact = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Complainant Email',
                    prefixIcon: Icon(Icons.email_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter email address' : null,
                  onSaved: (value) => complainantEmail = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Complainant Address',
                    prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
                  onSaved: (value) => complainantAddress = value,
                ),
                SizedBox(height: 24),
                
                // Grievance Details Section
                Text(
                  'Grievance Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Grievance Type',
                    prefixIcon: Icon(Icons.category_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    'Police Misconduct',
                    'Delayed Response',
                    'Corruption',
                    'Harassment',
                    'Negligence',
                    'Discrimination',
                    'Service Quality',
                    'Other'
                  ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                  onChanged: (value) => setState(() => grievanceType = value),
                  validator: (value) => value == null ? 'Please select grievance type' : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Subject/Title',
                    prefixIcon: Icon(Icons.title_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter subject' : null,
                  onSaved: (value) => subject = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Detailed Description',
                    prefixIcon: Icon(Icons.description_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 4,
                  validator: (value) => value == null || value.isEmpty ? 'Please provide detailed description' : null,
                  onSaved: (value) => description = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Incident Date',
                    prefixIcon: Icon(Icons.event_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    hintText: 'DD/MM/YYYY',
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter incident date' : null,
                  onSaved: (value) => incidentDate = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Incident Location',
                    prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter incident location' : null,
                  onSaved: (value) => incidentLocation = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Evidence/Supporting Documents',
                    prefixIcon: Icon(Icons.attach_file_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  onSaved: (value) => evidence = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Expected Resolution',
                    prefixIcon: Icon(Icons.lightbulb_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 3,
                  onSaved: (value) => expectedResolution = value,
                ),
                SizedBox(height: 24),
                
                // ID Proof Section
                Text(
                  'ID Proof Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'ID Proof Type',
                    prefixIcon: Icon(Icons.credit_card_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    'Aadhaar', 'PAN', 'Voter ID', 'Passport', 'Driving License', 'Other'
                  ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                  onChanged: (value) => setState(() => idProofType = value),
                  validator: (value) => value == null ? 'Please select ID proof type' : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ID Proof Number',
                    prefixIcon: Icon(Icons.numbers_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter ID proof number' : null,
                  onSaved: (value) => idProofNumber = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Emergency Contact Name',
                    prefixIcon: Icon(Icons.emergency_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter emergency contact name' : null,
                  onSaved: (value) => emergencyContactName = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Emergency Contact Number',
                    prefixIcon: Icon(Icons.phone_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter emergency contact number' : null,
                  onSaved: (value) => emergencyContactNumber = value,
                ),
                SizedBox(height: 24),
                
                // Submit Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFF5722).withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.gavel_rounded, color: Colors.white),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Grievance submitted successfully! We will investigate and respond.',
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Color(0xFF4CAF50),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            margin: EdgeInsets.all(16),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      'Submit Grievance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

