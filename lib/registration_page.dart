import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'services/firebase_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();
  
  bool _obscurePassword = true;
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;
  String? _errorMessage;
  final RegExp _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  String _name = '';
  String _gender = '';
  String _mobile = '';
  String _role = 'citizen'; // Default role
  String _policeId = ''; // For police and police mitr
  String _station = ''; // For police and police mitr
  DateTime? _createdAt;
  DateTime? _birthDate;

  // Role definitions
  static const Map<String, String> _roles = {
    'citizen': 'Citizen',
    'police': 'Police Officer',
    'police_mitr': 'Police Mitr',
  };

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _register() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      
      try {
        // Validate role-specific fields
        if (_role != 'citizen') {
          if (_policeId.isEmpty) {
            setState(() {
              _errorMessage = 'Police ID is required for ${_roles[_role]}';
              _isLoading = false;
            });
            return;
          }
          if (_station.isEmpty) {
            setState(() {
              _errorMessage = 'Police Station is required for ${_roles[_role]}';
              _isLoading = false;
            });
            return;
          }
        }

        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _email.trim(),
              password: _password.trim(),
            );
            
        final user = credential.user;
        if (user != null) {
          // Create user profile with role
          await _firebaseService.createUserProfile(
            uid: user.uid,
            name: _name,
            phone: _mobile,
            email: _email,
            address: '', // Can be added later
            emergencyContact: '', // Can be added later
          );

          // Add role-specific data
          Map<String, dynamic> roleData = {
            'role': _role,
            'email': _email,
            'name': _name,
            'mobile': _mobile,
            'gender': _gender,
            'birthDate': _birthDate != null
                ? _birthDate!.toIso8601String()
                : null,
            'createdAt': DateTime.now().toIso8601String(),
            'status': 'active',
          };

          // Add police-specific fields
          if (_role != 'citizen') {
            roleData['policeId'] = _policeId;
            roleData['station'] = _station;
            roleData['rank'] = _role == 'police' ? 'Officer' : 'Mitr';
            roleData['department'] = 'Ahilyanagar Police';
          }

          await FirebaseDatabase.instance.ref('users/${user.uid}').set(roleData);

          // Show success message based on role
          String successMessage = 'Registration successful! Welcome ${_roles[_role]}!';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(successMessage),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacementNamed(context, '/home');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message ?? 'Registration failed';
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Registration failed: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: theme.cardColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person_add_rounded,
                        size: 48,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Register',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Role Selection
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Role',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.work),
                        ),
                        value: _role,
                        items: _roles.entries.map((entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Row(
                            children: [
                              Icon(_getRoleIcon(entry.key)),
                              SizedBox(width: 8),
                              Text(entry.value),
                            ],
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _role = value ?? 'citizen';
                            // Clear police-specific fields when switching to citizen
                            if (_role == 'citizen') {
                              _policeId = '';
                              _station = '';
                            }
                          });
                        },
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Select your role',
                      ),
                      SizedBox(height: 16),
                      
                      // Name Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) =>
                            value != null && value.trim().isNotEmpty
                            ? null
                            : 'Enter your name',
                        onChanged: (value) => _name = value,
                      ),
                      SizedBox(height: 16),
                      
                      // Gender Field
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        value: _gender.isNotEmpty ? _gender : null,
                        items: ['Male', 'Female', 'Other']
                            .map(
                              (g) => DropdownMenuItem(value: g, child: Text(g)),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _gender = value ?? ''),
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Select gender',
                      ),
                      SizedBox(height: 16),
                      
                      // Mobile Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value != null && value.trim().length == 10
                            ? null
                            : 'Enter valid 10-digit mobile',
                        onChanged: (value) => _mobile = value,
                      ),
                      SizedBox(height: 16),
                      
                      // Email Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value != null && _emailRegExp.hasMatch(value)
                            ? null
                            : 'Enter a valid email',
                        onChanged: (value) => _email = value,
                      ),
                      SizedBox(height: 16),
                      
                      // Police-specific fields
                      if (_role != 'citizen') ...[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Police ID',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.badge),
                            hintText: 'Enter your official police ID',
                          ),
                          validator: (value) =>
                              value != null && value.trim().isNotEmpty
                              ? null
                              : 'Enter your police ID',
                          onChanged: (value) => _policeId = value,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Police Station',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                            hintText: 'e.g., Ahilyanagar Police Station',
                          ),
                          validator: (value) =>
                              value != null && value.trim().isNotEmpty
                              ? null
                              : 'Enter your police station',
                          onChanged: (value) => _station = value,
                        ),
                        SizedBox(height: 16),
                      ],
                      
                      // Password Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) => value != null && value.length >= 6
                            ? null
                            : 'Password must be at least 6 characters',
                        onChanged: (value) => _password = value,
                      ),
                      SizedBox(height: 16),
                      
                      // Confirm Password Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) => value == _password
                            ? null
                            : 'Passwords do not match',
                        onChanged: (value) => _confirmPassword = value,
                      ),
                      SizedBox(height: 16),
                      
                      // Birth Date Field
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000, 1, 1),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null)
                            setState(() => _birthDate = picked);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Birth Date',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            validator: (value) =>
                                _birthDate != null ? null : 'Select birth date',
                            controller: TextEditingController(
                              text: _birthDate != null
                                  ? "${_birthDate!.day.toString().padLeft(2, '0')}/${_birthDate!.month.toString().padLeft(2, '0')}/${_birthDate!.year}"
                                  : '',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      
                      // Role-specific information
                      if (_role != 'citizen') ...[
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue, size: 20),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'As a ${_roles[_role]}, you will have access to additional features including admin dashboard and patrol management.',
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                      
                      if (_errorMessage != null)
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(color: Colors.red[700]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 16),
                      
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _register,
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 48),
                              ),
                              child: Text('Register as ${_roles[_role]}'),
                            ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        child: Text('Already have an account? Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'citizen':
        return Icons.person;
      case 'police':
        return Icons.security;
      case 'police_mitr':
        return Icons.people;
      default:
        return Icons.person;
    }
  }
}
