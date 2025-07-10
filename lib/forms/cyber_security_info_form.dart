import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CyberSecurityInfoForm extends StatefulWidget {
  const CyberSecurityInfoForm({super.key});

  @override
  _CyberSecurityInfoFormState createState() => _CyberSecurityInfoFormState();
}

class _CyberSecurityInfoFormState extends State<CyberSecurityInfoForm> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _securityTopics = [
    {
      'title': 'Password Security',
      'icon': Icons.lock,
      'content': [
        'Use strong, unique passwords for each account',
        'Include a mix of uppercase, lowercase, numbers, and symbols',
        'Avoid using personal information like birth dates',
        'Consider using a password manager',
        'Enable two-factor authentication (2FA)',
        'Change passwords regularly, especially for important accounts',
      ],
    },
    {
      'title': 'Email Security',
      'icon': Icons.email,
      'content': [
        'Never click on suspicious links in emails',
        'Don\'t open attachments from unknown senders',
        'Verify sender email addresses carefully',
        'Be cautious of urgent or threatening messages',
        'Use spam filters and report phishing attempts',
        'Never share personal information via email',
      ],
    },
    {
      'title': 'Social Media Safety',
      'icon': Icons.people,
      'content': [
        'Review and adjust privacy settings regularly',
        'Be careful about what you share publicly',
        'Don\'t accept friend requests from strangers',
        'Think before posting personal information',
        'Use strong privacy controls',
        'Report suspicious or abusive behavior',
      ],
    },
    {
      'title': 'Online Banking',
      'icon': Icons.account_balance,
      'content': [
        'Only use secure, official banking apps',
        'Never share OTP or banking credentials',
        'Log out after each session',
        'Monitor account activity regularly',
        'Use secure networks for banking',
        'Report suspicious transactions immediately',
      ],
    },
    {
      'title': 'Mobile Security',
      'icon': Icons.phone_android,
      'content': [
        'Keep your device and apps updated',
        'Use screen lock with strong authentication',
        'Only download apps from official stores',
        'Review app permissions carefully',
        'Enable remote tracking and wiping',
        'Backup important data regularly',
      ],
    },
    {
      'title': 'Public Wi-Fi Safety',
      'icon': Icons.wifi,
      'content': [
        'Avoid accessing sensitive accounts on public Wi-Fi',
        'Use a VPN when connecting to public networks',
        'Turn off automatic Wi-Fi connections',
        'Verify network names before connecting',
        'Don\'t perform banking on public networks',
        'Consider using mobile data for sensitive tasks',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cyberSecurityInfo),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue[50],
            child: Column(
              children: [
                Icon(
                  Icons.security,
                  size: 48,
                  color: Colors.blue[800],
                ),
                const SizedBox(height: 8),
                Text(
                  'Stay Safe Online',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Essential cyber security tips to protect yourself',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          // Tab bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              onTap: (index) => setState(() => _selectedIndex = index),
              isScrollable: true,
              labelColor: Colors.blue[800],
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Colors.blue[800],
              tabs: _securityTopics.map((topic) => Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(topic['icon'], size: 16),
                    const SizedBox(width: 4),
                    Text(topic['title']),
                  ],
                ),
              )).toList(),
            ),
          ),
          
          // Content area
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _securityTopics.map((topic) => _buildTopicContent(topic)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicContent(Map<String, dynamic> topic) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Topic header
          Row(
            children: [
              Icon(
                topic['icon'],
                size: 32,
                color: Colors.blue[800],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  topic['title'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Security tips
          Text(
            'Security Tips:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          
          ...topic['content'].map<Widget>((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tip,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
          
          const SizedBox(height: 24),
          
          // Additional resources section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[800]),
                    const SizedBox(width: 8),
                    Text(
                      'Need Help?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'If you suspect you\'ve been a victim of cyber crime, contact the cyber crime helpline immediately.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.blue[800]),
                    const SizedBox(width: 4),
                    Text(
                      'Cyber Crime Helpline: 1930',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Share functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sharing ${topic['title']} tips...')),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share Tips'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Save to favorites functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Saved ${topic['title']} to favorites')),
                    );
                  },
                  icon: const Icon(Icons.bookmark_border),
                  label: const Text('Save'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue[800],
                    side: BorderSide(color: Colors.blue[800]!),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

