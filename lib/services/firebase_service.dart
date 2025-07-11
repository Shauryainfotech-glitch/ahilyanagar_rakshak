import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Database references
  DatabaseReference get _usersRef => _database.ref('users');
  DatabaseReference get _complaintsRef => _database.ref('complaints');
  DatabaseReference get _sosRef => _database.ref('sos_alerts');
  DatabaseReference get _chatsRef => _database.ref('chats');
  DatabaseReference get _firRef => _database.ref('fir');
  DatabaseReference get _challansRef => _database.ref('challans');
  DatabaseReference get _hotspotsRef => _database.ref('hotspots');
  DatabaseReference get _feedbackRef => _database.ref('feedback');
  DatabaseReference get _announcementsRef => _database.ref('announcements');
  DatabaseReference get _patrolsRef => _database.ref('patrols');
  DatabaseReference get _documentsRef => _database.ref('documents');

  // Add public getters for database and storage
  FirebaseDatabase get database => _database;
  FirebaseStorage get storage => _storage;

  // User Management
  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String phone,
    required String email,
    String? address,
    String? emergencyContact,
  }) async {
    await _usersRef.child(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'emergencyContact': emergencyContact,
      'createdAt': ServerValue.timestamp,
      'lastActive': ServerValue.timestamp,
      'language': 'en',
      'notifications': true,
    });
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final snapshot = await _usersRef.child(uid).get();
    final raw = snapshot.value;
    
    if (raw is Map) {
      // Convert all keys to String to handle Firebase's Object? keys
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _usersRef.child(uid).update(data);
  }

  // Real-time Geolocation Tracking
  Future<void> updateUserLocation(String uid, Position position) async {
    await _usersRef.child(uid).child('location').set({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': ServerValue.timestamp,
      'accuracy': position.accuracy,
    });
  }

  Stream<DatabaseEvent> getUserLocationStream(String uid) {
    return _usersRef.child(uid).child('location').onValue;
  }

  // SOS Alerts
  Future<String> createSOSAlert({
    required String userId,
    required Position position,
    String? description,
    List<String>? mediaUrls,
  }) async {
    final alertRef = _sosRef.push();
    final alertId = alertRef.key!;
    
    await alertRef.set({
      'userId': userId,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'description': description,
      'mediaUrls': mediaUrls ?? [],
      'status': 'active',
      'createdAt': ServerValue.timestamp,
      'respondedAt': null,
      'respondedBy': null,
    });

    return alertId;
  }

  Stream<DatabaseEvent> getSOSAlertsStream() {
    return _sosRef.orderByChild('status').equalTo('active').onValue;
  }

  Future<void> updateSOSStatus(String alertId, String status, String? respondedBy) async {
    await _sosRef.child(alertId).update({
      'status': status,
      'respondedAt': ServerValue.timestamp,
      'respondedBy': respondedBy,
    });
  }

  // Complaints with Geo-tagged Media
  Future<String> createComplaint({
    required String userId,
    required String title,
    required String description,
    required String category,
    required Position position,
    List<String>? mediaUrls,
    Map<String, dynamic>? additionalData,
  }) async {
    final complaintRef = _complaintsRef.push();
    final complaintId = complaintRef.key!;

    await complaintRef.set({
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'mediaUrls': mediaUrls ?? [],
      'additionalData': additionalData ?? {},
      'status': 'pending',
      'priority': 'medium',
      'createdAt': ServerValue.timestamp,
      'updatedAt': ServerValue.timestamp,
      'assignedTo': null,
      'comments': [],
    });

    return complaintId;
  }

  Stream<DatabaseEvent> getUserComplaintsStream(String userId) {
    return _complaintsRef.orderByChild('userId').equalTo(userId).onValue;
  }

  Stream<DatabaseEvent> getAllComplaintsStream() {
    return _complaintsRef.orderByChild('createdAt').onValue;
  }

  Future<void> updateComplaintStatus(String complaintId, String status, String? assignedTo) async {
    await _complaintsRef.child(complaintId).update({
      'status': status,
      'assignedTo': assignedTo,
      'updatedAt': ServerValue.timestamp,
    });
  }

  // In-app Chat
  Future<String> createChat({
    required String userId,
    required String policeId,
    required String subject,
  }) async {
    final chatRef = _chatsRef.push();
    final chatId = chatRef.key!;

    await chatRef.set({
      'userId': userId,
      'policeId': policeId,
      'subject': subject,
      'createdAt': ServerValue.timestamp,
      'lastMessage': null,
      'lastMessageTime': null,
      'status': 'active',
    });

    return chatId;
  }

  Future<void> sendMessage(String chatId, String senderId, String message, String senderType) async {
    final messageRef = _chatsRef.child(chatId).child('messages').push();
    await messageRef.set({
      'senderId': senderId,
      'senderType': senderType, // 'user' or 'police'
      'message': message,
      'timestamp': ServerValue.timestamp,
      'read': false,
    });

    // Update last message
    await _chatsRef.child(chatId).update({
      'lastMessage': message,
      'lastMessageTime': ServerValue.timestamp,
    });
  }

  Stream<DatabaseEvent> getChatMessagesStream(String chatId) {
    return _chatsRef.child(chatId).child('messages').orderByChild('timestamp').onValue;
  }

  Stream<DatabaseEvent> getUserChatsStream(String userId) {
    return _chatsRef.orderByChild('userId').equalTo(userId).onValue;
  }

  // FIR Status Tracking
  Future<String> createFIR({
    required String userId,
    required String complaintId,
    required String firNumber,
    required String details,
    String? assignedOfficer,
  }) async {
    final firRef = _firRef.push();
    final firId = firRef.key!;

    await firRef.set({
      'userId': userId,
      'complaintId': complaintId,
      'firNumber': firNumber,
      'details': details,
      'assignedOfficer': assignedOfficer,
      'status': 'registered',
      'createdAt': ServerValue.timestamp,
      'updatedAt': ServerValue.timestamp,
      'progress': [],
    });

    return firId;
  }

  Stream<DatabaseEvent> getFIRStatusStream(String userId) {
    return _firRef.orderByChild('userId').equalTo(userId).onValue;
  }

  Future<void> updateFIRStatus(String firId, String status, String? comment) async {
    final progressRef = _firRef.child(firId).child('progress').push();
    await progressRef.set({
      'status': status,
      'comment': comment,
      'timestamp': ServerValue.timestamp,
    });

    await _firRef.child(firId).update({
      'status': status,
      'updatedAt': ServerValue.timestamp,
    });
  }

  // E-Challan Management
  Future<String> createChallan({
    required String userId,
    required String vehicleNumber,
    required String violation,
    required double amount,
    required Position location,
    String? description,
    List<String>? evidenceUrls,
  }) async {
    final challanRef = _challansRef.push();
    final challanId = challanRef.key!;

    await challanRef.set({
      'userId': userId,
      'vehicleNumber': vehicleNumber,
      'violation': violation,
      'amount': amount,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'description': description,
      'evidenceUrls': evidenceUrls ?? [],
      'status': 'pending',
      'dueDate': ServerValue.timestamp,
      'createdAt': ServerValue.timestamp,
      'paidAt': null,
    });

    return challanId;
  }

  Stream<DatabaseEvent> getUserChallansStream(String userId) {
    return _challansRef.orderByChild('userId').equalTo(userId).onValue;
  }

  Future<void> payChallan(String challanId) async {
    await _challansRef.child(challanId).update({
      'status': 'paid',
      'paidAt': ServerValue.timestamp,
    });
  }

  // Document Upload
  Future<String> uploadDocument({
    required String userId,
    required String documentType,
    required File file,
    String? description,
  }) async {
    final fileName = '${userId}_${documentType}_${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}';
    final storageRef = _storage.ref().child('documents/$fileName');
    
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    final documentRef = _documentsRef.push();
    final documentId = documentRef.key!;

    await documentRef.set({
      'userId': userId,
      'documentType': documentType,
      'fileName': fileName,
      'downloadUrl': downloadUrl,
      'description': description,
      'uploadedAt': ServerValue.timestamp,
      'verified': false,
    });

    return documentId;
  }

  Stream<DatabaseEvent> getUserDocumentsStream(String userId) {
    return _documentsRef.orderByChild('userId').equalTo(userId).onValue;
  }

  // Incident Hotspot Mapping
  Future<void> addHotspot({
    required String type, // 'crime', 'accident', 'traffic'
    required Position position,
    required String description,
    int severity = 1, // 1-5 scale
  }) async {
    final hotspotRef = _hotspotsRef.push();
    await hotspotRef.set({
      'type': type,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'description': description,
      'severity': severity,
      'createdAt': ServerValue.timestamp,
      'active': true,
    });
  }

  Stream<DatabaseEvent> getHotspotsStream() {
    return _hotspotsRef.orderByChild('active').equalTo(true).onValue;
  }

  // Feedback and Ratings
  Future<void> submitFeedback({
    required String userId,
    required String type, // 'service', 'officer', 'station'
    required String targetId, // officer ID, station ID, etc.
    required int rating,
    required String comment,
  }) async {
    final feedbackRef = _feedbackRef.push();
    await feedbackRef.set({
      'userId': userId,
      'type': type,
      'targetId': targetId,
      'rating': rating,
      'comment': comment,
      'createdAt': ServerValue.timestamp,
      'anonymous': false,
    });
  }

  Stream<DatabaseEvent> getFeedbackStream(String targetId) {
    return _feedbackRef.orderByChild('targetId').equalTo(targetId).onValue;
  }

  // Anonymous Tips
  Future<void> submitAnonymousTip({
    required String tip,
    required String category,
    Position? position,
  }) async {
    final tipRef = _feedbackRef.push();
    await tipRef.set({
      'tip': tip,
      'category': category,
      'latitude': position?.latitude,
      'longitude': position?.longitude,
      'anonymous': true,
      'createdAt': ServerValue.timestamp,
    });
  }

  // Push Notifications & Announcements
  Future<void> createAnnouncement({
    required String title,
    required String message,
    required String priority, // 'low', 'medium', 'high', 'urgent'
    List<String>? targetUsers,
    String? imageUrl,
  }) async {
    final announcementRef = _announcementsRef.push();
    await announcementRef.set({
      'title': title,
      'message': message,
      'priority': priority,
      'targetUsers': targetUsers,
      'imageUrl': imageUrl,
      'createdAt': ServerValue.timestamp,
      'expiresAt': null,
    });
  }

  Stream<DatabaseEvent> getAnnouncementsStream() {
    return _announcementsRef.orderByChild('createdAt').onValue;
  }

  // Patrol Tracking
  Future<void> startPatrol({
    required String officerId,
    required Position position,
    String? route,
  }) async {
    await _patrolsRef.child(officerId).set({
      'status': 'active',
      'startTime': ServerValue.timestamp,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'route': route,
      'checkpoints': [],
    });
  }

  Future<void> updatePatrolLocation(String officerId, Position position) async {
    await _patrolsRef.child(officerId).update({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'lastUpdate': ServerValue.timestamp,
    });
  }

  Future<void> endPatrol(String officerId) async {
    await _patrolsRef.child(officerId).update({
      'status': 'completed',
      'endTime': ServerValue.timestamp,
    });
  }

  Stream<DatabaseEvent> getActivePatrolsStream() {
    return _patrolsRef.orderByChild('status').equalTo('active').onValue;
  }

  // AI Pattern Detection (Basic Implementation)
  Future<Map<String, dynamic>> analyzePatterns() async {
    // This is a basic implementation. In a real app, you'd integrate with ML services
    final complaintsSnapshot = await _complaintsRef.get();
    final hotspotsSnapshot = await _hotspotsRef.get();
    
    // Analyze patterns (simplified)
    Map<String, int> categoryCount = {};
    Map<String, int> timePatterns = {};
    
    if (complaintsSnapshot.value != null) {
      final complaints = complaintsSnapshot.value as Map<dynamic, dynamic>;
      complaints.forEach((key, value) {
        final complaint = value as Map<dynamic, dynamic>;
        final category = complaint['category'] as String;
        categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      });
    }

    return {
      'categoryPatterns': categoryCount,
      'timePatterns': timePatterns,
      'hotspots': hotspotsSnapshot.value,
    };
  }

  // File Upload Helper
  Future<String> uploadFile(File file, String folder) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
    final storageRef = _storage.ref().child('$folder/$fileName');
    
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // Batch Operations
  Future<void> batchUpdate(Map<String, Map<String, dynamic>> updates) async {
    await _database.ref().update(updates);
  }

  // Delete Operations
  Future<void> deleteRecord(String path) async {
    await _database.ref(path).remove();
  }

  Future<void> deleteFile(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}
