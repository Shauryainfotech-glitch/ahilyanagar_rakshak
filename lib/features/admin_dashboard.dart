import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:geolocator/geolocator.dart';
import '../services/firebase_service.dart';
import '../services/location_service.dart';
import 'hotspot_mapping.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with TickerProviderStateMixin {
  final FirebaseService _firebaseService = FirebaseService();
  final LocationService _locationService = LocationService();
  
  late TabController _tabController;
  
  // Analytics data
  Map<String, dynamic> _analytics = {};
  List<Map<String, dynamic>> _recentComplaints = [];
  List<Map<String, dynamic>> _activeSOSAlerts = [];
  List<Map<String, dynamic>> _patrolOfficers = [];
  
  // Real-time streams
  StreamSubscription<DatabaseEvent>? _sosSubscription;
  StreamSubscription<DatabaseEvent>? _complaintsSubscription;
  StreamSubscription<DatabaseEvent>? _patrolsSubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadDashboardData();
    _setupRealTimeStreams();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _sosSubscription?.cancel();
    _complaintsSubscription?.cancel();
    _patrolsSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadDashboardData() async {
    try {
      // Load analytics
      _analytics = await _firebaseService.analyzePatterns();
      
      // Load recent complaints
      _loadRecentComplaints();
      
      // Load active SOS alerts
      _loadActiveSOSAlerts();
      
      // Load patrol officers
      _loadPatrolOfficers();
      
      setState(() {});
    } catch (e) {
      print('Error loading dashboard data: $e');
    }
  }

  void _setupRealTimeStreams() {
    // SOS alerts stream
    _sosSubscription = _firebaseService.getSOSAlertsStream().listen((event) {
      if (event.snapshot.value != null) {
        final alertsData = event.snapshot.value as Map<dynamic, dynamic>;
        _activeSOSAlerts = alertsData.entries.map((entry) {
          final data = entry.value as Map<dynamic, dynamic>;
          return {
            'id': entry.key,
            'userId': data['userId'],
            'latitude': data['latitude'],
            'longitude': data['longitude'],
            'description': data['description'],
            'status': data['status'],
            'createdAt': data['createdAt'],
          };
        }).toList();
        setState(() {});
      }
    });

    // Complaints stream
    _complaintsSubscription = _firebaseService.getAllComplaintsStream().listen((event) {
      if (event.snapshot.value != null) {
        final complaintsData = event.snapshot.value as Map<dynamic, dynamic>;
        _recentComplaints = complaintsData.entries.take(10).map((entry) {
          final data = entry.value as Map<dynamic, dynamic>;
          return {
            'id': entry.key,
            'title': data['title'],
            'category': data['category'],
            'status': data['status'],
            'priority': data['priority'],
            'createdAt': data['createdAt'],
          };
        }).toList();
        setState(() {});
      }
    });

    // Patrol officers stream
    _patrolsSubscription = _firebaseService.getActivePatrolsStream().listen((event) {
      if (event.snapshot.value != null) {
        final patrolsData = event.snapshot.value as Map<dynamic, dynamic>;
        _patrolOfficers = patrolsData.entries.map((entry) {
          final data = entry.value as Map<dynamic, dynamic>;
          return {
            'officerId': entry.key,
            'status': data['status'],
            'latitude': data['latitude'],
            'longitude': data['longitude'],
            'startTime': data['startTime'],
            'route': data['route'],
          };
        }).toList();
        setState(() {});
      }
    });
  }

  void _loadRecentComplaints() {
    // This would be handled by the stream
  }

  void _loadActiveSOSAlerts() {
    // This would be handled by the stream
  }

  void _loadPatrolOfficers() {
    // This would be handled by the stream
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HotspotMappingScreen()),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.emergency), text: 'SOS Alerts'),
            Tab(icon: Icon(Icons.assignment), text: 'Complaints'),
            Tab(icon: Icon(Icons.person), text: 'Patrols'),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildSOSAlertsTab(),
          _buildComplaintsTab(),
          _buildPatrolsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
          Row(
            children: [
              Expanded(child: _buildStatCard('Active SOS', _activeSOSAlerts.length.toString(), Colors.red, Icons.emergency)),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard('Pending Complaints', _recentComplaints.where((c) => c['status'] == 'pending').length.toString(), Colors.orange, Icons.assignment)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('Active Patrols', _patrolOfficers.length.toString(), Colors.blue, Icons.person)),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard(
                'Total Incidents',
                (_analytics['categoryPatterns']?.values
                    ?.map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
                    .cast<int>()
                    .fold(0, (sum, count) => sum + count)
                    .toString()) ?? '0',
                Colors.purple,
                Icons.analytics,
              )),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Analytics Chart
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Incident Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: _buildPieChart(),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 24),
          
          // Recent Activity
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRecentActivityList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    final categoryPatterns = _analytics['categoryPatterns'] as Map<String, int>? ?? {};
    
    if (categoryPatterns.isEmpty) {
      return Center(
        child: Text('No data available'),
      );
    }

    return PieChart(
      PieChartData(
        sections: categoryPatterns.entries.map((entry) {
          final color = _getCategoryColor(entry.key);
          return PieChartSectionData(
            value: entry.value.toDouble(),
            title: '${entry.key}\n${entry.value}',
            color: color,
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
        centerSpaceRadius: 40,
        sectionsSpace: 2,
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'crime':
        return Colors.red;
      case 'accident':
        return Colors.orange;
      case 'traffic':
        return Colors.yellow;
      case 'theft':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  Widget _buildRecentActivityList() {
    final activities = <Map<String, dynamic>>[];
    
    // Add SOS alerts
    for (var alert in _activeSOSAlerts.take(3)) {
      activities.add({
        'type': 'sos',
        'title': 'SOS Alert',
        'description': alert['description'] ?? 'Emergency SOS activated',
        'time': alert['createdAt'],
        'color': Colors.red,
        'icon': Icons.emergency,
      });
    }
    
    // Add recent complaints
    for (var complaint in _recentComplaints.take(3)) {
      activities.add({
        'type': 'complaint',
        'title': complaint['title'],
        'description': '${complaint['category']} - ${complaint['status']}',
        'time': complaint['createdAt'],
        'color': Colors.orange,
        'icon': Icons.assignment,
      });
    }
    
    // Sort by time
    activities.sort((a, b) => (b['time'] ?? 0).compareTo(a['time'] ?? 0));
    
    return Column(
      children: activities.take(5).map((activity) => ListTile(
        leading: CircleAvatar(
          backgroundColor: activity['color'],
          child: Icon(activity['icon'], color: Colors.white, size: 16),
        ),
        title: Text(activity['title']),
        subtitle: Text(activity['description']),
        trailing: Text(
          _formatTimestamp(activity['time']),
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      )).toList(),
    );
  }

  Widget _buildSOSAlertsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _activeSOSAlerts.length,
      itemBuilder: (context, index) {
        final alert = _activeSOSAlerts[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.emergency, color: Colors.white),
            ),
            title: Text('SOS Alert #${alert['id']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert['description'] ?? 'Emergency SOS activated'),
                Text('Location: ${alert['latitude']?.toStringAsFixed(6)}, ${alert['longitude']?.toStringAsFixed(6)}'),
                Text('Status: ${alert['status']}'),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'respond',
                  child: Text('Respond'),
                ),
                PopupMenuItem(
                  value: 'assign',
                  child: Text('Assign Officer'),
                ),
                PopupMenuItem(
                  value: 'resolve',
                  child: Text('Mark Resolved'),
                ),
              ],
              onSelected: (value) => _handleSOSAction(alert['id'], value),
            ),
          ),
        );
      },
    );
  }

  Widget _buildComplaintsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _recentComplaints.length,
      itemBuilder: (context, index) {
        final complaint = _recentComplaints[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(complaint['status']),
              child: Icon(Icons.assignment, color: Colors.white),
            ),
            title: Text(complaint['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${complaint['category']}'),
                Text('Priority: ${complaint['priority']}'),
                Text('Status: ${complaint['status']}'),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'view',
                  child: Text('View Details'),
                ),
                PopupMenuItem(
                  value: 'assign',
                  child: Text('Assign Officer'),
                ),
                PopupMenuItem(
                  value: 'update',
                  child: Text('Update Status'),
                ),
              ],
              onSelected: (value) => _handleComplaintAction(complaint['id'], value),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatrolsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _patrolOfficers.length,
      itemBuilder: (context, index) {
        final officer = _patrolOfficers[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('Officer ${officer['officerId']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${officer['status']}'),
                Text('Route: ${officer['route'] ?? 'Not specified'}'),
                Text('Location: ${officer['latitude']?.toStringAsFixed(6)}, ${officer['longitude']?.toStringAsFixed(6)}'),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'track',
                  child: Text('Track Location'),
                ),
                PopupMenuItem(
                  value: 'message',
                  child: Text('Send Message'),
                ),
                PopupMenuItem(
                  value: 'end',
                  child: Text('End Patrol'),
                ),
              ],
              onSelected: (value) => _handlePatrolAction(officer['officerId'], value),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _handleSOSAction(String alertId, String action) {
    switch (action) {
      case 'respond':
        // Navigate to SOS response screen
        break;
      case 'assign':
        _showAssignOfficerDialog(alertId, 'sos');
        break;
      case 'resolve':
        _firebaseService.updateSOSStatus(alertId, 'resolved', 'admin');
        break;
    }
  }

  void _handleComplaintAction(String complaintId, String action) {
    switch (action) {
      case 'view':
        // Navigate to complaint details
        break;
      case 'assign':
        _showAssignOfficerDialog(complaintId, 'complaint');
        break;
      case 'update':
        _showUpdateStatusDialog(complaintId);
        break;
    }
  }

  void _handlePatrolAction(String officerId, String action) {
    switch (action) {
      case 'track':
        // Navigate to patrol tracking screen
        break;
      case 'message':
        // Navigate to chat with officer
        break;
      case 'end':
        _firebaseService.endPatrol(officerId);
        break;
    }
  }

  void _showAssignOfficerDialog(String itemId, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Assign Officer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Officer ID',
                hintText: 'Enter officer ID...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Assign officer logic
              Navigator.of(context).pop();
            },
            child: Text('Assign'),
          ),
        ],
      ),
    );
  }

  void _showUpdateStatusDialog(String complaintId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Status'),
              items: [
                DropdownMenuItem(value: 'pending', child: Text('Pending')),
                DropdownMenuItem(value: 'in_progress', child: Text('In Progress')),
                DropdownMenuItem(value: 'resolved', child: Text('Resolved')),
                DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Update status logic
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
} 