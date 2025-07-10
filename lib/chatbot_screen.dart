import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;
  bool isListening = false;
  String animatedText = '';
  Timer? _typingTimer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Enhanced FAQ responses with more comprehensive coverage
  final Map<String, String> faqResponses = {
    // Emergency related
    'emergency': '🚨 For immediate emergencies, please call 100 for police, 101 for fire, or 108 for ambulance. You can also use the SOS button in the app for quick emergency access.',
    'fire': '🔥 In case of fire: 1) Call 101 immediately 2) Evacuate the area 3) Don\'t use elevators 4) Stay low if there\'s smoke 5) Meet at designated assembly point',
    'accident': '🚗 For accidents: 1) Call 100 for police and 108 for ambulance 2) Don\'t move injured persons unless necessary 3) Take photos of the scene 4) Exchange contact details with witnesses',
    'missing person': '👤 To report a missing person: 1) Visit nearest police station 2) Bring recent photo and personal details 3) File a missing person report 4) Provide last known location and time',
    'theft': '🦹 For theft: 1) Call 100 immediately 2) Don\'t touch anything at the scene 3) Make a list of stolen items 4) File FIR at police station 5) Keep copies of all documents',
    
    // Report filing
    'file complaint': '📝 To file a complaint: 1) Use the "File Complaint" button below 2) Fill out the required form 3) Submit with supporting documents 4) Get complaint number for tracking',
    'fir': '📋 For FIR (First Information Report): 1) Visit police station in person 2) Provide detailed incident description 3) Bring identity proof 4) Get FIR copy with number 5) Use this number for tracking',
    'cyber crime': '💻 For cyber crimes: 1) Call 1930 (Cyber Crime Helpline) 2) Visit cybercrime.gov.in 3) File online complaint 4) Save evidence (screenshots, emails) 5) Don\'t delete any digital evidence',
    
    // General information
    'police verification': '📋 For police verification: 1) Submit application at police station 2) Required documents: ID proof, address proof, passport size photos 3) Processing time: 7-15 days 4) Fee: ₹500-1000',
    'fir copy': '📄 To get FIR copy: 1) Visit police station with FIR number 2) Submit written application 3) Pay nominal fee (₹10-50) 4) Get copy within 24 hours 5) Can also download from state police website',
    'passport verification': '🛂 For passport verification: 1) Apply online at passport.gov.in 2) Submit required documents 3) Police verification will be initiated 4) Processing time: 15-30 days 5) Track status online',
    
    // Incident tracking
    'track complaint': '📊 To track your complaint: 1) Use the "Track Complaint" button below 2) Enter your complaint number 3) View current status 4) Get updates on progress',
    'complaint status': '📈 To check complaint status: 1) Visit police station with complaint number 2) Call helpline numbers 3) Use online tracking portal 4) Contact investigating officer',
    
    // General greetings
    'hello': '👋 Hello! I\'m your Police Assistant. How can I help you today? You can ask about emergencies, filing complaints, or general police services.',
    'hi': '👋 Hi there! I\'m here to assist you with police-related queries. What would you like to know?',
    'help': '🆘 I can help you with: 1) Emergency assistance 2) Filing complaints 3) General information 4) Tracking complaints 5) Police services. What do you need?',
    'services': '🛡️ We offer services like: 1) Complaint filing 2) FIR registration 3) Police verification 4) Lost & found 5) Emergency response 6) Traffic management 7) Cyber crime reporting',
  };

  // Quick action buttons data - will be initialized in build method
  List<Map<String, dynamic>> get quickActions => [
    {
      'icon': Icons.emergency_rounded,
      'label': 'Emergency',
      'color': Theme.of(context).colorScheme.error,
      'action': 'emergency',
    },
    {
      'icon': Icons.report_rounded,
      'label': 'File Complaint',
      'color': Theme.of(context).colorScheme.secondary,
      'action': 'file_complaint',
    },
    {
      'icon': Icons.track_changes_rounded,
      'label': 'Track Status',
      'color': Theme.of(context).colorScheme.primary,
      'action': 'track_complaint',
    },
    {
      'icon': Icons.info_rounded,
      'label': 'Info',
      'color': Theme.of(context).colorScheme.primary,
      'action': 'info',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    
    if (messages.isEmpty) {
      messages.add({
        'role': 'bot', 
        'content': '👋 Hello! I am your Police Assistant for Ahilyanagar. I\'m here to help you 24/7 with:\n\n🚨 Emergency assistance\n📝 Filing complaints\n📊 Tracking reports\nℹ️ General information\n\nHow can I assist you today?'
      });
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({'role': 'user', 'content': message});
      isLoading = true;
    });
    _scrollToBottom();

    // Simulate processing time
    await Future.delayed(Duration(milliseconds: 800));

    String reply = _getBotResponse(message.toLowerCase());

    setState(() {
      isLoading = false;
      animatedText = '';
    });
    
    await _showAnimatedBotReply(reply);
    _scrollToBottom();
  }

  String _getBotResponse(String message) {
    // Check for exact matches first
    for (final key in faqResponses.keys) {
      if (message.contains(key)) {
        return faqResponses[key]!;
      }
    }

    // Check for emergency keywords
    if (message.contains('emergency') || message.contains('urgent') || message.contains('help')) {
      return faqResponses['emergency']!;
    }

    // Check for complaint related keywords
    if (message.contains('complaint') || message.contains('report') || message.contains('file')) {
      return faqResponses['file complaint']!;
    }

    // Check for tracking keywords
    if (message.contains('track') || message.contains('status') || message.contains('progress')) {
      return faqResponses['track complaint']!;
    }

    // Default response
    return "I'm sorry, I didn't understand that. You can ask me about:\n\n🚨 Emergency assistance\n📝 Filing complaints\n📊 Tracking reports\nℹ️ General police services\n\nOr use the quick action buttons below for faster access.";
  }

  Future<void> _showAnimatedBotReply(String reply) async {
    for (int i = 0; i <= reply.length; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      setState(() {
        animatedText = reply.substring(0, i);
      });
    }
    setState(() {
      messages.add({'role': 'bot', 'content': reply});
      animatedText = '';
    });
  }

  void _handleQuickAction(String action) {
    String message = '';
    switch (action) {
      case 'emergency':
        message = 'I need emergency assistance';
        break;
      case 'file_complaint':
        message = 'I want to file a complaint';
        break;
      case 'track_complaint':
        message = 'I want to track my complaint status';
        break;
      case 'info':
        message = 'Tell me about police services';
        break;
    }
    sendMessage(message);
  }

  Future<void> _callEmergency() async {
    final Uri url = Uri(scheme: 'tel', path: '100');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _showSnackBar('Cannot launch dialer on this device.');
    }
  }

  Future<void> _shareLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final url = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        _showSnackBar('Could not launch map.');
      }
    } catch (e) {
      _showSnackBar('Location error: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, {bool isAnimated = false}) {
    final isBot = message['role'] == 'bot';
    final bubbleColor = isBot ? Theme.of(context).cardColor : Theme.of(context).colorScheme.primary;
    final textColor = isBot ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface;
    final align = isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final avatar = isBot
        ? Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.smart_toy_rounded, color: Theme.of(context).colorScheme.onSurface, size: 20),
          )
        : CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(Icons.person_rounded, color: Theme.of(context).colorScheme.onSurface, size: 20),
          );

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBot) avatar,
          SizedBox(width: 8),
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(isBot ? 0 : 18),
                  bottomRight: Radius.circular(isBot ? 18 : 0),
                ),
                border: Border.all(
                  color: isBot ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : Theme.of(context).dividerColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                isAnimated ? animatedText : message['content']!,
                style: TextStyle(
                  color: textColor, 
                  fontSize: 16, 
                  height: 1.4,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          if (!isBot) avatar,
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: quickActions.map((action) => _quickActionButton(
              action['icon'],
              action['label'],
              action['color'],
              () => _handleQuickAction(action['action']),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _quickActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            elevation: 4,
          ),
          icon: Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 18),
          label: Text(
            label, 
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildEmergencyActions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.error, Theme.of(context).colorScheme.error.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.error.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.emergency_rounded, color: Theme.of(context).colorScheme.onSurface, size: 24),
              SizedBox(width: 12),
              Text(
                'Emergency Actions',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _callEmergency,
                  icon: Icon(Icons.call_rounded, color: Theme.of(context).colorScheme.error, size: 16),
                  label: Text('Call Police', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    foregroundColor: Theme.of(context).colorScheme.error,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _shareLocation,
                  icon: Icon(Icons.location_on_rounded, color: Theme.of(context).colorScheme.error, size: 16),
                  label: Text('Share Location', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    foregroundColor: Theme.of(context).colorScheme.error,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark ? [Color(0xFF0A0E21), Color(0xFF1A1F35)] : [Color(0xFFF5F5F5), Color(0xFFE0E0E0)],
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
                    colors: isDark ? [Color(0xFF1A1F35), Color(0xFF2A2F45)] : [Color(0xFF2A2F45), Color(0xFF3F51B5)],
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
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.smart_toy_rounded, color: Theme.of(context).colorScheme.onSurface, size: 28),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Police Chatbot',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '24/7 AI Assistant',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close_rounded, color: Theme.of(context).colorScheme.onSurface, size: 28),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                        padding: EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Emergency Actions (show only if emergency-related messages)
              if (messages.any((m) => m['content'].toString().toLowerCase().contains('emergency')))
                _buildEmergencyActions(),
              
              // Chat Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16),
                  itemCount: messages.length + (isLoading || animatedText.isNotEmpty ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < messages.length) {
                      final message = messages[index];
                      return _buildMessageBubble(message);
                    } else {
                      // Loading indicator
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.smart_toy_rounded, color: Theme.of(context).colorScheme.onSurface, size: 20),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Typing...',
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              
              // Quick Actions
              _buildQuickActions(),
              
              // Input Area
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                        ),
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            suffixIcon: IconButton(
                              onPressed: () {
                                // Voice recognition would go here
                                _showSnackBar('Voice recognition feature coming soon!');
                              },
                              icon: Icon(Icons.mic_rounded, color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              sendMessage(value.trim());
                              _controller.clear();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (_controller.text.trim().isNotEmpty) {
                            sendMessage(_controller.text.trim());
                            _controller.clear();
                          }
                        },
                        icon: Icon(Icons.send_rounded, color: Theme.of(context).colorScheme.onSurface, size: 24),
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Floating Chatbot Button Widget
class ChatbotFAB extends StatefulWidget {
  const ChatbotFAB({super.key});

  @override
  _ChatbotFABState createState() => _ChatbotFABState();
}

class _ChatbotFABState extends State<ChatbotFAB> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  void _openChatbot() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ChatbotScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _openChatbot,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Main chat icon
                    Center(
                      child: Icon(
                        Icons.chat_bubble_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 28,
                      ),
                    ),
                    // AI indicator
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).colorScheme.onSurface, width: 2),
                        ),
                        child: Icon(
                          Icons.smart_toy_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
