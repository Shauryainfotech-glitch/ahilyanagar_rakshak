import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_service.dart';

class RoleService {
  static final RoleService _instance = RoleService._internal();
  factory RoleService() => _instance;
  RoleService._internal();

  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Role definitions
  static const String ROLE_CITIZEN = 'citizen';
  static const String ROLE_POLICE = 'police';
  static const String ROLE_POLICE_MITR = 'police_mitr';

  // Role display names
  static const Map<String, String> ROLE_DISPLAY_NAMES = {
    ROLE_CITIZEN: 'Citizen',
    ROLE_POLICE: 'Police Officer',
    ROLE_POLICE_MITR: 'Police Mitr',
  };

  // Role icons
  static const Map<String, String> ROLE_ICONS = {
    ROLE_CITIZEN: '👤',
    ROLE_POLICE: '👮',
    ROLE_POLICE_MITR: '👥',
  };

  // Get current user's role with real-time updates
  Future<String?> getCurrentUserRole() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final snapshot = await _database.ref('users/${user.uid}/role').get();
      return snapshot.value as String?;
    } catch (e) {
      print('Error getting user role: $e');
      return null;
    }
  }

  // Stream for real-time role changes
  Stream<String?> getCurrentUserRoleStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(null);

    return _database.ref('users/${user.uid}/role').onValue.map((event) {
      return event.snapshot.value as String?;
    });
  }

  // Get current user's full profile with real-time updates
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final snapshot = await _database.ref('users/${user.uid}').get();
      final raw = snapshot.value;
      
      if (raw is Map) {
        // Convert all keys to String to handle Firebase's Object? keys
        return raw.map((key, value) => MapEntry(key.toString(), value));
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Stream for real-time profile changes
  Stream<Map<String, dynamic>?> getCurrentUserProfileStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(null);

    return _database.ref('users/${user.uid}').onValue.map((event) {
      final raw = event.snapshot.value;
      if (raw is Map) {
        return raw.map((key, value) => MapEntry(key.toString(), value));
      }
      return null;
    });
  }

  // Check if user has specific role
  Future<bool> hasRole(String role) async {
    final userRole = await getCurrentUserRole();
    return userRole == role;
  }

  // Check if user is police (police or police_mitr)
  Future<bool> isPolice() async {
    final userRole = await getCurrentUserRole();
    return userRole == ROLE_POLICE || userRole == ROLE_POLICE_MITR;
  }

  // Check if user is police officer (only police, not mitr)
  Future<bool> isPoliceOfficer() async {
    final userRole = await getCurrentUserRole();
    return userRole == ROLE_POLICE;
  }

  // Check if user is police mitr
  Future<bool> isPoliceMitr() async {
    final userRole = await getCurrentUserRole();
    return userRole == ROLE_POLICE_MITR;
  }

  // Check if user is citizen
  Future<bool> isCitizen() async {
    final userRole = await getCurrentUserRole();
    return userRole == ROLE_CITIZEN;
  }

  // Get role-based permissions
  Map<String, List<String>> getRolePermissions() {
    return {
      ROLE_CITIZEN: [
        'view_services',
        'submit_complaints',
        'track_complaints',
        'use_sos',
        'view_announcements',
        'submit_feedback',
        'chat_with_police',
        'view_hotspots',
        'submit_anonymous_tips',
      ],
      ROLE_POLICE: [
        'view_services',
        'view_all_complaints',
        'manage_complaints',
        'respond_to_sos',
        'view_admin_dashboard',
        'manage_patrols',
        'view_analytics',
        'manage_hotspots',
        'send_announcements',
        'chat_with_citizens',
        'manage_users',
        'view_reports',
        'manage_challans',
        'view_fir_status',
      ],
      ROLE_POLICE_MITR: [
        'view_services',
        'view_assigned_complaints',
        'respond_to_sos',
        'view_limited_dashboard',
        'participate_in_patrols',
        'view_basic_analytics',
        'report_hotspots',
        'chat_with_citizens',
        'view_assigned_reports',
        'assist_with_challans',
      ],
    };
  }

  // Check if user has specific permission
  Future<bool> hasPermission(String permission) async {
    final userRole = await getCurrentUserRole();
    if (userRole == null) return false;

    final permissions = getRolePermissions()[userRole] ?? [];
    return permissions.contains(permission);
  }

  // Get role-based navigation items
  List<Map<String, dynamic>> getRoleBasedNavigationItems() {
    return [
      {
        'title': 'Home',
        'icon': 'home',
        'route': '/home',
        'roles': [ROLE_CITIZEN, ROLE_POLICE, ROLE_POLICE_MITR],
      },
      {
        'title': 'Services',
        'icon': 'services',
        'route': '/services',
        'roles': [ROLE_CITIZEN, ROLE_POLICE, ROLE_POLICE_MITR],
      },
      {
        'title': 'Admin Dashboard',
        'icon': 'dashboard',
        'route': '/admin_dashboard',
        'roles': [ROLE_POLICE, ROLE_POLICE_MITR],
      },
      {
        'title': 'Hotspot Mapping',
        'icon': 'map',
        'route': '/hotspot_mapping',
        'roles': [ROLE_CITIZEN, ROLE_POLICE, ROLE_POLICE_MITR],
      },
      {
        'title': 'Patrol Management',
        'icon': 'patrol',
        'route': '/patrol_management',
        'roles': [ROLE_POLICE, ROLE_POLICE_MITR],
      },
      {
        'title': 'Complaint Management',
        'icon': 'complaints',
        'route': '/complaint_management',
        'roles': [ROLE_POLICE, ROLE_POLICE_MITR],
      },
      {
        'title': 'Analytics',
        'icon': 'analytics',
        'route': '/analytics',
        'roles': [ROLE_POLICE],
      },
      {
        'title': 'User Management',
        'icon': 'users',
        'route': '/user_management',
        'roles': [ROLE_POLICE],
      },
    ];
  }

  // Get navigation items for current user
  Future<List<Map<String, dynamic>>> getCurrentUserNavigationItems() async {
    final userRole = await getCurrentUserRole();
    if (userRole == null) return [];

    final allItems = getRoleBasedNavigationItems();
    return allItems.where((item) {
      final roles = item['roles'] as List<String>;
      return roles.contains(userRole);
    }).toList();
  }

  // Get role-based service access
  Map<String, List<String>> getRoleBasedServices() {
    return {
      ROLE_CITIZEN: [
        'complaint_registration',
        'fir_download',
        'accident_gd',
        'lost_property',
        'feedback',
        'blood_donor',
        'blood_request',
        'track_my_trip',
        'senior_citizen_info',
        'single_women_living_alone',
        'report_abduction',
        'report_cyber_fraud',
        'share_information',
        'appointment_with_sho',
        'search_police_station',
        'cyber_security_info',
        'tourist_guide',
        'user_manual',
        'awareness_classes',
        'rate_police_station',
        'rate_application',
        'social_media_of_police',
        'maharashtra_government',
        'ahilyanagar_police',
        'cyber_done',
      ],
      ROLE_POLICE: [
        'complaint_registration',
        'fir_download',
        'accident_gd',
        'lost_property',
        'feedback',
        'blood_donor',
        'blood_request',
        'track_my_trip',
        'senior_citizen_info',
        'single_women_living_alone',
        'report_abduction',
        'report_cyber_fraud',
        'share_information',
        'appointment_with_sho',
        'search_police_station',
        'cyber_security_info',
        'tourist_guide',
        'user_manual',
        'awareness_classes',
        'rate_police_station',
        'rate_application',
        'social_media_of_police',
        'maharashtra_government',
        'ahilyanagar_police',
        'cyber_done',
        'mike_sanction_registration',
        'payment_history',
        'event_performance',
        'grievance_redressal',
        'arrest_search',
        'locked_house_info',
      ],
      ROLE_POLICE_MITR: [
        'complaint_registration',
        'fir_download',
        'accident_gd',
        'lost_property',
        'feedback',
        'blood_donor',
        'blood_request',
        'track_my_trip',
        'senior_citizen_info',
        'single_women_living_alone',
        'report_abduction',
        'report_cyber_fraud',
        'share_information',
        'appointment_with_sho',
        'search_police_station',
        'cyber_security_info',
        'tourist_guide',
        'user_manual',
        'awareness_classes',
        'rate_police_station',
        'rate_application',
        'social_media_of_police',
        'maharashtra_government',
        'ahilyanagar_police',
        'cyber_done',
      ],
    };
  }

  // Check if user can access specific service
  Future<bool> canAccessService(String serviceName) async {
    final userRole = await getCurrentUserRole();
    if (userRole == null) return false;

    final services = getRoleBasedServices()[userRole] ?? [];
    return services.contains(serviceName);
  }

  // Get role-based features
  Map<String, List<String>> getRoleBasedFeatures() {
    return {
      ROLE_CITIZEN: [
        'sos_button',
        'chat_with_police',
        'anonymous_tips',
        'feedback_submission',
        'complaint_tracking',
        'push_notifications',
        'location_sharing',
        'media_upload',
      ],
      ROLE_POLICE: [
        'sos_response',
        'admin_dashboard',
        'patrol_management',
        'complaint_management',
        'analytics_view',
        'user_management',
        'announcement_sending',
        'hotspot_management',
        'challan_management',
        'fir_management',
        'report_generation',
        'real_time_monitoring',
      ],
      ROLE_POLICE_MITR: [
        'sos_response',
        'limited_dashboard',
        'patrol_participation',
        'complaint_assistance',
        'basic_analytics',
        'hotspot_reporting',
        'chat_with_citizens',
        'assistance_tasks',
      ],
    };
  }

  // Check if user can use specific feature
  Future<bool> canUseFeature(String featureName) async {
    final userRole = await getCurrentUserRole();
    if (userRole == null) return false;

    final features = getRoleBasedFeatures()[userRole] ?? [];
    return features.contains(featureName);
  }

  // Update user role (admin only)
  Future<bool> updateUserRole(String userId, String newRole) async {
    try {
      final currentUserRole = await getCurrentUserRole();
      if (currentUserRole != ROLE_POLICE) {
        throw Exception('Only police officers can update user roles');
      }

      await _database.ref('users/$userId/role').set(newRole);
      await _database.ref('users/$userId/updatedAt').set(ServerValue.timestamp);
      await _database.ref('users/$userId/updatedBy').set(_auth.currentUser?.uid);

      return true;
    } catch (e) {
      print('Error updating user role: $e');
      return false;
    }
  }

  // Get all users by role
  Future<List<Map<String, dynamic>>> getUsersByRole(String role) async {
    try {
      final currentUserRole = await getCurrentUserRole();
      if (currentUserRole != ROLE_POLICE) {
        throw Exception('Only police officers can view user lists');
      }

      final snapshot = await _database.ref('users').orderByChild('role').equalTo(role).get();
      if (snapshot.value == null) return [];

      final usersData = snapshot.value as Map<dynamic, dynamic>;
      return usersData.entries.map((entry) {
        final userData = entry.value as Map<dynamic, dynamic>;
        return {
          'uid': entry.key,
          ...userData.map((key, value) => MapEntry(key.toString(), value)),
        };
      }).toList();
    } catch (e) {
      print('Error getting users by role: $e');
      return [];
    }
  }

  // Get role statistics
  Future<Map<String, int>> getRoleStatistics() async {
    try {
      final currentUserRole = await getCurrentUserRole();
      if (currentUserRole != ROLE_POLICE) {
        throw Exception('Only police officers can view role statistics');
      }

      final snapshot = await _database.ref('users').get();
      if (snapshot.value == null) return {};

      final usersData = snapshot.value as Map<dynamic, dynamic>;
      Map<String, int> roleCounts = {};

      for (var user in usersData.values) {
        final userData = user as Map<dynamic, dynamic>;
        final role = userData['role'] as String? ?? 'unknown';
        roleCounts[role] = (roleCounts[role] ?? 0) + 1;
      }

      return roleCounts;
    } catch (e) {
      print('Error getting role statistics: $e');
      return {};
    }
  }

  // Validate role transition
  bool isValidRoleTransition(String fromRole, String toRole) {
    // Only police officers can change roles
    if (fromRole == ROLE_POLICE) {
      return true; // Police can change to any role
    }
    
    // Citizens can only be upgraded by police
    if (fromRole == ROLE_CITIZEN) {
      return toRole == ROLE_POLICE_MITR || toRole == ROLE_POLICE;
    }
    
    // Police Mitr can be upgraded to Police
    if (fromRole == ROLE_POLICE_MITR) {
      return toRole == ROLE_POLICE;
    }
    
    return false;
  }

  // Get role hierarchy
  Map<String, int> getRoleHierarchy() {
    return {
      ROLE_CITIZEN: 1,
      ROLE_POLICE_MITR: 2,
      ROLE_POLICE: 3,
    };
  }

  // Check if user can manage another user
  Future<bool> canManageUser(String targetUserId) async {
    try {
      final currentUserRole = await getCurrentUserRole();
      if (currentUserRole != ROLE_POLICE) return false;

      final targetUserSnapshot = await _database.ref('users/$targetUserId/role').get();
      final targetUserRole = targetUserSnapshot.value as String?;

      if (targetUserRole == null) return false;

      final hierarchy = getRoleHierarchy();
      final currentLevel = hierarchy[currentUserRole] ?? 0;
      final targetLevel = hierarchy[targetUserRole] ?? 0;

      return currentLevel > targetLevel;
    } catch (e) {
      print('Error checking user management permission: $e');
      return false;
    }
  }

  // Listen to role changes in real-time
  Stream<String?> listenToRoleChanges() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(null);

    return _database.ref('users/${user.uid}/role').onValue.map((event) {
      return event.snapshot.value as String?;
    });
  }

  // Listen to profile changes in real-time
  Stream<Map<String, dynamic>?> listenToProfileChanges() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(null);

    return _database.ref('users/${user.uid}').onValue.map((event) {
      final raw = event.snapshot.value;
      if (raw is Map) {
        return raw.map((key, value) => MapEntry(key.toString(), value));
      }
      return null;
    });
  }
} 