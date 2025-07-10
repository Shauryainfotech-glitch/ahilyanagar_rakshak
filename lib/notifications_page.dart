import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Emergency Alert',
      message: 'Traffic diversion on Main Road due to VIP movement. Please use alternate route.',
      time: '2 minutes ago',
      type: NotificationType.emergency,
      isRead: false,
    ),
    NotificationItem(
      title: 'Complaint Update',
      message: 'Your complaint #CR2024001 has been registered successfully. Reference number: 2024/001/CR',
      time: '1 hour ago',
      type: NotificationType.complaint,
      isRead: false,
    ),
    NotificationItem(
      title: 'Community Alert',
      message: 'Beware of fake police calls asking for personal information. Always verify caller identity.',
      time: '3 hours ago',
      type: NotificationType.alert,
      isRead: true,
    ),
    NotificationItem(
      title: 'Appointment Reminder',
      message: 'Your appointment with SHO is scheduled for tomorrow at 10:00 AM. Please arrive 10 minutes early.',
      time: '1 day ago',
      type: NotificationType.appointment,
      isRead: true,
    ),
    NotificationItem(
      title: 'Service Update',
      message: 'New feature: You can now track your complaint status in real-time. Check the services section.',
      time: '2 days ago',
      type: NotificationType.update,
      isRead: true,
    ),
    NotificationItem(
      title: 'Safety Tip',
      message: 'Remember to lock your vehicles and never leave valuables in plain sight. Stay vigilant!',
      time: '3 days ago',
      type: NotificationType.tip,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: const Color(0xFF23284A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('All notifications cleared'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFF23284A),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: Colors.white54,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You\'re all caught up!',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(
                  notification: notification,
                  onTap: () {
                    setState(() {
                      notification.isRead = true;
                    });
                    _showNotificationDetails(context, notification);
                  },
                  onDismiss: () {
                    setState(() {
                      notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Notification dismissed'),
                        backgroundColor: Colors.orange,
                        action: SnackBarAction(
                          label: 'Undo',
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              notifications.insert(index, notification);
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  void _showNotificationDetails(BuildContext context, NotificationItem notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2F5A),
          title: Row(
            children: [
              _getNotificationIcon(notification.type),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  notification.title,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.message,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Time: ${notification.time}',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getNotificationIcon(NotificationType type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case NotificationType.emergency:
        iconData = Icons.warning;
        iconColor = Colors.red;
        break;
      case NotificationType.complaint:
        iconData = Icons.report;
        iconColor = Colors.orange;
        break;
      case NotificationType.alert:
        iconData = Icons.security;
        iconColor = Colors.yellow;
        break;
      case NotificationType.appointment:
        iconData = Icons.schedule;
        iconColor = Colors.blue;
        break;
      case NotificationType.update:
        iconData = Icons.system_update;
        iconColor = Colors.green;
        break;
      case NotificationType.tip:
        iconData = Icons.lightbulb;
        iconColor = Colors.purple;
        break;
    }

    return Icon(iconData, color: iconColor, size: 24);
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationCard({
    Key? key,
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.title + notification.time),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: EdgeInsets.only(bottom: 12),
        color: notification.isRead 
            ? const Color(0xFF2A2F5A) 
            : const Color(0xFF3A3F6A),
        elevation: 4,
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: _getNotificationIcon(notification.type),
          title: Text(
            notification.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                notification.message,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                notification.time,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: notification.isRead
              ? null
              : Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _getNotificationIcon(NotificationType type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case NotificationType.emergency:
        iconData = Icons.warning;
        iconColor = Colors.red;
        break;
      case NotificationType.complaint:
        iconData = Icons.report;
        iconColor = Colors.orange;
        break;
      case NotificationType.alert:
        iconData = Icons.security;
        iconColor = Colors.yellow;
        break;
      case NotificationType.appointment:
        iconData = Icons.schedule;
        iconColor = Colors.blue;
        break;
      case NotificationType.update:
        iconData = Icons.system_update;
        iconColor = Colors.green;
        break;
      case NotificationType.tip:
        iconData = Icons.lightbulb;
        iconColor = Colors.purple;
        break;
    }

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

enum NotificationType {
  emergency,
  complaint,
  alert,
  appointment,
  update,
  tip,
} 