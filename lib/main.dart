import 'package:demo_app/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'chatbot_screen.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'sos_button.dart';
import 'l10n/language_provider.dart';
import 'l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1F35),
          selectedItemColor: Color(0xFF64B5F6),
          unselectedItemColor: Colors.white60,
          type: BottomNavigationBarType.fixed,
          elevation: 20,
        ),
        cardColor: const Color(0xFF1E2337),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFE91E63),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3F51B5),
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: const Color(0xFF3F51B5).withAlpha((0.3 * 255).toInt()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2F45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFF3F51B5).withAlpha((0.3 * 255).toInt()),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.white54),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3F51B5),
          secondary: Color(0xFF64B5F6),
          surface: Color(0xFF0A0E21),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          error: Color(0xFFE57373),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 32,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120), // Position above the bottom navigation
        child: ChatbotFAB(),
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
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 60,
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
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

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
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              children: [
                _buildHeader(context),
                _buildSearchBar(context),
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

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim().toLowerCase();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search quick services...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFF64B5F6)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.07),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white54),
        ),
        style: const TextStyle(color: Colors.white),
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Search'),
                  content: const Text('Search functionality coming soon!'),
                  actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))],
                ),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_rounded, color: Colors.white, size: 28),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No new notifications.')),
                  );
                },
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
          const SizedBox(width: 8),
          // Profile icon removed as per user request
        ],
      ),
    );
  }

  Widget _buildAlertSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
                child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 32),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickServicesSection(BuildContext context) {
    final allServices = [
      {'icon': Icons.report_problem_rounded, 'label': AppLocalizations.of(context)!.fileComplaint, 'color': Color(0xFFFF9800), 'route': '/complaint_registration'},
      {'icon': Icons.security_rounded, 'label': AppLocalizations.of(context)!.safetyTips, 'color': Color(0xFF4CAF50), 'route': '/cyber_security_info'},
      {'icon': Icons.bloodtype_rounded, 'label': AppLocalizations.of(context)!.bloodRequest, 'color': Color(0xFFE91E63), 'route': '/blood_request'},
      {'icon': Icons.event_rounded, 'label': AppLocalizations.of(context)!.appointments, 'color': Color(0xFF9C27B0), 'route': '/appointment_with_sho'},
    ];
    final filtered = _searchQuery.isEmpty
        ? allServices
        : allServices.where((s) => s['label'].toString().toLowerCase().contains(_searchQuery)).toList();
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.quickServices,
                style: TextStyle(
                  color: Color(0xFF64B5F6),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: filtered.isEmpty
                    ? [Text('No services found', style: TextStyle(color: Colors.white54))]
                    : filtered.map((s) => _ServiceIcon(
                        icon: s['icon'] as IconData,
                        label: s['label'] as String,
                        color: s['color'] as Color,
                        route: s['route'] as String?,
                      )).toList(),
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
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(width: 16),
                    _ContactIcon(
                      icon: Icons.female,
                      label: AppLocalizations.of(context)!.womenHelpline ?? 'Women Helpline',
                      phone: '1091', // National Women Helpline
                      color: const Color(0xFF8E24AA),
                    ),
                    const SizedBox(width: 16),
                    _ContactIcon(
                      icon: Icons.child_care,
                      label: AppLocalizations.of(context)!.childHelpline ?? 'Child Helpline',
                      phone: '1098', // National Child Helpline
                      color: const Color(0xFF43A047),
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
                  const Icon(Icons.newspaper_rounded, color: Color(0xFF64B5F6), size: 28),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.dailyUpdates,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF64B5F6),
                      fontSize: 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300, // Fixed height for the updates list
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  _UpdateTile(
                    icon: Icons.traffic_rounded,
                    title: AppLocalizations.of(context)!.trafficDiversionTitle,
                    subtitle: AppLocalizations.of(context)!.trafficDiversionSubtitle,
                    color: Color(0xFFFF9800),
                  ),
                  _UpdateTile(
                    icon: Icons.school_rounded,
                    title: AppLocalizations.of(context)!.awarenessDriveTitle,
                    subtitle: AppLocalizations.of(context)!.awarenessDriveSubtitle,
                    color: Color(0xFF4CAF50),
                  ),
                  _UpdateTile(
                    icon: Icons.security_rounded,
                    title: AppLocalizations.of(context)!.cyberSafetyTipsTitle,
                    subtitle: AppLocalizations.of(context)!.cyberSafetyTipsSubtitle,
                    color: Color(0xFF2196F3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpdateTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _UpdateTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))],
          ),
        );
      },
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
  final String? route;

  const _ServiceIcon({
    required this.icon,
    required this.label,
    required this.color,
    this.route,
  });

  void _onTap(BuildContext context) {
    if (route != null) {
      Navigator.pushNamed(context, route!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tapped on: ' + label)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTap(context),
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final Uri phoneUri = Uri(scheme: 'tel', path: phone);
        try {
          if (await canLaunchUrl(phoneUri)) {
            await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not launch phone dialer')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ' + e.toString())),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              phone, // Use the phone number passed to the widget
              style: const TextStyle(
                color: Color(0xFFFFD700),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF283366), Color(0xFF1B223A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.20),
                    blurRadius: 22,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFFFD700),
                  width: 2.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.emergencyContacts,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFD700),
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Call Police
                            launchUrl(Uri.parse('tel:100'));
                          },
                          child: Column(
                            children: [
                              _EmergencyContactCard(
                                title: AppLocalizations.of(context)!.policeDepartment,
                                phone: '100',
                                color: Color(0xFF2196F3),
                                icon: Icons.local_police_rounded,
                                borderColor: Color(0xFF2196F3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Call Ambulance
                            launchUrl(Uri.parse('tel:108'));
                          },
                          child: Column(
                            children: [
                              _EmergencyContactCard(
                                title: AppLocalizations.of(context)!.ambulanceService,
                                phone: '108',
                                color: Color(0xFFE91E63),
                                icon: Icons.local_hospital_rounded,
                                borderColor: Color(0xFFE91E63),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Call Fire
                            launchUrl(Uri.parse('tel:101'));
                          },
                          child: Column(
                            children: [
                              _EmergencyContactCard(
                                title: AppLocalizations.of(context)!.fireDepartment,
                                phone: '101',
                                color: Color(0xFFFF9800),
                                icon: Icons.local_fire_department_rounded,
                                borderColor: Color(0xFFFF9800),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Call Women Helpline
                            launchUrl(Uri.parse('tel:1091'));
                          },
                          child: Column(
                            children: [
                              _EmergencyContactCard(
                                title: AppLocalizations.of(context)!.womenHelpline,
                                phone: '1091',
                                color: Color(0xFF8E24AA),
                                icon: Icons.female,
                                borderColor: Color(0xFF8E24AA),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Helpline',
                                style: TextStyle(
                                  color: Color(0xFF8E24AA),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Call Child Helpline
                            launchUrl(Uri.parse('tel:1098'));
                          },
                          child: Column(
                            children: [
                              _EmergencyContactCard(
                                title: AppLocalizations.of(context)!.childHelpline,
                                phone: '1098',
                                color: Color(0xFF43A047),
                                icon: Icons.child_care,
                                borderColor: Color(0xFF43A047),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Helpline',
                                style: TextStyle(
                                  color: Color(0xFF43A047),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}

class _EmergencyContactCard extends StatelessWidget {
  final String title;
  final String phone;
  final Color color;
  final IconData icon;
  final Color borderColor;

  const _EmergencyContactCard({
    required this.title,
    required this.phone,
    required this.color,
    required this.icon,
    required this.borderColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: 3.5,
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: color.withOpacity(0.22),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.20),
                width: 1.2,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            phone,
            style: TextStyle(
              color: color.withOpacity(0.98),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: null, // keep as is, or add call logic
              icon: const Icon(Icons.call, size: 20, color: Colors.white),
              label: Text(
                AppLocalizations.of(context)!.call,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: color.withOpacity(0.95),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
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
