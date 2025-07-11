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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Text(
                          'Contacts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.black87),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search contacts...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                tabs: _tabs.map((t) => Tab(
                  child: Text(
                    t,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                )).toList(),
                indicatorColor: Colors.blue[600],
                indicatorWeight: 3,
                labelColor: Colors.blue[600],
                unselectedLabelColor: Colors.grey[600],
                dividerColor: Colors.grey[300],
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
    );
  }

  Widget _buildNewsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _newsList.length,
      itemBuilder: (context, index) {
        final news = _newsList[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.article, color: Colors.blue[600]),
            ),
            title: Text(
              news['title'] ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  news['description'] ?? '',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${news['date']}',
                  style: TextStyle(color: Colors.blue[600], fontSize: 12),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.open_in_new, color: Colors.blue[600]),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          news['title'] ?? '',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news['description'] ?? '',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 12),
            Text(
              'Date: ${news['date']}',
              style: TextStyle(color: Colors.blue[600], fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Read More', style: TextStyle(color: Colors.blue[600])),
            onPressed: () async {
              final url = news['url'];
              if (url != null && await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
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
      'icon': Icons.local_police,
      'color': Colors.red,
    },
    {
      'name': 'Women Helpline',
      'number': '1091',
      'description': 'Women Safety & Support',
      'icon': Icons.woman,
      'color': Colors.purple,
    },
    {
      'name': 'Child Helpline',
      'number': '1098',
      'description': 'Child Protection & Support',
      'icon': Icons.child_care,
      'color': Colors.orange,
    },
    {
      'name': 'Ambulance',
      'number': '108',
      'description': 'Medical Emergency',
      'icon': Icons.medical_services,
      'color': Colors.green,
    },
    {
      'name': 'Fire Emergency',
      'number': '101',
      'description': 'Fire & Rescue Services',
      'icon': Icons.local_fire_department,
      'color': Colors.deepOrange,
    },
    {
      'name': 'Disaster Management',
      'number': '1078',
      'description': 'National Disaster Response',
      'icon': Icons.warning,
      'color': Colors.amber,
    },
    {
      'name': 'Railway Helpline',
      'number': '139',
      'description': 'Railway Emergency',
      'icon': Icons.train,
      'color': Colors.brown,
    },
    {
      'name': 'Senior Citizen Helpline',
      'number': '14567',
      'description': 'Senior Citizen Support',
      'icon': Icons.elderly,
      'color': Colors.blueGrey,
    },
    {
      'name': 'Anti-Poison',
      'number': '1066',
      'description': 'Poison Information Center',
      'icon': Icons.sanitizer,
      'color': Colors.lightGreen,
    },
    {
      'name': 'Blood Bank',
      'number': '104',
      'description': 'Blood Bank Information',
      'icon': Icons.bloodtype,
      'color': Colors.red,
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
          backgroundColor: Colors.red,
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

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final emergency = filtered[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: emergency['color'].withOpacity(0.1),
              child: Icon(emergency['icon'], color: emergency['color']),
            ),
            title: Text(
              emergency['name'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  emergency['description'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(height: 4),
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
            trailing: IconButton(
              icon: Icon(Icons.call, color: emergency['color']),
              onPressed: () => _callNumber(emergency['number'], context),
            ),
          ),
        );
      },
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
          backgroundColor: Colors.red,
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

    // Group contacts by first letter
    Map<String, List<Map<String, String>>> groupedContacts = {};
    for (var contact in filtered) {
      String firstLetter = contact['name']![0].toUpperCase();
      if (!groupedContacts.containsKey(firstLetter)) {
        groupedContacts[firstLetter] = [];
      }
      groupedContacts[firstLetter]!.add(contact);
    }

    List<String> sortedLetters = groupedContacts.keys.toList()..sort();

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: sortedLetters.length,
      itemBuilder: (context, index) {
        String letter = sortedLetters[index];
        List<Map<String, String>> contacts = groupedContacts[letter]!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                ),
              ),
            ),
            // Contacts in this section
            ...contacts.map((contact) => Card(
              margin: EdgeInsets.only(bottom: 1),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Text(
                    contact['name']![0],
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  contact['name']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact['designation']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      contact['phone']!,
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.call, color: Colors.green[600]),
                  onPressed: () => _callNumber(contact['phone']!, context),
                ),
              ),
            )).toList(),
          ],
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
      'icon': Icons.woman,
      'color': Colors.purple,
    },
    {
      'name': 'Child Helpline',
      'phone': '1098',
      'description': 'Child Protection & Welfare',
      'icon': Icons.child_care,
      'color': Colors.orange,
    },
    {
      'name': 'Senior Citizen Helpline',
      'phone': '14567',
      'description': 'Senior Citizen Support',
      'icon': Icons.elderly,
      'color': Colors.blueGrey,
    },
    {
      'name': 'Mental Health Helpline',
      'phone': '1800-599-0019',
      'description': 'Mental Health Support',
      'icon': Icons.psychology,
      'color': Colors.lightGreen,
    },
    {
      'name': 'Drug Abuse Helpline',
      'phone': '1800-11-0031',
      'description': 'Drug Abuse Prevention',
      'icon': Icons.medical_services,
      'color': Colors.red,
    },
    {
      'name': 'Cyber Crime Helpline',
      'phone': '1930',
      'description': 'Cyber Crime Reporting',
      'icon': Icons.computer,
      'color': Colors.blue,
    },
    {
      'name': 'Railway Helpline',
      'phone': '139',
      'description': 'Railway Emergency',
      'icon': Icons.train,
      'color': Colors.brown,
    },
    {
      'name': 'Anti-Corruption Helpline',
      'phone': '1064',
      'description': 'Corruption Complaints',
      'icon': Icons.gavel,
      'color': Colors.deepOrange,
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
          backgroundColor: Colors.red,
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
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: helpline['color'].withOpacity(0.1),
              child: Icon(helpline['icon'], color: helpline['color']),
            ),
            title: Text(
              helpline['name'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  helpline['description'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(height: 4),
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
            trailing: IconButton(
              icon: Icon(Icons.call, color: helpline['color']),
              onPressed: () => _callNumber(helpline['phone'], context),
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
          backgroundColor: Colors.red,
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
          backgroundColor: Colors.red,
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
          backgroundColor: Colors.red,
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
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              // Station Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.location_on, color: Colors.blue[600]),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            station['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            station['officer'],
                            style: TextStyle(
                              color: Colors.grey[600],
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
                        Icon(Icons.home, color: Colors.grey[600], size: 20),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            station['address'],
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // Contact Actions
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _callNumber(station['phone'], context),
                            icon: Icon(Icons.call, size: 16),
                            label: Text('Call Station'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
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
                            icon: Icon(Icons.person, size: 16),
                            label: Text('Call Officer'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[600],
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
                            icon: Icon(Icons.email, size: 16),
                            label: Text('Email'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[600],
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
                            icon: Icon(Icons.map, size: 16),
                            label: Text('Navigate'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
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
