import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class TrafficViolationDialog extends StatefulWidget {
  @override
  _TrafficViolationDialogState createState() => _TrafficViolationDialogState();
}

class _TrafficViolationDialogState extends State<TrafficViolationDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _vehicleNumberController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  String? _selectedViolationType;
  String? _selectedSeverity;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  
  bool _isLoading = false;
  List<Map<String, dynamic>> _searchResults = [];
  bool _hasSearched = false;
  
  // Photo capture variables
  final ImagePicker _picker = ImagePicker();
  File? _capturedImage;
  List<File> _capturedImages = [];

  final List<String> _violationTypes = [
    'Speeding',
    'Red Light Violation',
    'Illegal Parking',
    'Driving Without License',
    'Driving Under Influence',
    'Overloading',
    'Wrong Side Driving',
    'Using Mobile While Driving',
    'Not Wearing Helmet/Seatbelt',
    'Vehicle Without Registration',
    'Pollution Certificate Expired',
    'Other'
  ];

  final List<String> _severityLevels = [
    'Minor',
    'Moderate',
    'Major',
    'Critical'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _vehicleNumberController.dispose();
    _licenseNumberController.dispose();
    _phoneNumberController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _searchViolations() {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _searchResults = [
          {
            'id': 'TV001',
            'vehicleNumber': _vehicleNumberController.text,
            'violationType': 'Speeding',
            'date': '2024-01-15',
            'time': '14:30',
            'location': 'Main Road, Ahilyanagar',
            'fine': 1000,
            'status': 'Pending',
            'officer': 'Inspector Sharma',
            'description': 'Vehicle was driving at 80 km/h in a 40 km/h zone',
            'hasPhoto': true,
            'photoCount': 2
          },
          {
            'id': 'TV002',
            'vehicleNumber': _vehicleNumberController.text,
            'violationType': 'Red Light Violation',
            'date': '2024-01-10',
            'time': '09:15',
            'location': 'Traffic Signal, City Center',
            'fine': 500,
            'status': 'Paid',
            'officer': 'SI Deshmukh',
            'description': 'Vehicle crossed red light at traffic signal',
            'hasPhoto': false,
            'photoCount': 0
          }
        ];
      });
    });
  }

  void _reportViolation() {
    if (_vehicleNumberController.text.isEmpty ||
        _selectedViolationType == null ||
        _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Traffic violation reported successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _capturePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      
      if (photo != null) {
        setState(() {
          _capturedImage = File(photo.path);
          _capturedImages.add(File(photo.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error capturing photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      
      if (image != null) {
        setState(() {
          _capturedImage = File(image.path);
          _capturedImages.add(File(image.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _capturedImages.removeAt(index);
      if (_capturedImages.isEmpty) {
        _capturedImage = null;
      } else {
        _capturedImage = _capturedImages.last;
      }
    });
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1F35),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded, color: Color(0xFFFF9800)),
              title: const Text('Take Photo', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _capturePhoto();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded, color: Color(0xFFFF9800)),
              title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1F35), Color(0xFF2A2F45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.traffic_rounded, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Traffic Violation System',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Tab Bar
            Container(
              color: const Color(0xFF2A2F45),
              child: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFFFF9800),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                tabs: const [
                  Tab(text: 'Search', icon: Icon(Icons.search_rounded)),
                  Tab(text: 'Report', icon: Icon(Icons.report_rounded)),
                  Tab(text: 'Pay Fine', icon: Icon(Icons.payment_rounded)),
                  Tab(text: 'History', icon: Icon(Icons.history_rounded)),
                ],
              ),
            ),
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSearchTab(),
                  _buildReportTab(),
                  _buildPayFineTab(),
                  _buildHistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2F45),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF9800).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _vehicleNumberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Number',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.directions_car_rounded, color: Color(0xFFFF9800)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF9800))),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _searchViolations,
                  icon: _isLoading 
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.search_rounded),
                  label: Text(_isLoading ? 'Searching...' : 'Search Violations'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_hasSearched) ...[
            Text(
              'Search Results',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF9800)))
                : _searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No violations found for this vehicle',
                        style: TextStyle(color: Colors.white60),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final violation = _searchResults[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2F45),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9800).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.traffic_rounded, color: Color(0xFFFF9800), size: 20),
                            ),
                            title: Text(
                              violation['violationType'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date: ${violation['date']} at ${violation['time']}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  'Location: ${violation['location']}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fine: ₹${violation['fine']}',
                                      style: const TextStyle(
                                        color: Color(0xFFFF9800),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (violation['hasPhoto']) ...[
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF9800).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.photo_camera_rounded,
                                              color: Color(0xFFFF9800),
                                              size: 12,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${violation['photoCount']} photos',
                                              style: const TextStyle(
                                                color: Color(0xFFFF9800),
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: violation['status'] == 'Paid' 
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                violation['status'],
                                style: TextStyle(
                                  color: violation['status'] == 'Paid' ? Colors.green : Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2F45),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF9800).withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report Traffic Violation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _vehicleNumberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Number *',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.directions_car_rounded, color: Color(0xFFFF9800)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF9800))),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedViolationType,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Violation Type *',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.warning_rounded, color: Color(0xFFFF9800)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF9800))),
                  ),
                  dropdownColor: const Color(0xFF2A2F45),
                  items: _violationTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedViolationType = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _locationController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Location *',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFFFF9800)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF9800))),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _selectDate,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white30),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_rounded, color: Color(0xFFFF9800)),
                              const SizedBox(width: 8),
                              Text(
                                _selectedDate == null 
                                  ? 'Select Date'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: _selectTime,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white30),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time_rounded, color: Color(0xFFFF9800)),
                              const SizedBox(width: 8),
                              Text(
                                _selectedTime == null 
                                  ? 'Select Time'
                                  : _selectedTime!.format(context),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedSeverity,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Severity Level',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.priority_high_rounded, color: Color(0xFFFF9800)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF9800))),
                  ),
                  dropdownColor: const Color(0xFF2A2F45),
                  items: _severityLevels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSeverity = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Photo Capture Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F35),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFF9800).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.camera_alt_rounded, color: Color(0xFFFF9800), size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Evidence Photos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_capturedImages.length}/5',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Add photos as evidence of the traffic violation',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Photo Grid
                      if (_capturedImages.isNotEmpty) ...[
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                          itemCount: _capturedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white30),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      _capturedImages[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                      // Add Photo Button
                      if (_capturedImages.length < 5)
                        InkWell(
                          onTap: _showImageOptions,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFFF9800).withOpacity(0.5), style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFFF9800).withOpacity(0.1),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Color(0xFFFF9800),
                                  size: 24,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Add Photo',
                                  style: TextStyle(
                                    color: Color(0xFFFF9800),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.description_rounded, color: Color(0xFFFF9800)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF9800))),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _reportViolation,
                    icon: _isLoading 
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.send_rounded),
                    label: Text(_isLoading ? 'Reporting...' : 'Report Violation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9800),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayFineTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2F45),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF9800).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.payment_rounded, color: Color(0xFFFF9800), size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Pay Traffic Fine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter violation ID or vehicle number to pay fine',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Violation ID / Vehicle Number',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.search_rounded, color: Color(0xFFFF9800)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF9800))),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Show payment options
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFF1A1F35),
                        title: const Text('Payment Options', style: TextStyle(color: Colors.white)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.credit_card_rounded, color: Color(0xFFFF9800)),
                              title: const Text('Credit/Debit Card', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Redirecting to payment gateway...')),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.account_balance_rounded, color: Color(0xFFFF9800)),
                              title: const Text('Net Banking', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Redirecting to net banking...')),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone_android_rounded, color: Color(0xFFFF9800)),
                              title: const Text('UPI Payment', style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Redirecting to UPI...')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.payment_rounded),
                  label: const Text('Pay Fine'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    final List<Map<String, dynamic>> history = [
      {
        'id': 'TV001',
        'vehicleNumber': 'MH12AB1234',
        'violationType': 'Speeding',
        'date': '2024-01-15',
        'fine': 1000,
        'status': 'Paid',
        'paymentDate': '2024-01-16',
      },
      {
        'id': 'TV002',
        'vehicleNumber': 'MH12CD5678',
        'violationType': 'Red Light Violation',
        'date': '2024-01-10',
        'fine': 500,
        'status': 'Paid',
        'paymentDate': '2024-01-11',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Payment History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final record = history[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2F45),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 20),
                    ),
                    title: Text(
                      'Violation ID: ${record['id']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vehicle: ${record['vehicleNumber']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Type: ${record['violationType']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Date: ${record['date']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Payment: ${record['paymentDate']}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '₹${record['fine']}',
                      style: const TextStyle(
                        color: Color(0xFFFF9800),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 