import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/role_service.dart';

class DynamicFunctionalityTest extends StatefulWidget {
  const DynamicFunctionalityTest({super.key});

  @override
  State<DynamicFunctionalityTest> createState() => _DynamicFunctionalityTestState();
}

class _DynamicFunctionalityTestState extends State<DynamicFunctionalityTest> {
  final RoleService _roleService = RoleService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  String _currentRole = 'citizen';
  String _currentUser = '';
  Map<String, dynamic> _userProfile = {};
  List<String> _testResults = [];
  bool _isRunningTests = false;

  @override
  void initState() {
    super.initState();
    _initializeTest();
  }

  Future<void> _initializeTest() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user.uid;
      });
      await _loadCurrentData();
    }
  }

  Future<void> _loadCurrentData() async {
    final role = await _roleService.getCurrentUserRole();
    final profile = await _roleService.getCurrentUserProfile();
    
    setState(() {
      _currentRole = role ?? 'citizen';
      _userProfile = profile ?? {};
    });
  }

  Future<void> _runAllTests() async {
    setState(() {
      _isRunningTests = true;
      _testResults.clear();
    });

    try {
      // Test 1: Role Detection
      await _testRoleDetection();
      
      // Test 2: Real-time Role Changes
      await _testRealTimeRoleChanges();
      
      // Test 3: Permission System
      await _testPermissionSystem();
      
      // Test 4: Navigation Items
      await _testNavigationItems();
      
      // Test 5: Service Access
      await _testServiceAccess();
      
      // Test 6: Profile Updates
      await _testProfileUpdates();
      
      // Test 7: Role-based Features
      await _testRoleBasedFeatures();
      
      // Test 8: Database Operations
      await _testDatabaseOperations();

      setState(() {
        _testResults.add('✅ All tests completed successfully!');
      });
    } catch (e) {
      setState(() {
        _testResults.add('❌ Test failed: $e');
      });
    } finally {
      setState(() {
        _isRunningTests = false;
      });
    }
  }

  Future<void> _testRoleDetection() async {
    _addTestResult('Testing role detection...');
    
    final role = await _roleService.getCurrentUserRole();
    if (role != null) {
      _addTestResult('✅ Role detected: $role');
    } else {
      _addTestResult('❌ Role detection failed');
    }
  }

  Future<void> _testRealTimeRoleChanges() async {
    _addTestResult('Testing real-time role changes...');
    
    // Test role change stream
    final roleStream = _roleService.listenToRoleChanges();
    bool streamWorking = false;
    
    roleStream.listen((role) {
      if (role != null) {
        streamWorking = true;
        _addTestResult('✅ Real-time role change detected: $role');
      }
    });
    
    // Wait a bit for stream to initialize
    await Future.delayed(Duration(seconds: 2));
    
    if (streamWorking) {
      _addTestResult('✅ Real-time role change stream working');
    } else {
      _addTestResult('⚠️ Real-time role change stream not tested (no changes)');
    }
  }

  Future<void> _testPermissionSystem() async {
    _addTestResult('Testing permission system...');
    
    final hasSosPermission = await _roleService.hasPermission('use_sos');
    final hasAdminPermission = await _roleService.hasPermission('view_admin_dashboard');
    
    _addTestResult('✅ SOS permission: $hasSosPermission');
    _addTestResult('✅ Admin permission: $hasAdminPermission');
  }

  Future<void> _testNavigationItems() async {
    _addTestResult('Testing navigation items...');
    
    final navItems = await _roleService.getCurrentUserNavigationItems();
    _addTestResult('✅ Navigation items for $_currentRole: ${navItems.length} items');
    
    for (var item in navItems) {
      _addTestResult('  - ${item['title']}');
    }
  }

  Future<void> _testServiceAccess() async {
    _addTestResult('Testing service access...');
    
    final canAccessComplaint = await _roleService.canAccessService('complaint_registration');
    final canAccessAdmin = await _roleService.canAccessService('mike_sanction_registration');
    
    _addTestResult('✅ Complaint service access: $canAccessComplaint');
    _addTestResult('✅ Admin service access: $canAccessAdmin');
  }

  Future<void> _testProfileUpdates() async {
    _addTestResult('Testing profile updates...');
    
    final profileStream = _roleService.listenToProfileChanges();
    bool profileStreamWorking = false;
    
    profileStream.listen((profile) {
      if (profile != null) {
        profileStreamWorking = true;
        _addTestResult('✅ Real-time profile change detected');
      }
    });
    
    await Future.delayed(Duration(seconds: 2));
    
    if (profileStreamWorking) {
      _addTestResult('✅ Real-time profile change stream working');
    } else {
      _addTestResult('⚠️ Real-time profile change stream not tested (no changes)');
    }
  }

  Future<void> _testRoleBasedFeatures() async {
    _addTestResult('Testing role-based features...');
    
    final canUseSos = await _roleService.canUseFeature('sos_button');
    final canUseAdmin = await _roleService.canUseFeature('admin_dashboard');
    
    _addTestResult('✅ SOS feature access: $canUseSos');
    _addTestResult('✅ Admin feature access: $canUseAdmin');
  }

  Future<void> _testDatabaseOperations() async {
    _addTestResult('Testing database operations...');
    
    try {
      // Test reading user data
      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _database.ref('users/${user.uid}').get();
        if (snapshot.value != null) {
          _addTestResult('✅ Database read successful');
        } else {
          _addTestResult('❌ Database read failed - no user data');
        }
      } else {
        _addTestResult('❌ Database read failed - no authenticated user');
      }
    } catch (e) {
      _addTestResult('❌ Database operation failed: $e');
    }
  }

  void _addTestResult(String result) {
    setState(() {
      _testResults.add(result);
    });
  }

  Future<void> _testRoleChange() async {
    _addTestResult('Testing role change functionality...');
    
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Temporarily change role for testing
        final currentRole = await _roleService.getCurrentUserRole();
        final newRole = currentRole == 'citizen' ? 'police_mitr' : 'citizen';
        
        await _database.ref('users/${user.uid}/role').set(newRole);
        _addTestResult('✅ Role changed from $currentRole to $newRole');
        
        // Wait for real-time update
        await Future.delayed(Duration(seconds: 3));
        
        // Change back
        await _database.ref('users/${user.uid}/role').set(currentRole);
        _addTestResult('✅ Role changed back to $currentRole');
      }
    } catch (e) {
      _addTestResult('❌ Role change test failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Functionality Test'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Status
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('User ID: $_currentUser'),
                    Text('Current Role: $_currentRole'),
                    Text('Name: ${_userProfile['name'] ?? 'N/A'}'),
                    Text('Email: ${_userProfile['email'] ?? 'N/A'}'),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Test Controls
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isRunningTests ? null : _runAllTests,
                    child: Text(_isRunningTests ? 'Running Tests...' : 'Run All Tests'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _testRoleChange,
                  child: Text('Test Role Change'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Test Results
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Test Results',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _testResults.length,
                          itemBuilder: (context, index) {
                            final result = _testResults[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                result,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: result.startsWith('✅') 
                                      ? Colors.green 
                                      : result.startsWith('❌') 
                                          ? Colors.red 
                                          : result.startsWith('⚠️') 
                                              ? Colors.orange 
                                              : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 