import 'package:demo_app/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chatbot_screen.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'sos_button.dart';
import 'l10n/language_provider.dart';
import 'l10n/app_localizations.dart';

// Form imports
import 'forms/complaint_registration_form.dart';
import 'forms/mike_sanction_registration_form.dart';
import 'forms/fir_download_form.dart';
import 'forms/accident_gd_form.dart';
import 'forms/lost_property_form.dart';
import 'forms/payment_history_form.dart';
import 'forms/event_performance_form.dart';
import 'forms/grievance_redressal_form.dart';
import 'forms/arrest_search_form.dart';
import 'forms/feedback_form.dart';
import 'forms/blood_donor_form.dart';
import 'forms/blood_request_form.dart';
import 'forms/track_my_trip_form.dart';
import 'forms/locked_house_info_form.dart';
import 'forms/senior_citizen_info_form.dart';
import 'forms/single_women_living_alone_form.dart';
import 'forms/report_abduction_form.dart';
import 'forms/report_cyber_fraud_form.dart';
import 'forms/share_information_form.dart';
import 'forms/appointment_with_sho_form.dart';
import 'forms/search_police_station_form.dart';
import 'forms/cyber_security_info_form.dart';
import 'forms/tourist_guide_form.dart';
import 'forms/user_manual_form.dart';
import 'forms/awareness_classes_form.dart';
import 'forms/rate_police_station_form.dart';
import 'forms/rate_application_form.dart';
import 'forms/social_media_of_police_form.dart';
import 'forms/maharashtra_government_form.dart';
import 'forms/ahilyanagar_police_form.dart';
import 'forms/cyber_done_form.dart';
import 'traffic_violation_dialog.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ahilyanagar Police',
      locale: languageProvider.currentLocale,
      supportedLocales: LanguageProvider.supportedLocales,
      localizationsDelegates: LanguageProvider.localizationsDelegates,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA), // light grey
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
          bodyMedium: TextStyle(color: Colors.black87, fontFamily: 'Poppins'),
          titleLarge: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        cardColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        dividerColor: Colors.grey,
      ),
      home: MainNavigation(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/home': (context) => MainNavigation(),
        // Form routes
        '/complaint_registration': (context) => ComplaintRegistrationForm(),
        '/mike_sanction_registration': (context) => MikeSanctionRegistrationForm(),
        '/fir_download': (context) => FIRDownloadForm(),
        '/accident_gd': (context) => AccidentGDForm(),
        '/lost_property': (context) => LostPropertyForm(),
        '/payment_history': (context) => PaymentHistoryForm(),
        '/event_performance': (context) => EventPerformanceForm(),
        '/grievance_redressal': (context) => GrievanceRedressalForm(),
        '/arrest_search': (context) => ArrestSearchForm(),
        '/feedback': (context) => FeedbackForm(),
        '/blood_donor': (context) => BloodDonorForm(),
        '/blood_request': (context) => BloodRequestForm(),
        '/track_my_trip': (context) => TrackMyTripForm(),
        '/locked_house_info': (context) => LockedHouseInfoForm(),
        '/senior_citizen_info': (context) => SeniorCitizenInfoForm(),
        '/single_women_living_alone': (context) => SingleWomenLivingAloneForm(),
        '/report_abduction': (context) => ReportAbductionForm(),
        '/report_cyber_fraud': (context) => ReportCyberFraudForm(),
        '/share_information': (context) => ShareInformationForm(),
        '/appointment_with_sho': (context) => AppointmentWithSHOForm(),
        '/search_police_station': (context) => SearchPoliceStationForm(),
        '/cyber_security_info': (context) => CyberSecurityInfoForm(),
        '/tourist_guide': (context) => TouristGuideForm(),
        '/user_manual': (context) => UserManualForm(),
        '/awareness_classes': (context) => AwarenessClassesForm(),
        '/rate_police_station': (context) => RatePoliceStationForm(),
        '/rate_application': (context) => RateApplicationForm(),
        '/social_media_of_police': (context) => SocialMediaOfPoliceForm(),
        '/maharashtra_government': (context) => MaharashtraGovernmentForm(),
        '/ahilyanagar_police': (context) => AhilyanagarPoliceForm(),
        '/cyber_done': (context) => CyberDoneForm(),
        '/chatbot': (context) => ChatbotScreen(),
        '/services': (context) => ServicesPage(),
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Widget> _pages = [
    const HomePage(),
    const ServicesPage(),
    const SizedBox.shrink(), // Placeholder for SOS slot
    const ContactPage(),
    ProfilePage(), // Use ProfilePage from profile_page.dart directly
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showTrafficViolationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TrafficViolationDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120), // Position above the bottom navigation
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Traffic Violation Button
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: FloatingActionButton(
                heroTag: "traffic_violation",
                onPressed: () => _showTrafficViolationDialog(context),
                backgroundColor: const Color(0xFFFF9800),
                foregroundColor: Colors.white,
                elevation: 8,
                child: const Icon(Icons.traffic_rounded, size: 24),
              ),
            ),
            // Chatbot Button
            ChatbotFAB(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1F35), Color(0xFF0F1424)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 80,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Bottom Navigation Bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      if (index == 2) return; // Prevent selecting the center (SOS) slot
                      setState(() {
                        _selectedIndex = index;
                      });
                      _animationController.reset();
                      _animationController.forward();
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home_rounded, size: 24),
                        label: AppLocalizations.of(context)!.home,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.miscellaneous_services_rounded, size: 24),
                        label: AppLocalizations.of(context)!.services,
                      ),
                      const BottomNavigationBarItem(
                        icon: SizedBox.shrink(), // Center slot for SOS FAB
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.contact_phone_rounded, size: 24),
                        label: AppLocalizations.of(context)!.contact,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.person_rounded, size: 24),
                        label: AppLocalizations.of(context)!.profile,
                      ),
                    ],
                    selectedItemColor: Color(0xFF64B5F6),
                    unselectedItemColor: Colors.white60,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
                // Centered SOS Button
                Positioned(
                  bottom: 30, // Increased from 20 to 30 for better vertical alignment
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE91E63).withAlpha((0.4 * 255).toInt()),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: SOSButton(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// Modern App Header for HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1A1F35)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120), // Add bottom padding for FAB and navbar
            child: Column(
              children: [
                _buildHeader(context),
                _buildAlertSection(context),
                _buildQuickServicesSection(context),
                _buildEmergencyContactsSection(context),
                _buildDailyUpdatesSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A1F35),
            Color(0xFF2A2F45),
            Color(0xFF1A1F35),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF64B5F6),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 1),
                Text(
                  AppLocalizations.of(context)!.ahilyanagarPolice,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.white, size: 28),
            onPressed: () => _showSearchDialog(context),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_rounded, color: Colors.white, size: 28),
                onPressed: () => _showNotifications(context),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ServiceSearchDialog();
      },
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotificationDialog();
      },
    );
  }

  Widget _buildAlertSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: GestureDetector(
        onTap: () => _showAlertDetails(context),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE91E63),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFE91E63), size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.missingPersonAlertTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.missingPersonAlertDescription,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1F35),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFE91E63),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Missing Person Alert',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A person has been reported missing in the Ahilyanagar area. If you have any information, please contact the police immediately.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Emergency Contact: 100',
                style: TextStyle(
                  color: Color(0xFFE91E63),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFF64B5F6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickServicesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F6FA), // light grey background
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0E0E0), // subtle grey
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(Icons.flash_on_rounded, color: Colors.black54, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.quickServices,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/services'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.black54,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // All quick services cards now use light grey
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: [
                  _EnhancedServiceCard(
                    icon: Icons.report_problem_rounded,
                    title: AppLocalizations.of(context)!.fileComplaint,
                    subtitle: 'Register complaints',
                    color: const Color(0xFF18122B), // dark black-purple
                    onTap: () => Navigator.pushNamed(context, '/complaint_registration'),
                  ),
                  _EnhancedServiceCard(
                    icon: Icons.security_rounded,
                    title: AppLocalizations.of(context)!.safetyTips,
                    subtitle: 'Cyber security info',
                    color: const Color(0xFF18122B), // dark black-purple
                    onTap: () => Navigator.pushNamed(context, '/cyber_security_info'),
                  ),
                  _EnhancedServiceCard(
                    icon: Icons.bloodtype_rounded,
                    title: AppLocalizations.of(context)!.bloodRequest,
                    subtitle: 'Request blood donation',
                    color: const Color(0xFF18122B), // dark black-purple
                    onTap: () => Navigator.pushNamed(context, '/blood_request'),
                  ),
                  _EnhancedServiceCard(
                    icon: Icons.event_rounded,
                    title: AppLocalizations.of(context)!.appointments,
                    subtitle: 'Book appointments',
                    color: const Color(0xFF18122B), // dark black-purple
                    onTap: () => Navigator.pushNamed(context, '/appointment_with_sho'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyContactsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3F51B5), Color(0xFF303F9F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF3F51B5),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.emergency_rounded, color: Color(0xFFFFD700), size: 28),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.emergencyContacts,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _ContactIcon(
                      icon: Icons.local_police_rounded,
                      label: AppLocalizations.of(context)!.police,
                      phone: '100',
                      color: const Color(0xFF2196F3),
                    ),
                    const SizedBox(width: 16),
                    _ContactIcon(
                      icon: Icons.local_hospital_rounded,
                      label: AppLocalizations.of(context)!.ambulance,
                      phone: '108',
                      color: const Color(0xFFE91E63),
                    ),
                    const SizedBox(width: 16),
                    _ContactIcon(
                      icon: Icons.local_fire_department_rounded,
                      label: AppLocalizations.of(context)!.fire,
                      phone: '101',
                      color: const Color(0xFFFF9800),
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

  Widget _buildDailyUpdatesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E2337), Color(0xFF2A2F45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(Icons.newspaper_rounded, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.dailyUpdates,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF64B5F6),
                        fontSize: 20,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showAllNews(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3F51B5).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 320, // Increased height for better spacing
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _EnhancedUpdateTile(
                    icon: Icons.traffic_rounded,
                    title: AppLocalizations.of(context)!.trafficDiversionTitle,
                    subtitle: AppLocalizations.of(context)!.trafficDiversionSubtitle,
                    color: const Color(0xFFFF9800),
                    date: '2 hours ago',
                    priority: 'High',
                  ),
                  _EnhancedUpdateTile(
                    icon: Icons.school_rounded,
                    title: AppLocalizations.of(context)!.awarenessDriveTitle,
                    subtitle: AppLocalizations.of(context)!.awarenessDriveSubtitle,
                    color: const Color(0xFF4CAF50),
                    date: '5 hours ago',
                    priority: 'Medium',
                  ),
                  _EnhancedUpdateTile(
                    icon: Icons.security_rounded,
                    title: AppLocalizations.of(context)!.cyberSafetyTipsTitle,
                    subtitle: AppLocalizations.of(context)!.cyberSafetyTipsSubtitle,
                    color: const Color(0xFF2196F3),
                    date: '1 day ago',
                    priority: 'Low',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllNews(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AllNewsDialog();
      },
    );
  }
}



class _EnhancedUpdateTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String date;
  final String priority;

  const _EnhancedUpdateTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.date,
    required this.priority,
  });

  Color _getPriorityColor() {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xFFE91E63);
      case 'medium':
        return const Color(0xFFFF9800);
      case 'low':
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF64B5F6);
    }
  }

  void _showUpdateDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1F35),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor().withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            priority,
                            style: TextStyle(
                              color: _getPriorityColor(),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2F45),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: color, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'This update is important for your safety and awareness.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFF64B5F6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showUpdateDetails(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2F45),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withAlpha((0.2 * 255).toInt())),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white60,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ServiceIcon({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withAlpha((0.7 * 255).toInt())],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: color.withAlpha((0.3 * 255).toInt()),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _EnhancedServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const _EnhancedServiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  State<_EnhancedServiceCard> createState() => _EnhancedServiceCardState();
}

