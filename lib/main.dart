import 'package:demo_app/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chatbot_screen.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'sos_button.dart';
import 'l10n/language_provider.dart';
import 'l10n/app_localizations.dart';
import 'theme_provider.dart';

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    // Use Consumer to listen for theme changes and rebuild MaterialApp
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        print('[MaterialApp] Rebuilding with theme: ${themeProvider.themeMode}');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ahilyanagar Police',
          locale: languageProvider.currentLocale,
          supportedLocales: LanguageProvider.supportedLocales,
          localizationsDelegates: LanguageProvider.localizationsDelegates,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F5F5),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xFF3F51B5),
              unselectedItemColor: Colors.black54,
              type: BottomNavigationBarType.fixed,
              elevation: 20,
            ),
            cardColor: Colors.white,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF3F51B5),
              foregroundColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F51B5),
                foregroundColor: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
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
                borderSide: const BorderSide(color: Color(0xFF3F51B5), width: 2),
              ),
              labelStyle: const TextStyle(color: Colors.black87),
              hintStyle: const TextStyle(color: Colors.black54),
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3F51B5),
              secondary: Color(0xFF64B5F6),
              surface: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Colors.black,
              error: Color(0xFFE57373),
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 32,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
              headlineMedium: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
                letterSpacing: 0.3,
              ),
              titleLarge: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 0.2,
              ),
              bodyLarge: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
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
          themeMode: themeProvider.themeMode,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
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
                    selectedItemColor: Theme.of(context).colorScheme.primary,
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
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor!.withAlpha((0.4 * 255).toInt()),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).appBarTheme.backgroundColor!,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            Theme.of(context).appBarTheme.backgroundColor!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary,
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
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headlineLarge?.color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const IconButton(
            icon: Icon(Icons.search_rounded, color: Colors.white, size: 28),
            onPressed: null,
          ),
          Stack(
            children: [
              const IconButton(
                icon: Icon(Icons.notifications_rounded, color: Colors.white, size: 28),
                onPressed: null,
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.error.withOpacity(0.9), Theme.of(context).colorScheme.error.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.error,
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
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.headlineMedium?.color,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.missingPersonAlertDescription,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
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
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              // Single row layout for quick services
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ServiceIcon(
                    icon: Icons.report_problem_rounded,
                    label: AppLocalizations.of(context)!.fileComplaint,
                    color: Color(0xFFFF9800),
                  ),
                  _ServiceIcon(
                    icon: Icons.security_rounded,
                    label: AppLocalizations.of(context)!.safetyTips,
                    color: Color(0xFF4CAF50),
                  ),
                  _ServiceIcon(
                    icon: Icons.bloodtype_rounded,
                    label: AppLocalizations.of(context)!.bloodRequest,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  _ServiceIcon(
                    icon: Icons.event_rounded,
                    label: AppLocalizations.of(context)!.appointments,
                    color: Theme.of(context).colorScheme.secondary,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary.withOpacity(0.9), Theme.of(context).colorScheme.primary.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
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
                  const Icon(Icons.emergency_rounded, color: Color(0xFFFF9800), size: 28),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.emergencyContacts,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.headlineMedium?.color,
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
                      color: Color(0xFF2196F3),
                    ),
                    const SizedBox(width: 16),
                    _ContactIcon(
                      icon: Icons.local_hospital_rounded,
                      label: AppLocalizations.of(context)!.ambulance,
                      phone: '108',
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 16),
                    _ContactIcon(
                      icon: Icons.local_fire_department_rounded,
                      label: AppLocalizations.of(context)!.fire,
                      phone: '101',
                      color: Color(0xFFFF9800),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
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
                  Icon(Icons.newspaper_rounded, color: Theme.of(context).colorScheme.primary, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.dailyUpdates,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
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
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ServiceIcon({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
    return Column(
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
          child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          phone,
          style: TextStyle(
            color: Color(0xFFFF9800),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
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
                        gradient: LinearGradient(
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withAlpha(204)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary,
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
                              color: Theme.of(context).textTheme.headlineMedium?.color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.accessAllServices,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
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
        color: Theme.of(context).colorScheme.primary,
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
        color: Theme.of(context).colorScheme.error,
        title: AppLocalizations.of(context)!.polBloodService,
        subtitle: AppLocalizations.of(context)!.bloodDonationRequests,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.bloodDonor, icon: Icons.favorite_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.bloodRequest, icon: Icons.bloodtype_rounded),
        ],
      ),
      SectionData(
        icon: Icons.security_rounded,
        color: Color(0xFF4CAF50),
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
        color: Color(0xFFFF9800),
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
        color: Theme.of(context).colorScheme.secondary,
        title: AppLocalizations.of(context)!.appointmentSearch,
        subtitle: AppLocalizations.of(context)!.scheduleFindServices,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.appointmentWithSho, icon: Icons.calendar_today_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.searchPoliceStation, icon: Icons.location_city_rounded),
        ],
      ),
      SectionData(
        icon: Icons.tips_and_updates_rounded,
        color: Color(0xFF2196F3),
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
        color: Color(0xFFFF9800),
        title: AppLocalizations.of(context)!.rate,
        subtitle: AppLocalizations.of(context)!.rateOurServices,
        children: [
          ServiceForm(title: AppLocalizations.of(context)!.ratePoliceStation, icon: Icons.location_city_rounded),
          ServiceForm(title: AppLocalizations.of(context)!.rateApplication, icon: Icons.rate_review_rounded),
        ],
      ),
      SectionData(
        icon: Icons.link_rounded,
        color: Theme.of(context).colorScheme.onSurface,
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
        color: Theme.of(context).colorScheme.primary,
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), // reduced vertical padding
        child: Column(
          mainAxisSize: MainAxisSize.min, // let column size to its content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(section.icon, color: Theme.of(context).colorScheme.onPrimary, size: 36),
            const SizedBox(height: 12),
            Text(
              section.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onPrimary),
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Text(
                    section.subtitle,
                    style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
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
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withAlpha(204)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.primary,
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
                                  color: Theme.of(context).textTheme.headlineMedium?.color,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.getInTouch,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                                              child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.searchContacts,
                          prefixIcon: Icon(Icons.search_rounded, color: Theme.of(context).colorScheme.primary),
                          filled: true,
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                          ),
                          hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7)),
                        ),
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Enhanced Tab Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        tabs: _tabs.map((t) => Tab(
                          child: Text(
                            t,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        )).toList(),
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        indicatorWeight: 3,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Theme.of(context).colorScheme.onPrimary,
                        unselectedLabelColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
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
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withAlpha(204)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.person_rounded, color: Colors.white, size: 24),
          ),
          title: Text(
            filtered[i]['name']!,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            filtered[i]['phone']!,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14,
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF4CAF50).withAlpha(204)],
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
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
                colors: [Theme.of(context).colorScheme.error, Theme.of(context).colorScheme.error.withAlpha(204)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.error,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.phone_rounded, color: Colors.white, size: 24),
          ),
          title: Text(
            filtered[i]['name']!,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            filtered[i]['phone']!,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14,
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF4CAF50).withAlpha(204)],
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.error.withOpacity(0.9), Theme.of(context).colorScheme.error.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.error,
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
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
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
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.sendEmergencyAlert,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
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
                          color: Theme.of(context).textTheme.bodyLarge?.color,
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
                color: Color(0xFFFF9800),
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
              color: Theme.of(context).colorScheme.error,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
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
          child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          phone,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
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
                color: Theme.of(context).textTheme.bodyLarge?.color,
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
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
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
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: (Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black).withAlpha((0.1 * 255).toInt())),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withAlpha(204)],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
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
                color: Theme.of(context).textTheme.bodyLarge?.color,
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

