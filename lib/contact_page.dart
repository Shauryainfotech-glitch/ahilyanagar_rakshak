import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Emergency', 'Police', 'Stations', 'Helpline', 'News'];
  final TextEditingController _searchController = TextEditingController();

  // Sample dynamic news data for Ahilyanagar Police
  // Sample dynamic news data for Ahilyanagar Police
  final List<Map<String, String>> _newsList = [
    {
      'title': 'Ahilyanagar Police Launches New Safety App',
      'description': 'The Ahilyanagar Police have launched a new safety app for citizens. Download now to stay updated and safe!',
      'url': 'https://ahilyanagarpolice.gov.in/news/app-launch',
      'date': '2024-01-15',
    },
    {
      'title': 'Awareness Drive on Cyber Safety',
      'description': 'A special awareness drive on cyber safety will be held at the city auditorium this Friday.',
      'url': 'https://ahilyanagarpolice.gov.in/news/cyber-safety',
      'date': '2024-01-12',
    },
    {
      'title': 'Blood Donation Camp Organized',
      'description': 'Join the blood donation camp organized by Ahilyanagar Police on 15th July at Police HQ.',
      'url': 'https://ahilyanagarpolice.gov.in/news/blood-donation',
      'date': '2024-01-10',
    },
    {
      'title': 'Traffic Safety Campaign',
      'description': 'Ahilyanagar Police launches traffic safety campaign to reduce accidents.',
      'url': 'https://ahilyanagarpolice.gov.in/news/traffic-safety',
      'date': '2024-01-08',
    },
  ];

  // Police station locations with addresses and coordinates
  final List<Map<String, dynamic>> _policeStations = [
    {
      'name': 'Ahilyanagar Police Station',
      'address': 'Police Station Road, Ahilyanagar, Maharashtra 413501',
      'phone': '02462-123456',
      'email': 'ahilyanagar.ps@maharashtrapolice.gov.in',
      'latitude': 19.0760,
      'longitude': 72.8777,
      'officer': 'Inspector Sharma',
      'officer_phone': '02462-123458',
    },
    {
      'name': 'Ahilyanagar Traffic Police Station',
      'address': 'Main Road, Near Bus Stand, Ahilyanagar, Maharashtra 413501',
      'phone': '02462-123457',
      'email': 'ahilyanagar.traffic@maharashtrapolice.gov.in',
      'latitude': 19.0765,
      'longitude': 72.8782,
      'officer': 'Inspector Deshmukh',
      'officer_phone': '02462-123461',
    },
    {
      'name': 'Ahilyanagar Cyber Crime Cell',
      'address': 'Police HQ, Cyber Crime Wing, Ahilyanagar, Maharashtra 413501',
      'phone': '02462-123458',
      'email': 'ahilyanagar.cyber@maharashtrapolice.gov.in',
      'latitude': 19.0755,
      'longitude': 72.8767,
      'officer': 'SI Singh',
      'officer_phone': '02462-123462',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1A1F35)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Enhanced Header
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A1F35), Color(0xFF2A2F45)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFE91E63), Color(0xFFF06292)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE91E63).withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(Icons.emergency_rounded, color: Colors.white, size: 28),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Emergency & Contact',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '24/7 Emergency Support',
                                style: TextStyle(
                                  color: Color(0xFF64B5F6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF3F51B5).withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search emergency numbers...',
                          prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF64B5F6)),
                          filled: true,
                          fillColor: Color(0xFF2A2F45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xFF3F51B5).withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xFF64B5F6), width: 2),
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    // Enhanced Tab Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2F45),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        tabs: _tabs.map((t) => Tab(
                          child: Text(
                            t,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        )).toList(),
                        indicatorColor: Color(0xFFE91E63),
                        indicatorWeight: 3,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        dividerColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _EmergencySection(search: _searchController.text),
                    _PoliceContacts(search: _searchController.text),
                    _PoliceStations(search: _searchController.text),
                    _HelplineList(search: _searchController.text),
                    _buildNewsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _newsList.length,
      itemBuilder: (context, index) {
        final news = _newsList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Color(0xFF2A2F45),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.article_rounded, color: Colors.white, size: 24),
            ),
            title: Text(
              news['title'] ?? '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  news['description'] ?? '',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${news['date']}',
                  style: TextStyle(color: Color(0xFF64B5F6), fontSize: 12),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.open_in_new_rounded, color: Color(0xFF64B5F6)),
              onPressed: () async {
                final url = news['url'];
                if (url != null && await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            onTap: () => _showNewsDialog(news),
          ),
        );
      },
    );
  }

  void _showNewsDialog(Map<String, String> news) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF2A2F45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          news['title'] ?? '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news['description'] ?? '',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 12),
            Text(
              'Date: ${news['date']}',
              style: TextStyle(color: Color(0xFF64B5F6), fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              'Read More',
              style: TextStyle(color: Color(0xFF64B5F6)),
            ),
            onPressed: () async {
              final url = news['url'];
              if (url != null && await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3F51B5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _EmergencySection extends StatelessWidget {
  final String search;
  const _EmergencySection({required this.search});

  final List<Map<String, dynamic>> emergencyNumbers = const [
    {
      'name': 'Police Emergency',
      'number': '100',
      'description': 'General Police Emergency',
      'icon': Icons.local_police_rounded,
      'color': Color(0xFFE91E63),
    },
    {
      'name': 'Women Helpline',
      'number': '1091',
      'description': 'Women Safety & Support',
      'icon': Icons.woman_rounded,
      'color': Color(0xFF9C27B0),
    },
    {
      'name': 'Child Helpline',
      'number': '1098',
      'description': 'Child Protection & Support',
      'icon': Icons.child_care_rounded,
      'color': Color(0xFFFF9800),
    },
    {
      'name': 'Ambulance',
      'number': '108',
      'description': 'Medical Emergency',
      'icon': Icons.medical_services_rounded,
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'Fire Emergency',
      'number': '101',
      'description': 'Fire & Rescue Services',
      'icon': Icons.local_fire_department_rounded,
      'color': Color(0xFFFF5722),
    },
    {
      'name': 'Disaster Management',
      'number': '1078',
      'description': 'National Disaster Response',
      'icon': Icons.warning_rounded,
      'color': Color(0xFFFFC107),
    },
    {
      'name': 'Railway Helpline',
      'number': '139',
      'description': 'Railway Emergency',
      'icon': Icons.train_rounded,
      'color': Color(0xFF795548),
    },
    {
      'name': 'Senior Citizen Helpline',
      'number': '14567',
      'description': 'Senior Citizen Support',
      'icon': Icons.elderly_rounded,
      'color': Color(0xFF607D8B),
    },
    {
      'name': 'Anti-Poison',
      'number': '1066',
      'description': 'Poison Information Center',
      'icon': Icons.sanitizer_rounded,
      'color': Color(0xFF8BC34A),
    },
    {
      'name': 'Blood Bank',
      'number': '104',
      'description': 'Blood Bank Information',
      'icon': Icons.bloodtype_rounded,
      'color': Color(0xFFE91E63),
    },
  ];

  Future<void> _callNumber(String number, BuildContext context) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot launch dialer on this device.'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  Future<void> _shareLocation(BuildContext context) async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final url = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch map.'),
            backgroundColor: Color(0xFFE91E63),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location error: $e'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  Future<void> _sendEmergencyEmail(BuildContext context) async {
    final Uri url = Uri(scheme: 'mailto', path: 'emergency@ahilyanagarpolice.gov.in');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot launch email app on this device.'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = emergencyNumbers.where((e) => 
      e['name'].toLowerCase().contains(search.toLowerCase()) ||
      e['number'].contains(search)
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Emergency Actions
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFFF06292)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE91E63).withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.emergency_rounded, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Emergency Actions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _callNumber('100', context),
                        icon: Icon(Icons.call_rounded),
                        label: Text('Call Police'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFFE91E63),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _shareLocation(context),
                        icon: Icon(Icons.location_on_rounded),
                        label: Text('Share Location'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFFE91E63),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _sendEmergencyEmail(context),
                        icon: Icon(Icons.email_rounded),
                        label: Text('Emergency Email'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFFE91E63),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          
          // Emergency Numbers
          Text(
            'Emergency Numbers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          
          ...filtered.map((emergency) => InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _callNumber(emergency['number'], context),
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Color(0xFF2A2F45),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: emergency['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(emergency['icon'], color: emergency['color'], size: 24),
                ),
                title: Text(
                  emergency['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      emergency['description'],
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      emergency['number'],
                      style: TextStyle(
                        color: emergency['color'],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [emergency['color'], emergency['color'].withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: emergency['color'].withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call_rounded, color: Colors.white),
                    onPressed: () => _callNumber(emergency['number'], context),
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class _PoliceContacts extends StatelessWidget {
  final String search;
  const _PoliceContacts({required this.search});

  final List<Map<String, String>> policeContacts = const [
    {'name': 'SP Ahilyanagar', 'phone': '02462-123456', 'designation': 'Superintendent of Police'},
    {'name': 'DSP Crime Branch', 'phone': '02462-123457', 'designation': 'Deputy SP Crime'},
    {'name': 'Inspector Sharma', 'phone': '02462-123458', 'designation': 'Station House Officer'},
    {'name': 'SI Patil', 'phone': '02462-123459', 'designation': 'Sub Inspector'},
    {'name': 'Constable Rao', 'phone': '02462-123460', 'designation': 'Head Constable'},
    {'name': 'Inspector Deshmukh', 'phone': '02462-123461', 'designation': 'Traffic Inspector'},
    {'name': 'SI Singh', 'phone': '02462-123462', 'designation': 'Cyber Crime SI'},
    {'name': 'Constable Kumar', 'phone': '02462-123463', 'designation': 'Beat Constable'},
    {'name': 'Inspector Joshi', 'phone': '02462-123464', 'designation': 'Women Cell Inspector'},
    {'name': 'SI Verma', 'phone': '02462-123465', 'designation': 'Narcotics SI'},
  ];

  Future<void> _callNumber(String number, BuildContext context) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot launch dialer on this device.'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = policeContacts.where((c) => 
      c['name']!.toLowerCase().contains(search.toLowerCase()) ||
      c['designation']!.toLowerCase().contains(search.toLowerCase()) ||
      c['phone']!.contains(search)
    ).toList();

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final contact = filtered[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Color(0xFF2A2F45),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF3F51B5).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.local_police_rounded, color: Colors.white, size: 24),
            ),
            title: Text(
              contact['name']!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  contact['designation']!,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  contact['phone']!,
                  style: TextStyle(
                    color: Color(0xFF64B5F6),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF4CAF50).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.call_rounded, color: Colors.white),
                onPressed: () => _callNumber(contact['phone']!, context),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HelplineList extends StatelessWidget {
  final String search;
  const _HelplineList({required this.search});

  final List<Map<String, dynamic>> helplines = const [
    {
      'name': 'Women Helpline',
      'phone': '1091',
      'description': '24/7 Women Safety Support',
      'icon': Icons.woman_rounded,
      'color': Color(0xFF9C27B0),
    },
    {
      'name': 'Child Helpline',
      'phone': '1098',
      'description': 'Child Protection & Welfare',
      'icon': Icons.child_care_rounded,
      'color': Color(0xFFFF9800),
    },
    {
      'name': 'Senior Citizen Helpline',
      'phone': '14567',
      'description': 'Senior Citizen Support',
      'icon': Icons.elderly_rounded,
      'color': Color(0xFF607D8B),
    },
    {
      'name': 'Mental Health Helpline',
      'phone': '1800-599-0019',
      'description': 'Mental Health Support',
      'icon': Icons.psychology_rounded,
      'color': Color(0xFF8BC34A),
    },
    {
      'name': 'Drug Abuse Helpline',
      'phone': '1800-11-0031',
      'description': 'Drug Abuse Prevention',
      'icon': Icons.medical_services_rounded,
      'color': Color(0xFFE91E63),
    },
    {
      'name': 'Cyber Crime Helpline',
      'phone': '1930',
      'description': 'Cyber Crime Reporting',
      'icon': Icons.computer_rounded,
      'color': Color(0xFF3F51B5),
    },
    {
      'name': 'Railway Helpline',
      'phone': '139',
      'description': 'Railway Emergency',
      'icon': Icons.train_rounded,
      'color': Color(0xFF795548),
    },
    {
      'name': 'Anti-Corruption Helpline',
      'phone': '1064',
      'description': 'Corruption Complaints',
      'icon': Icons.gavel_rounded,
      'color': Color(0xFFFF5722),
    },
  ];

  Future<void> _callNumber(String number, BuildContext context) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot launch dialer on this device.'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = helplines.where((h) => 
      h['name'].toLowerCase().contains(search.toLowerCase()) ||
      h['phone'].contains(search)
    ).toList();

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final helpline = filtered[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Color(0xFF2A2F45),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: helpline['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(helpline['icon'], color: helpline['color'], size: 24),
            ),
            title: Text(
              helpline['name'],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  helpline['description'],
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  helpline['phone'],
                  style: TextStyle(
                    color: helpline['color'],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [helpline['color'], helpline['color'].withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: helpline['color'].withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.call_rounded, color: Colors.white),
                onPressed: () => _callNumber(helpline['phone'], context),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PoliceStations extends StatelessWidget {
  final String search;
  const _PoliceStations({required this.search});

  final List<Map<String, dynamic>> policeStations = const [
    {
      'name': 'Ahilyanagar Police Station',
      'address': 'Police Station Road, Ahilyanagar, Maharashtra 413501',
      'phone': '02462-123456',
      'email': 'ahilyanagar.ps@maharashtrapolice.gov.in',
      'latitude': 19.0760,
      'longitude': 72.8777,
      'officer': 'Inspector Sharma',
      'officer_phone': '02462-123458',
    },
    {
      'name': 'Ahilyanagar Traffic Police Station',
      'address': 'Main Road, Near Bus Stand, Ahilyanagar, Maharashtra 413501',
      'phone': '02462-123457',
      'email': 'ahilyanagar.traffic@maharashtrapolice.gov.in',
      'latitude': 19.0765,
      'longitude': 72.8782,
      'officer': 'Inspector Deshmukh',
      'officer_phone': '02462-123461',
    },
    {
      'name': 'Ahilyanagar Cyber Crime Cell',
      'address': 'Police HQ, Cyber Crime Wing, Ahilyanagar, Maharashtra 413501',
      'phone': '02462-123458',
      'email': 'ahilyanagar.cyber@maharashtrapolice.gov.in',
      'latitude': 19.0755,
      'longitude': 72.8767,
      'officer': 'SI Singh',
      'officer_phone': '02462-123462',
    },
  ];

  Future<void> _callNumber(String number, BuildContext context) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot launch dialer on this device.'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  Future<void> _sendEmail(String email, BuildContext context) async {
    final Uri url = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot launch email app on this device.'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  Future<void> _openLocation(double latitude, double longitude, String name, BuildContext context) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch map.'),
          backgroundColor: Color(0xFFE91E63),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = policeStations.where((station) => 
      station['name'].toLowerCase().contains(search.toLowerCase()) ||
      station['address'].toLowerCase().contains(search.toLowerCase()) ||
      station['officer'].toLowerCase().contains(search.toLowerCase())
    ).toList();

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final station = filtered[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Color(0xFF2A2F45),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Station Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.location_on_rounded, color: Colors.white, size: 24),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            station['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            station['officer'],
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Station Details
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Address
                    Row(
                      children: [
                        Icon(Icons.home_rounded, color: Color(0xFF64B5F6), size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            station['address'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    
                    // Contact Actions
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _callNumber(station['phone'], context),
                            icon: Icon(Icons.call_rounded, size: 16),
                            label: Text('Call Station'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4CAF50),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _callNumber(station['officer_phone'], context),
                            icon: Icon(Icons.person_rounded, size: 16),
                            label: Text('Call Officer'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3F51B5),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _sendEmail(station['email'], context),
                            icon: Icon(Icons.email_rounded, size: 16),
                            label: Text('Email'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF9800),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _openLocation(station['latitude'], station['longitude'], station['name'], context),
                            icon: Icon(Icons.map_rounded, size: 16),
                            label: Text('Navigate'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE91E63),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
