import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_service.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Notification channels
  static const String _sosChannelId = 'sos_alerts';
  static const String _chatChannelId = 'chat_messages';
  static const String _complaintChannelId = 'complaint_updates';
  static const String _announcementChannelId = 'announcements';
  static const String _generalChannelId = 'general';

  // Initialize notification service
  Future<void> initialize() async {
    try {
      // Request permission for iOS
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }

      // Print FCM token for debug
      await printFCMToken();
      // Save FCM token to user profile
      await saveFCMTokenToProfile();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await _saveFCMToken(token);
      }

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((token) {
        _saveFCMToken(token);
      });

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Handle notification taps
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

      // Check for initial notification
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(initialMessage);
      }

    } catch (e) {
      print('Error initializing notification service: $e');
    }
  }

  // Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels for Android
    await _createNotificationChannels();
  }

  // Create notification channels
  Future<void> _createNotificationChannels() async {
    const AndroidNotificationChannel sosChannel = AndroidNotificationChannel(
      _sosChannelId,
      'SOS Alerts',
      description: 'Emergency SOS notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
    );

    const AndroidNotificationChannel chatChannel = AndroidNotificationChannel(
      _chatChannelId,
      'Chat Messages',
      description: 'In-app chat notifications',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    const AndroidNotificationChannel complaintChannel = AndroidNotificationChannel(
      _complaintChannelId,
      'Complaint Updates',
      description: 'Complaint status updates',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    const AndroidNotificationChannel announcementChannel = AndroidNotificationChannel(
      _announcementChannelId,
      'Announcements',
      description: 'Police announcements and alerts',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    const AndroidNotificationChannel generalChannel = AndroidNotificationChannel(
      _generalChannelId,
      'General',
      description: 'General notifications',
      importance: Importance.defaultImportance,
      playSound: true,
      enableVibration: false,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(sosChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(chatChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(complaintChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(announcementChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(generalChannel);
  }

  // Save FCM token to Firebase
  Future<void> _saveFCMToken(String token) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firebaseService.updateUserProfile(user.uid, {
          'fcmToken': token,
          'lastTokenUpdate': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      print('Error saving FCM token: $e');
    }
  }

  // Save the device's FCM token to the user's profile in Firebase
  Future<void> saveFCMTokenToProfile() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        String? token = await _firebaseMessaging.getToken();
        if (token != null) {
          await _firebaseService.updateUserProfile(user.uid, {
            'fcmToken': token,
            'lastTokenUpdate': DateTime.now().toIso8601String(),
          });
          print('FCM token saved to profile: $token');
        }
      }
    } catch (e) {
      print('Error saving FCM token to profile: $e');
    }
  }

  // Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      _showLocalNotification(message);
    }
  }

  // Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    print('Notification tapped: ${message.data}');
    // Handle navigation based on notification type
    _handleNotificationNavigation(message.data);
  }

  // Handle local notification tap
  void _onNotificationTapped(NotificationResponse response) {
    print('Local notification tapped: ${response.payload}');
    if (response.payload != null) {
      final data = Map<String, dynamic>.from(
        response.payload!.split(',').asMap().map((key, value) => MapEntry(key.toString(), value)),
      );
      _handleNotificationNavigation(data);
    }
  }

  // Handle notification navigation
  void _handleNotificationNavigation(Map<String, dynamic> data) {
    final type = data['type'];

    switch (type) {
      case 'sos':
        // Navigate to SOS screen
        break;
      case 'chat':
        // Navigate to chat screen
        break;
      case 'complaint':
        // Navigate to complaint details
        break;
      case 'announcement':
        // Navigate to announcement details
        break;
      default:
        // Navigate to home screen
        break;
    }
  }

  // Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      String channelId = _generalChannelId;
      
      // Determine channel based on notification type
      if (message.data['type'] == 'sos') {
        channelId = _sosChannelId;
      } else if (message.data['type'] == 'chat') {
        channelId = _chatChannelId;
      } else if (message.data['type'] == 'complaint') {
        channelId = _complaintChannelId;
      } else if (message.data['type'] == 'announcement') {
        channelId = _announcementChannelId;
      }

      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            channelId,
            channelDescription: 'Channel description',
            icon: android.smallIcon ?? '@mipmap/ic_launcher',
            color: null, // or use a Color if available
            playSound: true,
            enableVibration: true,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.entries.map((e) => '${e.key}:${e.value}').join(','),
      );
    }
  }

  // Show custom local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    String channelId = _generalChannelId,
    int id = 0,
  }) async {
    await _localNotifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelId,
          channelDescription: 'Channel description',
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  // Show SOS notification
  Future<void> showSOSNotification({
    required String title,
    required String body,
    required String alertId,
  }) async {
    await showLocalNotification(
      title: title,
      body: body,
      payload: 'type:sos,id:$alertId',
      channelId: _sosChannelId,
      id: 1,
    );
  }

  // Show chat notification
  Future<void> showChatNotification({
    required String title,
    required String body,
    required String chatId,
  }) async {
    await showLocalNotification(
      title: title,
      body: body,
      payload: 'type:chat,id:$chatId',
      channelId: _chatChannelId,
      id: 2,
    );
  }

  // Show complaint update notification
  Future<void> showComplaintNotification({
    required String title,
    required String body,
    required String complaintId,
  }) async {
    await showLocalNotification(
      title: title,
      body: body,
      payload: 'type:complaint,id:$complaintId',
      channelId: _complaintChannelId,
      id: 3,
    );
  }

  // Show announcement notification
  Future<void> showAnnouncementNotification({
    required String title,
    required String body,
    required String announcementId,
  }) async {
    await showLocalNotification(
      title: title,
      body: body,
      payload: 'type:announcement,id:$announcementId',
      channelId: _announcementChannelId,
      id: 4,
    );
  }

  // Subscribe to topics
  Future<void> subscribeToTopics() async {
    try {
      await _firebaseMessaging.subscribeToTopic('announcements');
      await _firebaseMessaging.subscribeToTopic('general');
      
      final user = _auth.currentUser;
      if (user != null) {
        await _firebaseMessaging.subscribeToTopic('user_${user.uid}');
      }
    } catch (e) {
      print('Error subscribing to topics: $e');
    }
  }

  // Unsubscribe from topics
  Future<void> unsubscribeFromTopics() async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic('announcements');
      await _firebaseMessaging.unsubscribeFromTopic('general');
      
      final user = _auth.currentUser;
      if (user != null) {
        await _firebaseMessaging.unsubscribeFromTopic('user_${user.uid}');
      }
    } catch (e) {
      print('Error unsubscribing from topics: $e');
    }
  }

  // Get notification settings
  Future<NotificationSettings> getNotificationSettings() async {
    return await _firebaseMessaging.getNotificationSettings();
  }

  // Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final settings = await getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  // Clear all notifications
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  // Clear specific notification
  Future<void> clearNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  // Schedule notification
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    String channelId = _generalChannelId,
    int id = 0,
  }) async {
    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelId,
          channelDescription: 'Channel description',
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  // Cancel scheduled notification
  Future<void> cancelScheduledNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  // Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }

  // Dispose
  void dispose() {
    // Clean up resources if needed
  }

  // Send SOS notification to all police officers
  Future<void> sendSOSToPolice({required double latitude, required double longitude}) async {
    try {
      final usersSnapshot = await _firebaseService.database.ref('users').orderByChild('role').equalTo('police').get();
      if (usersSnapshot.value is Map) {
        final users = (usersSnapshot.value as Map).values;
        for (final user in users) {
          if (user is Map && user['fcmToken'] != null) {
            final fcmToken = user['fcmToken'];
            // Send FCM notification (this requires server key, so in production use a Cloud Function)
            await _sendFCMToToken(
              fcmToken,
              title: 'Emergency SOS Alert',
              body: 'A citizen has triggered an SOS! Tap to view location.',
              data: {
                'type': 'sos',
                'latitude': latitude.toString(),
                'longitude': longitude.toString(),
              },
            );
          }
        }
      }
    } catch (e) {
      print('Error sending SOS to police: $e');
    }
  }

  // Helper to send FCM to a token (placeholder, should use server/cloud function in production)
  Future<void> _sendFCMToToken(String token, {required String title, required String body, Map<String, String>? data}) async {
    // This is a placeholder. In production, use a Cloud Function or your server to send FCM using the server key.
    print('Would send FCM to $token: $title - $body - $data');
    // You can use http package to POST to https://fcm.googleapis.com/fcm/send if you want to test locally (not recommended for production)
  }

  // Print the device's FCM token to the debug console
  Future<void> printFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }
}

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  // Handle background messages here
}
