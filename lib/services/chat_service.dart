import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'firebase_service.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Chat streams
  StreamSubscription<DatabaseEvent>? _chatSubscription;
  StreamSubscription<DatabaseEvent>? _messageSubscription;

  // Create a new chat
  Future<String> createChat({
    required String userId,
    required String policeId,
    required String subject,
    String? initialMessage,
  }) async {
    try {
      final chatId = await _firebaseService.createChat(
        userId: userId,
        policeId: policeId,
        subject: subject,
      );

      // Send initial message if provided
      if (initialMessage != null && initialMessage.isNotEmpty) {
        await sendMessage(
          chatId: chatId,
          senderId: userId,
          message: initialMessage,
          senderType: 'user',
        );
      }

      return chatId;
    } catch (e) {
      print('Error creating chat: $e');
      rethrow;
    }
  }

  // Send text message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String message,
    required String senderType, // 'user' or 'police'
  }) async {
    try {
      await _firebaseService.sendMessage(
        chatId,
        senderId,
        message,
        senderType,
      );
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }

  // Send media message
  Future<void> sendMediaMessage({
    required String chatId,
    required String senderId,
    required File mediaFile,
    required String mediaType, // 'image', 'video', 'document'
    required String senderType,
    String? caption,
  }) async {
    try {
      // Upload media to Firebase Storage
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${mediaFile.path.split('/').last}';
      final storageRef = _storage.ref().child('chat_media/$chatId/$fileName');
      
      final uploadTask = storageRef.putFile(mediaFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Send message with media URL
      final messageRef = _database.ref('chats/$chatId/messages').push();
      await messageRef.set({
        'senderId': senderId,
        'senderType': senderType,
        'message': caption ?? '',
        'mediaUrl': downloadUrl,
        'mediaType': mediaType,
        'fileName': fileName,
        'timestamp': ServerValue.timestamp,
        'read': false,
      });

      // Update last message
      await _database.ref('chats/$chatId').update({
        'lastMessage': caption ?? 'Media message',
        'lastMessageTime': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error sending media message: $e');
      rethrow;
    }
  }

  // Get chat messages stream
  Stream<DatabaseEvent> getChatMessagesStream(String chatId) {
    return _firebaseService.getChatMessagesStream(chatId);
  }

  // Get user chats stream
  Stream<DatabaseEvent> getUserChatsStream(String userId) {
    return _firebaseService.getUserChatsStream(userId);
  }

  // Get police officer chats stream
  Stream<DatabaseEvent> getPoliceChatsStream(String policeId) {
    return _database.ref('chats').orderByChild('policeId').equalTo(policeId).onValue;
  }

  // Mark message as read
  Future<void> markMessageAsRead(String chatId, String messageId) async {
    try {
      await _database.ref('chats/$chatId/messages/$messageId').update({
        'read': true,
        'readAt': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error marking message as read: $e');
    }
  }

  // Mark all messages in chat as read
  Future<void> markAllMessagesAsRead(String chatId, String userId) async {
    try {
      final messagesSnapshot = await _database.ref('chats/$chatId/messages').get();
      if (messagesSnapshot.value != null) {
        final messages = messagesSnapshot.value as Map<dynamic, dynamic>;
        
        for (var entry in messages.entries) {
          final message = entry.value as Map<dynamic, dynamic>;
          if (message['senderId'] != userId && message['read'] == false) {
            await _database.ref('chats/$chatId/messages/${entry.key}').update({
              'read': true,
              'readAt': ServerValue.timestamp,
            });
          }
        }
      }
    } catch (e) {
      print('Error marking all messages as read: $e');
    }
  }

  // Get unread message count
  Stream<int> getUnreadMessageCount(String userId) {
    return _database.ref('chats').orderByChild('userId').equalTo(userId).onValue.map((event) {
      int count = 0;
      if (event.snapshot.value != null) {
        final chats = event.snapshot.value as Map<dynamic, dynamic>;
        for (var chat in chats.values) {
          final chatData = chat as Map<dynamic, dynamic>;
          if (chatData['lastMessage'] != null && 
              chatData['lastMessageTime'] != null &&
              chatData['lastSenderId'] != userId) {
            count++;
          }
        }
      }
      return count;
    });
  }

  // Update chat status
  Future<void> updateChatStatus(String chatId, String status) async {
    try {
      await _database.ref('chats/$chatId').update({
        'status': status,
        'updatedAt': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error updating chat status: $e');
    }
  }

  // Add chat participant
  Future<void> addChatParticipant(String chatId, String participantId, String role) async {
    try {
      await _database.ref('chats/$chatId/participants/$participantId').set({
        'role': role, // 'user', 'police', 'admin'
        'joinedAt': ServerValue.timestamp,
        'active': true,
      });
    } catch (e) {
      print('Error adding chat participant: $e');
    }
  }

  // Remove chat participant
  Future<void> removeChatParticipant(String chatId, String participantId) async {
    try {
      await _database.ref('chats/$chatId/participants/$participantId').remove();
    } catch (e) {
      print('Error removing chat participant: $e');
    }
  }

  // Get chat participants
  Stream<DatabaseEvent> getChatParticipantsStream(String chatId) {
    return _database.ref('chats/$chatId/participants').onValue;
  }

  // Send typing indicator
  Future<void> sendTypingIndicator(String chatId, String userId, bool isTyping) async {
    try {
      await _database.ref('chats/$chatId/typing/$userId').set({
        'isTyping': isTyping,
        'timestamp': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error sending typing indicator: $e');
    }
  }

  // Get typing indicators stream
  Stream<DatabaseEvent> getTypingIndicatorsStream(String chatId) {
    return _database.ref('chats/$chatId/typing').onValue;
  }

  // Delete message
  Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      final messageSnapshot = await _database.ref('chats/$chatId/messages/$messageId').get();
      if (messageSnapshot.value != null) {
        final message = messageSnapshot.value as Map<dynamic, dynamic>;
        
        // Delete media file if exists
        if (message['mediaUrl'] != null) {
          try {
            final ref = _storage.refFromURL(message['mediaUrl']);
            await ref.delete();
          } catch (e) {
            print('Error deleting media file: $e');
          }
        }
        
        // Delete message
        await _database.ref('chats/$chatId/messages/$messageId').remove();
      }
    } catch (e) {
      print('Error deleting message: $e');
    }
  }

  // Search messages
  Stream<DatabaseEvent> searchMessages(String chatId, String query) {
    return _database.ref('chats/$chatId/messages')
        .orderByChild('message')
        .startAt(query)
        .endAt(query + '\uf8ff')
        .onValue;
  }

  // Get chat statistics
  Future<Map<String, dynamic>> getChatStatistics(String chatId) async {
    try {
      final messagesSnapshot = await _database.ref('chats/$chatId/messages').get();
      final participantsSnapshot = await _database.ref('chats/$chatId/participants').get();
      
      int totalMessages = 0;
      int unreadMessages = 0;
      int participants = 0;
      
      if (messagesSnapshot.value != null) {
        final messages = messagesSnapshot.value as Map<dynamic, dynamic>;
        totalMessages = messages.length;
        unreadMessages = messages.values.where((msg) => msg['read'] == false).length;
      }
      
      if (participantsSnapshot.value != null) {
        final participantsData = participantsSnapshot.value as Map<dynamic, dynamic>;
        participants = participantsData.length;
      }
      
      return {
        'totalMessages': totalMessages,
        'unreadMessages': unreadMessages,
        'participants': participants,
      };
    } catch (e) {
      print('Error getting chat statistics: $e');
      return {
        'totalMessages': 0,
        'unreadMessages': 0,
        'participants': 0,
      };
    }
  }

  // Archive chat
  Future<void> archiveChat(String chatId, String userId) async {
    try {
      await _database.ref('chats/$chatId/archived/$userId').set({
        'archivedAt': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error archiving chat: $e');
    }
  }

  // Unarchive chat
  Future<void> unarchiveChat(String chatId, String userId) async {
    try {
      await _database.ref('chats/$chatId/archived/$userId').remove();
    } catch (e) {
      print('Error unarchiving chat: $e');
    }
  }

  // Get archived chats
  Stream<DatabaseEvent> getArchivedChatsStream(String userId) {
    return _database.ref('chats')
        .orderByChild('userId')
        .equalTo(userId)
        .onValue
        .map((event) {
          // Filter archived chats
          if (event.snapshot.value != null) {
            final chats = event.snapshot.value as Map<dynamic, dynamic>;
            final archivedChats = <String, dynamic>{};
            
            for (var entry in chats.entries) {
              final chat = entry.value as Map<dynamic, dynamic>;
              if (chat['archived'] != null && 
                  chat['archived'][userId] != null) {
                archivedChats[entry.key] = chat;
              }
            }
            // Return the filtered archivedChats map directly
          }
          return event;
        });
  }

  // Block user
  Future<void> blockUser(String chatId, String blockedUserId, String blockedBy) async {
    try {
      await _database.ref('chats/$chatId/blocked/$blockedUserId').set({
        'blockedBy': blockedBy,
        'blockedAt': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error blocking user: $e');
    }
  }

  // Unblock user
  Future<void> unblockUser(String chatId, String blockedUserId) async {
    try {
      await _database.ref('chats/$chatId/blocked/$blockedUserId').remove();
    } catch (e) {
      print('Error unblocking user: $e');
    }
  }

  // Check if user is blocked
  Future<bool> isUserBlocked(String chatId, String userId) async {
    try {
      final snapshot = await _database.ref('chats/$chatId/blocked/$userId').get();
      return snapshot.value != null;
    } catch (e) {
      print('Error checking if user is blocked: $e');
      return false;
    }
  }

  // Dispose resources
  void dispose() {
    _chatSubscription?.cancel();
    _messageSubscription?.cancel();
  }
}