class _EnhancedServiceCardState extends State<_EnhancedServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: widget.color, // always light grey
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: _isPressed ? 4 : 8,
                    offset: Offset(0, _isPressed ? 2 : 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: widget.onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            widget.icon,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'TAP',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ContactIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String phone;
  final Color color;

  const _ContactIcon({
    required this.icon,
    required this.label,
    required this.phone,
    required this.color,
  });

  void _makeCall(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch phone dialer'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _makeCall(context),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withAlpha((0.7 * 255).toInt())],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha((0.3 * 255).toInt()),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            phone,
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1A1F35)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Enhanced Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A1F35), Color(0xFF2A2F45)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF64B5F6),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.miscellaneous_services_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.policeServices,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.accessAllServices,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF64B5F6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Services Page Body
              const Expanded(
                child: ServicesPageBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This widget is the attractive services UI body for the ServicesPage
class ServicesPageBody extends StatelessWidget {
  const ServicesPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      SectionData(
        icon: Icons.account_balance_rounded,
        color: const Color(0xFF3F51B5),
        title: AppLocalizations.of(context)!.thunaService,
        subtitle: AppLocalizations.of(context)!.officialPoliceServices,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.complaintRegistration, icon: Icons.report_problem_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.mikeSanctionRegistration, icon: Icons.mic_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.firDownload, icon: Icons.download_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.accidentGd, icon: Icons.car_crash_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.lostProperty, icon: Icons.search_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.paymentHistory, icon: Icons.payment_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.eventPerformance, icon: Icons.event_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.grievanceRedressal, icon: Icons.feedback_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.arrestSearch, icon: Icons.person_search_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.feedback, icon: Icons.rate_review_rounded),
        ],
      ),
      SectionData(
        icon: Icons.bloodtype_rounded,
        color: const Color(0xFFE91E63),
        title: AppLocalizations.of(context)!.polBloodService,
        subtitle: AppLocalizations.of(context)!.bloodDonationRequests,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.bloodDonor, icon: Icons.favorite_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.bloodRequest, icon: Icons.bloodtype_rounded),
        ],
      ),
      SectionData(
        icon: Icons.security_rounded,
        color: const Color(0xFF4CAF50),
        title: AppLocalizations.of(context)!.citizenSafetyService,
        subtitle: AppLocalizations.of(context)!.personalSafetyFeatures,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.trackMyTrip, icon: Icons.location_on_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.lockedHouseInfo, icon: Icons.home_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.seniorCitizenInfo, icon: Icons.elderly_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.singleWomenLivingAlone, icon: Icons.woman_rounded),
        ],
      ),
      SectionData(
        icon: Icons.report_problem_rounded,
        color: const Color(0xFFFF9800),
        title: AppLocalizations.of(context)!.reportOffence,
        subtitle: AppLocalizations.of(context)!.reportCrimesIncidents,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.reportAbduction, icon: Icons.person_off_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.reportCyberFraud, icon: Icons.computer_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.shareInformation, icon: Icons.share_rounded),
        ],
      ),
      SectionData(
        icon: Icons.event_rounded,
        color: const Color(0xFF9C27B0),
        title: AppLocalizations.of(context)!.appointmentSearch,
        subtitle: AppLocalizations.of(context)!.scheduleFindServices,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.appointmentWithSho, icon: Icons.calendar_today_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.searchPoliceStation, icon: Icons.location_city_rounded),
        ],
      ),
      SectionData(
        icon: Icons.tips_and_updates_rounded,
        color: const Color(0xFF00BCD4),
        title: AppLocalizations.of(context)!.internetTips,
        subtitle: AppLocalizations.of(context)!.cyberSafetyGuidance,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.cyberSecurityInfo, icon: Icons.security_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.touristGuide, icon: Icons.tour_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.userManual, icon: Icons.menu_book_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.awarenessClasses, icon: Icons.school_rounded),
        ],
      ),
      SectionData(
        icon: Icons.star_rounded,
        color: const Color(0xFFFFD700),
        title: AppLocalizations.of(context)!.rate,
        subtitle: AppLocalizations.of(context)!.rateOurServices,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.ratePoliceStation, icon: Icons.location_city_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.rateApplication, icon: Icons.rate_review_rounded),
        ],
      ),
      SectionData(
        icon: Icons.link_rounded,
        color: const Color(0xFF607D8B),
        title: AppLocalizations.of(context)!.webLinks,
        subtitle: AppLocalizations.of(context)!.externalResources,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.socialMediaOfPolice, icon: Icons.share_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.maharashtraGovernment, icon: Icons.account_balance_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.ahilyanagarPolice, icon: Icons.local_police_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.cyberDone, icon: Icons.computer_rounded),
        ],
      ),
      SectionData(
        icon: Icons.smart_toy_rounded,
        color: const Color(0xFF64B5F6),
        title: AppLocalizations.of(context)!.aiAssistant,
        subtitle: AppLocalizations.of(context)!.policeChatbot,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.policeChatbot, icon: Icons.chat_bubble_rounded),
        ],
      ),
    ];

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: const EdgeInsets.all(14),
      childAspectRatio: 0.8,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      clipBehavior: Clip.hardEdge,
      children: sections.map((section) => SectionCard(section: section)).toList(),
    );
  }
}

