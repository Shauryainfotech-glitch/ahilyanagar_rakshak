import 'package:flutter/material.dart';

class BloodRequestForm extends StatefulWidget {
  @override
  _BloodRequestFormState createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<BloodRequestForm> {
  final _formKey = GlobalKey<FormState>();
  String? requesterName;
  String? requesterContact;
  String? requesterEmail;
  String? requesterAddress;
  String? patientName;
  String? patientAge;
  String? bloodGroup;
  String? unitsRequired;
  String? hospitalName;
  String? hospitalAddress;
  String? urgency;
  String? reason;
  String? requiredDate;
  String? idProofType;
  String? idProofNumber;
  String? emergencyContactName;
  String? emergencyContactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Request'),
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
                      colors: [Color(0xFFD32F2F), Color(0xFFEF5350)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD32F2F).withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.bloodtype_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Blood Request Form',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Request blood for emergency needs',
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
                
                // Requester Information Section
                Text(
                  'Requester Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Requester Name',
                    prefixIcon: Icon(Icons.person_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                  onSaved: (value) => requesterName = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Requester Contact Number',
                    prefixIcon: Icon(Icons.phone_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter contact number' : null,
                  onSaved: (value) => requesterContact = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Requester Email',
                    prefixIcon: Icon(Icons.email_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter email address' : null,
                  onSaved: (value) => requesterEmail = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Requester Address',
                    prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your address' : null,
                  onSaved: (value) => requesterAddress = value,
                ),
                SizedBox(height: 24),
                
                // Patient Information Section
                Text(
                  'Patient Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Patient Name',
                    prefixIcon: Icon(Icons.person_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter patient name' : null,
                  onSaved: (value) => patientName = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Patient Age',
                    prefixIcon: Icon(Icons.calendar_today_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter patient age' : null,
                  onSaved: (value) => patientAge = value,
                ),
                SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Required Blood Group',
                    prefixIcon: Icon(Icons.bloodtype_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
                  ].map((group) => DropdownMenuItem(value: group, child: Text(group))).toList(),
                  onChanged: (value) => setState(() => bloodGroup = value),
                  validator: (value) => value == null ? 'Please select blood group' : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Units Required',
                    prefixIcon: Icon(Icons.numbers_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter units required' : null,
                  onSaved: (value) => unitsRequired = value,
                ),
                SizedBox(height: 24),
                
                // Hospital Information Section
                Text(
                  'Hospital Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hospital Name',
                    prefixIcon: Icon(Icons.local_hospital_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter hospital name' : null,
                  onSaved: (value) => hospitalName = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hospital Address',
                    prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 2,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter hospital address' : null,
                  onSaved: (value) => hospitalAddress = value,
                ),
                SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Urgency Level',
                    prefixIcon: Icon(Icons.priority_high_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    'Emergency - Immediate',
                    'Urgent - Within 24 hours',
                    'Normal - Within 48 hours',
                    'Planned - Within a week'
                  ].map((urgency) => DropdownMenuItem(value: urgency, child: Text(urgency))).toList(),
                  onChanged: (value) => setState(() => this.urgency = value),
                  validator: (value) => value == null ? 'Please select urgency level' : null,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Required Date',
                    prefixIcon: Icon(Icons.event_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    hintText: 'DD/MM/YYYY',
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter required date' : null,
                  onSaved: (value) => requiredDate = value,
                ),
                SizedBox(height: 16),
                
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Reason for Blood Requirement',
                    prefixIcon: Icon(Icons.medical_services_rounded, color: Color(0xFF64B5F6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter reason' : null,
                  onSaved: (value) => reason = value,
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
                      colors: [Color(0xFFD32F2F), Color(0xFFEF5350)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD32F2F).withOpacity(0.3),
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
                                Icon(Icons.bloodtype_rounded, color: Colors.white),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Blood request submitted successfully! We will contact you soon.',
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
                      'Submit Blood Request',
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

