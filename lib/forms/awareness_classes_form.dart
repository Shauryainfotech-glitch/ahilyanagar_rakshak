import 'package:flutter/material.dart';

class AwarenessClassesForm extends StatefulWidget {
  @override
  _AwarenessClassesFormState createState() => _AwarenessClassesFormState();
}

class _AwarenessClassesFormState extends State<AwarenessClassesForm> {
  final _formKey = GlobalKey<FormState>();
  String? applicantName;
  String? applicantContact;
  String? applicantEmail;
  String? applicantAddress;
  String? organizationName;
  String? organizationType;
  String? participantCount;
  String? preferredDate;
  String? preferredTime;
  String? venue;
  String? topic;
  String? description;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awareness Classes'),
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
                      colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF4CAF50).withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Awareness Classes Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Request police awareness sessions',
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
                
                // Applicant Information Section
                Text(
                  'Applicant Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Applicant Name',
                    prefixIcon: Icon(Icons.person_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                  onSaved: (value) => applicantName = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Applicant Contact Number',
                    prefixIcon: Icon(Icons.phone_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter contact number' : null,
                  onSaved: (value) => applicantContact = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Applicant Email',
                    prefixIcon: Icon(Icons.email_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter email address' : null,
                  onSaved: (value) => applicantEmail = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Applicant Address',
                    prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
                  onSaved: (value) => applicantAddress = value,
                ),
                SizedBox(height: 24),
                
                // Organization Information Section
                Text(
                  'Organization Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Organization Name',
                    prefixIcon: Icon(Icons.business_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter organization name' : null,
                  onSaved: (value) => organizationName = value,
                ),
                SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Organization Type',
                    prefixIcon: Icon(Icons.category_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    'School',
                    'College',
                    'University',
                    'Corporate Office',
                    'Community Center',
                    'NGO',
                    'Government Office',
                    'Other'
                  ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                  onChanged: (value) => setState(() => organizationType = value),
                  validator: (value) => value == null ? 'Please select organization type' : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Expected Number of Participants',
                    prefixIcon: Icon(Icons.people_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter participant count' : null,
                  onSaved: (value) => participantCount = value,
                ),
                SizedBox(height: 24),
                
                // Session Details Section
                Text(
                  'Session Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Preferred Date',
                    prefixIcon: Icon(Icons.event_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    hintText: 'DD/MM/YYYY',
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter preferred date' : null,
                  onSaved: (value) => preferredDate = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Preferred Time',
                    prefixIcon: Icon(Icons.access_time_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    hintText: 'HH:MM AM/PM',
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter preferred time' : null,
                  onSaved: (value) => preferredTime = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Venue/Address',
                    prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter venue' : null,
                  onSaved: (value) => venue = value,
                ),
                SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Awareness Topic',
                    prefixIcon: Icon(Icons.topic_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    'Cyber Security',
                    'Women Safety',
                    'Traffic Rules',
                    'Drug Awareness',
                    'Child Safety',
                    'Senior Citizen Safety',
                    'Financial Fraud Prevention',
                    'Other'
                  ].map((topic) => DropdownMenuItem(value: topic, child: Text(topic))).toList(),
                  onChanged: (value) => setState(() => this.topic = value),
                  validator: (value) => value == null ? 'Please select awareness topic' : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Additional Requirements',
                    prefixIcon: Icon(Icons.description_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 3,
                  onSaved: (value) => description = value,
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
                      colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF4CAF50).withOpacity(0.3),
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
                                Icon(Icons.school_rounded, color: Colors.white),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Awareness class request submitted successfully!',
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
                      'Submit Request',
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