class SectionData {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final List<Widget> children;

  SectionData({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.children,
  });
}

class SectionCard extends StatelessWidget {
  final SectionData section;
  const SectionCard({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SectionDetailsPage(section: section),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [section.color.withOpacity(0.8), section.color.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: section.color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(section.icon, color: Colors.white, size: 36),
            const SizedBox(height: 12),
            Text(
              section.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionDetailsPage extends StatelessWidget {
  final SectionData section;
  const SectionDetailsPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF23284A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: section.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(section.icon, color: section.color, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    section.subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF23284A),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: section.children,
      ),
    );
  }
}

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> get _tabs => [
    AppLocalizations.of(context)!.contact,
    AppLocalizations.of(context)!.helpline,
    AppLocalizations.of(context)!.emergency,
  ];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController ??= TabController(length: _tabs.length, vsync: this);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E21), Color(0xFF1A1F35)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Enhanced Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A1F35), Color(0xFF2A2F45)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF64B5F6),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.contact_phone_rounded, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.contactEmergency,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.getInTouch,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF64B5F6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Search Bar
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF3F51B5),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.searchContacts,
                          prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF64B5F6)),
                          filled: true,
                          fillColor: Color(0xFF2A2F45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Color(0xFF3F51B5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Color(0xFF64B5F6), width: 2),
                          ),
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Enhanced Tab Bar
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2F45),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        tabs: _tabs.map((t) => Tab(
                          child: Text(
                            t,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        )).toList(),
                        indicatorColor: const Color(0xFF64B5F6),
                        indicatorWeight: 3,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        dividerColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _ContactList(search: _searchController.text),
                    _HelplineList(search: _searchController.text),
                    const _EmergencySection(),
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

class _ContactList extends StatelessWidget {
  final String search;

  const _ContactList({required this.search});

  final List<Map<String, String>> contacts = const [
    {'name': 'Inspector Sharma', 'phone': '9876543210'},
    {'name': 'SI Patil', 'phone': '9876543211'},
    {'name': 'Constable Rao', 'phone': '9876543212'},
    {'name': 'Inspector Deshmukh', 'phone': '9876543213'},
    {'name': 'SI Singh', 'phone': '9876543214'},
    // Add more contacts as needed
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = contacts.where((c) => c['name']!.toLowerCase().contains(search.toLowerCase())).toList();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, i) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E2337), Color(0xFF2A2F45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF64B5F6),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.person_rounded, color: Colors.white, size: 24),
          ),
          title: Text(
            filtered[i]['name']!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            filtered[i]['phone']!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          trailing: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4CAF50),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const IconButton(
              icon: Icon(Icons.call_rounded, color: Colors.white, size: 20),
              onPressed: null,
            ),
          ),
        ),
      ),
    );
  }
}

class _HelplineList extends StatelessWidget {
  final String search;

  const _HelplineList({required this.search});

  List<Map<String, String>> getHelplines(BuildContext context) => [
    {'name': AppLocalizations.of(context)!.womenHelpline, 'phone': '1091'},
    {'name': AppLocalizations.of(context)!.childHelpline, 'phone': '1098'},
    {'name': AppLocalizations.of(context)!.ambulance, 'phone': '108'},
    {'name': AppLocalizations.of(context)!.fire, 'phone': '101'},
    {'name': AppLocalizations.of(context)!.police, 'phone': '100'},
    // Add more helplines as needed
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = getHelplines(context).where((c) => c['name']!.toLowerCase().contains(search.toLowerCase())).toList();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, i) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E2337), Color(0xFF2A2F45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE91E63),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.phone_rounded, color: Colors.white, size: 24),
          ),
          title: Text(
            filtered[i]['name']!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            filtered[i]['phone']!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          trailing: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF4CAF50),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const IconButton(
              icon: Icon(Icons.call_rounded, color: Colors.white, size: 20),
              onPressed: null,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmergencySection extends StatelessWidget {
  const _EmergencySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Notification Card
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE91E63),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.notification_important_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.emergencyNotification,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.sendEmergencyAlert,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.notify,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Emergency Contacts Section
            Text(
              AppLocalizations.of(context)!.emergencyContacts,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFD700),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 14),
            _EmergencyContactCard(
              title: AppLocalizations.of(context)!.policeDepartment,
              phone: '100',
              color: Color(0xFF2196F3),
              icon: Icons.local_police_rounded,
            ),
            _EmergencyContactCard(
              title: AppLocalizations.of(context)!.ambulanceService,
              phone: '108',
              color: Color(0xFFE91E63),
              icon: Icons.local_hospital_rounded,
            ),
            _EmergencyContactCard(
              title: AppLocalizations.of(context)!.fireDepartment,
              phone: '101',
              color: Color(0xFFFF9800),
              icon: Icons.local_fire_department_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyContactCard extends StatelessWidget {
  final String title;
  final String phone;
  final Color color;
  final IconData icon;

  _EmergencyContactCard({
    required this.title,
    required this.phone,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E2337), Color(0xFF2A2F45)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withAlpha((0.7 * 255).toInt())],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha((0.3 * 255).toInt()),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          phone,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withAlpha((0.7 * 255).toInt())],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha((0.3 * 255).toInt()),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              AppLocalizations.of(context)!.call,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceForm extends StatelessWidget {
  final String title;
  final IconData icon;

  const ServiceForm({super.key, required this.title, required this.icon});

  void _navigateToForm(BuildContext context) {
    // Map service titles to their corresponding form routes
    final Map<String, String> serviceRoutes = {
      AppLocalizations.of(context)!.complaintRegistration: '/complaint_registration',
      AppLocalizations.of(context)!.mikeSanctionRegistration: '/mike_sanction_registration',
      AppLocalizations.of(context)!.firDownload: '/fir_download',
      AppLocalizations.of(context)!.accidentGd: '/accident_gd',
      AppLocalizations.of(context)!.lostProperty: '/lost_property',
      AppLocalizations.of(context)!.paymentHistory: '/payment_history',
      AppLocalizations.of(context)!.eventPerformance: '/event_performance',
      AppLocalizations.of(context)!.grievanceRedressal: '/grievance_redressal',
      AppLocalizations.of(context)!.arrestSearch: '/arrest_search',
      AppLocalizations.of(context)!.feedback: '/feedback',
      AppLocalizations.of(context)!.bloodDonor: '/blood_donor',
      AppLocalizations.of(context)!.bloodRequest: '/blood_request',
      AppLocalizations.of(context)!.trackMyTrip: '/track_my_trip',
      AppLocalizations.of(context)!.lockedHouseInfo: '/locked_house_info',
      AppLocalizations.of(context)!.seniorCitizenInfo: '/senior_citizen_info',
      AppLocalizations.of(context)!.singleWomenLivingAlone: '/single_women_living_alone',
      AppLocalizations.of(context)!.reportAbduction: '/report_abduction',
      AppLocalizations.of(context)!.reportCyberFraud: '/report_cyber_fraud',
      AppLocalizations.of(context)!.shareInformation: '/share_information',
      AppLocalizations.of(context)!.appointmentWithSho: '/appointment_with_sho',
      AppLocalizations.of(context)!.searchPoliceStation: '/search_police_station',
      AppLocalizations.of(context)!.cyberSecurityInfo: '/cyber_security_info',
      AppLocalizations.of(context)!.touristGuide: '/tourist_guide',
      AppLocalizations.of(context)!.userManual: '/user_manual',
      AppLocalizations.of(context)!.awarenessClasses: '/awareness_classes',
      AppLocalizations.of(context)!.ratePoliceStation: '/rate_police_station',
      AppLocalizations.of(context)!.rateApplication: '/rate_application',
      AppLocalizations.of(context)!.socialMediaOfPolice: '/social_media_of_police',
      AppLocalizations.of(context)!.maharashtraGovernment: '/maharashtra_government',
      AppLocalizations.of(context)!.ahilyanagarPolice: '/ahilyanagar_police',
      AppLocalizations.of(context)!.cyberDone: '/cyber_done',
      AppLocalizations.of(context)!.policeChatbot: '/chatbot',
    };

    final route = serviceRoutes[title];
    if (route != null) {
      Navigator.pushNamed(context, route);
    } else {
      // Show a snackbar if the form is not yet implemented
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Form for "$title" is coming soon!',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF3F51B5),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2F45),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha((0.1 * 255).toInt())),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF3F51B5).withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF64B5F6), size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        trailing: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF3F51B5),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => _navigateToForm(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              AppLocalizations.of(context)!.access,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceSearchDialog extends StatefulWidget {
  @override
  _ServiceSearchDialogState createState() => _ServiceSearchDialogState();
}

class _ServiceSearchDialogState extends State<ServiceSearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredServices = [];
  List<Map<String, dynamic>> _allServices = [];

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _filteredServices = []; // Start with empty list
  }

  void _initializeServices() {
    _allServices = [
      {'name': 'Complaint Registration', 'route': '/complaint_registration', 'icon': Icons.report_problem_rounded, 'category': 'Police Services'},
      {'name': 'Mike Sanction Registration', 'route': '/mike_sanction_registration', 'icon': Icons.mic_rounded, 'category': 'Police Services'},
      {'name': 'FIR Download', 'route': '/fir_download', 'icon': Icons.download_rounded, 'category': 'Police Services'},
      {'name': 'Accident GD', 'route': '/accident_gd', 'icon': Icons.car_crash_rounded, 'category': 'Police Services'},
      {'name': 'Lost Property', 'route': '/lost_property', 'icon': Icons.search_rounded, 'category': 'Police Services'},
      {'name': 'Payment History', 'route': '/payment_history', 'icon': Icons.payment_rounded, 'category': 'Police Services'},
      {'name': 'Event Performance', 'route': '/event_performance', 'icon': Icons.event_rounded, 'category': 'Police Services'},
      {'name': 'Grievance Redressal', 'route': '/grievance_redressal', 'icon': Icons.feedback_rounded, 'category': 'Police Services'},
      {'name': 'Arrest Search', 'route': '/arrest_search', 'icon': Icons.person_search_rounded, 'category': 'Police Services'},
      {'name': 'Feedback', 'route': '/feedback', 'icon': Icons.rate_review_rounded, 'category': 'Police Services'},
      {'name': 'Blood Donor', 'route': '/blood_donor', 'icon': Icons.favorite_rounded, 'category': 'Blood Services'},
      {'name': 'Blood Request', 'route': '/blood_request', 'icon': Icons.bloodtype_rounded, 'category': 'Blood Services'},
      {'name': 'Track My Trip', 'route': '/track_my_trip', 'icon': Icons.location_on_rounded, 'category': 'Safety Services'},
      {'name': 'Locked House Info', 'route': '/locked_house_info', 'icon': Icons.home_rounded, 'category': 'Safety Services'},
      {'name': 'Senior Citizen Info', 'route': '/senior_citizen_info', 'icon': Icons.elderly_rounded, 'category': 'Safety Services'},
      {'name': 'Single Women Living Alone', 'route': '/single_women_living_alone', 'icon': Icons.woman_rounded, 'category': 'Safety Services'},
      {'name': 'Report Abduction', 'route': '/report_abduction', 'icon': Icons.person_off_rounded, 'category': 'Report Services'},
      {'name': 'Report Cyber Fraud', 'route': '/report_cyber_fraud', 'icon': Icons.computer_rounded, 'category': 'Report Services'},
      {'name': 'Share Information', 'route': '/share_information', 'icon': Icons.share_rounded, 'category': 'Report Services'},
      {'name': 'Appointment with SHO', 'route': '/appointment_with_sho', 'icon': Icons.calendar_today_rounded, 'category': 'Appointment Services'},
      {'name': 'Search Police Station', 'route': '/search_police_station', 'icon': Icons.location_city_rounded, 'category': 'Appointment Services'},
      {'name': 'Cyber Security Info', 'route': '/cyber_security_info', 'icon': Icons.security_rounded, 'category': 'Information Services'},
      {'name': 'Tourist Guide', 'route': '/tourist_guide', 'icon': Icons.tour_rounded, 'category': 'Information Services'},
      {'name': 'User Manual', 'route': '/user_manual', 'icon': Icons.menu_book_rounded, 'category': 'Information Services'},
      {'name': 'Awareness Classes', 'route': '/awareness_classes', 'icon': Icons.school_rounded, 'category': 'Information Services'},
      {'name': 'Rate Police Station', 'route': '/rate_police_station', 'icon': Icons.location_city_rounded, 'category': 'Rating Services'},
      {'name': 'Rate Application', 'route': '/rate_application', 'icon': Icons.rate_review_rounded, 'category': 'Rating Services'},
      {'name': 'Social Media of Police', 'route': '/social_media_of_police', 'icon': Icons.share_rounded, 'category': 'Web Links'},
      {'name': 'Maharashtra Government', 'route': '/maharashtra_government', 'icon': Icons.account_balance_rounded, 'category': 'Web Links'},
      {'name': 'Ahilyanagar Police', 'route': '/ahilyanagar_police', 'icon': Icons.local_police_rounded, 'category': 'Web Links'},
      {'name': 'Cyber Done', 'route': '/cyber_done', 'icon': Icons.computer_rounded, 'category': 'Web Links'},
      {'name': 'Police Chatbot', 'route': '/chatbot', 'icon': Icons.chat_bubble_rounded, 'category': 'AI Assistant'},
    ];
  }

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredServices = []; // Show empty when no search query
      } else {
        _filteredServices = _allServices.where((service) {
          return service['name'].toLowerCase().contains(query.toLowerCase()) ||
                 service['category'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1F35), Color(0xFF2A2F45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search All Services',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _filterServices,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type service name or category...',
                  hintStyle: const TextStyle(color: Colors.white60),
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64B5F6)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, color: Colors.white60),
                          onPressed: () {
                            _searchController.clear();
                            _filterServices('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: const Color(0xFF2A2F45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF3F51B5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
                  ),
                ),
              ),
            ),
            // Services List
            Expanded(
              child: _filteredServices.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _searchController.text.isEmpty 
                                ? Icons.search_rounded 
                                : Icons.search_off_rounded, 
                            color: Colors.white60, 
                            size: 64
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty 
                                ? 'Type to search services...' 
                                : 'No services found',
                            style: const TextStyle(color: Colors.white60, fontSize: 18),
                          ),
                          if (_searchController.text.isEmpty) ...[
                            const SizedBox(height: 8),
                            const Text(
                              'Search by service name or category',
                              style: TextStyle(color: Colors.white54, fontSize: 14),
                            ),
                          ],
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredServices.length,
                      itemBuilder: (context, index) {
                        final service = _filteredServices[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2F45),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3F51B5).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(service['icon'], color: const Color(0xFF64B5F6), size: 20),
                            ),
                            title: Text(
                              service['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              service['category'],
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, service['route']);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3F51B5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              child: const Text('Access'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class NotificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'New Safety Alert',
        'message': 'Traffic diversion on Main Road due to construction work.',
        'time': '2 minutes ago',
        'type': 'alert',
        'icon': Icons.warning_rounded,
        'color': const Color(0xFFFF9800),
      },
      {
        'title': 'Blood Donation Camp',
        'message': 'Blood donation camp organized at Police HQ tomorrow.',
        'time': '1 hour ago',
        'type': 'info',
        'icon': Icons.bloodtype_rounded,
        'color': const Color(0xFFE91E63),
      },
      {
        'title': 'Cyber Safety Workshop',
        'message': 'Free cyber safety workshop for senior citizens.',
        'time': '3 hours ago',
        'type': 'event',
        'icon': Icons.security_rounded,
        'color': const Color(0xFF4CAF50),
      },
      {
        'title': 'Missing Person Found',
        'message': 'The missing person reported yesterday has been found safe.',
        'time': '1 day ago',
        'type': 'success',
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF4CAF50),
      },
    ];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1F35), Color(0xFF2A2F45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_rounded, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Notifications List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2F45),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: notification['color'].withOpacity(0.3)),
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: notification['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(notification['icon'], color: notification['color'], size: 20),
                      ),
                      title: Text(
                        notification['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            notification['message'],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification['time'],
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: notification['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          notification['type'].toUpperCase(),
                          style: TextStyle(
                            color: notification['color'],
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllNewsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allNews = [
      {
        'title': 'Ahilyanagar Police Launches New Safety App',
        'description': 'The Ahilyanagar Police have launched a new safety app for citizens. Download now to stay updated and safe!',
        'date': '2024-01-15',
        'category': 'Technology',
        'icon': Icons.phone_android_rounded,
        'color': const Color(0xFF64B5F6),
      },
      {
        'title': 'Awareness Drive on Cyber Safety',
        'description': 'A special awareness drive on cyber safety will be held at the city auditorium this Friday.',
        'date': '2024-01-12',
        'category': 'Education',
        'icon': Icons.school_rounded,
        'color': const Color(0xFF4CAF50),
      },
      {
        'title': 'Blood Donation Camp Organized',
        'description': 'Join the blood donation camp organized by Ahilyanagar Police on 15th July at Police HQ.',
        'date': '2024-01-10',
        'category': 'Health',
        'icon': Icons.bloodtype_rounded,
        'color': const Color(0xFFE91E63),
      },
      {
        'title': 'Traffic Safety Campaign',
        'description': 'Ahilyanagar Police launches traffic safety campaign to reduce accidents.',
        'date': '2024-01-08',
        'category': 'Safety',
        'icon': Icons.traffic_rounded,
        'color': const Color(0xFFFF9800),
      },
      {
        'title': 'New Police Station Inaugurated',
        'description': 'A new police station has been inaugurated in the western part of the city.',
        'date': '2024-01-05',
        'category': 'Infrastructure',
        'icon': Icons.location_city_rounded,
        'color': const Color(0xFF9C27B0),
      },
      {
        'title': 'Community Policing Initiative',
        'description': 'Ahilyanagar Police introduces community policing initiative for better public safety.',
        'date': '2024-01-03',
        'category': 'Community',
        'icon': Icons.people_rounded,
        'color': const Color(0xFF607D8B),
      },
    ];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1F35), Color(0xFF2A2F45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.newspaper_rounded, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'All News & Updates',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // News List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: allNews.length,
                itemBuilder: (context, index) {
                  final news = allNews[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2F45),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: news['color'].withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(news['icon'], color: news['color'], size: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      news['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      news['description'],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: news['color'].withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            news['category'],
                                            style: TextStyle(
                                              color: news['color'],
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          news['date'],
                                          style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: news['color'].withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.share_rounded, color: news['color'], size: 16),
                              const SizedBox(width: 8),
                              Text(
                                'Share this news',
                                style: TextStyle(
                                  color: news['color'],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Icon(Icons.bookmark_border_rounded, color: news['color'], size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

