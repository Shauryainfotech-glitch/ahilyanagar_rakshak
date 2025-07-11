import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/language_provider.dart';
import 'l10n/app_localizations.dart';
import 'services/role_service.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with TickerProviderStateMixin {
  final RoleService _roleService = RoleService();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String _userRole = 'citizen';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _loadUserRole();
    _animationController.forward();
  }

  Future<void> _loadUserRole() async {
    final role = await _roleService.getCurrentUserRole();
    setState(() {
      _userRole = role ?? 'citizen';
      _isLoading = false;
    });
    
    _listenToRoleChanges();
  }

  void _listenToRoleChanges() {
    _roleService.listenToRoleChanges().listen((newRole) {
      if (newRole != null && mounted) {
        setState(() {
          _userRole = newRole;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getCitizenServices() {
    return [
      {
        'title': 'Complaint Registration',
        'icon': Icons.report_problem_rounded,
        'route': '/complaint_registration',
        'color': Colors.red,
        'description': 'Register complaints and grievances',
      },
      {
        'title': 'FIR Download',
        'icon': Icons.download_rounded,
        'route': '/fir_download',
        'color': Colors.blue,
        'description': 'Download FIR copies',
      },
      {
        'title': 'Accident GD',
        'icon': Icons.car_crash_rounded,
        'route': '/accident_gd',
        'color': Colors.orange,
        'description': 'Report accidents and incidents',
      },
      {
        'title': 'Lost Property',
        'icon': Icons.search_rounded,
        'route': '/lost_property',
        'color': Colors.purple,
        'description': 'Report lost or found items',
      },
      {
        'title': 'Feedback',
        'icon': Icons.feedback_rounded,
        'route': '/feedback',
        'color': Colors.green,
        'description': 'Submit feedback and suggestions',
      },
      {
        'title': 'Blood Donor',
        'icon': Icons.bloodtype_rounded,
        'route': '/blood_donor',
        'color': Colors.red,
        'description': 'Register as blood donor',
      },
      {
        'title': 'Blood Request',
        'icon': Icons.medical_services_rounded,
        'route': '/blood_request',
        'color': Colors.pink,
        'description': 'Request blood donation',
      },
      {
        'title': 'Track My Trip',
        'icon': Icons.location_on_rounded,
        'route': '/track_my_trip',
        'color': Colors.indigo,
        'description': 'Track your journey safely',
      },
      {
        'title': 'Senior Citizen Info',
        'icon': Icons.elderly_rounded,
        'route': '/senior_citizen_info',
        'color': Colors.amber,
        'description': 'Information for senior citizens',
      },
      {
        'title': 'Single Women Living Alone',
        'icon': Icons.woman_rounded,
        'route': '/single_women_living_alone',
        'color': Colors.purple,
        'description': 'Safety information for women',
      },
      {
        'title': 'Report Abduction',
        'icon': Icons.person_off_rounded,
        'route': '/report_abduction',
        'color': Colors.red,
        'description': 'Report missing persons',
      },
      {
        'title': 'Report Cyber Fraud',
        'icon': Icons.security_rounded,
        'route': '/report_cyber_fraud',
        'color': Colors.cyan,
        'description': 'Report cyber crimes',
      },
      {
        'title': 'Share Information',
        'icon': Icons.share_rounded,
        'route': '/share_information',
        'color': Colors.teal,
        'description': 'Share important information',
      },
      {
        'title': 'Appointment with SHO',
        'icon': Icons.calendar_today_rounded,
        'route': '/appointment_with_sho',
        'color': Colors.blue,
        'description': 'Book appointment with SHO',
      },
      {
        'title': 'Search Police Station',
        'icon': Icons.location_city_rounded,
        'route': '/search_police_station',
        'color': Colors.grey,
        'description': 'Find nearby police stations',
      },
      {
        'title': 'Cyber Security Info',
        'icon': Icons.computer_rounded,
        'route': '/cyber_security_info',
        'color': Colors.indigo,
        'description': 'Cyber security guidelines',
      },
      {
        'title': 'Tourist Guide',
        'icon': Icons.tour_rounded,
        'route': '/tourist_guide',
        'color': Colors.orange,
        'description': 'Tourist information and safety',
      },
      {
        'title': 'User Manual',
        'icon': Icons.help_rounded,
        'route': '/user_manual',
        'color': Colors.green,
        'description': 'App usage guide',
      },
      {
        'title': 'Awareness Classes',
        'icon': Icons.school_rounded,
        'route': '/awareness_classes',
        'color': Colors.blue,
        'description': 'Safety awareness programs',
      },
      {
        'title': 'Rate Police Station',
        'icon': Icons.star_rounded,
        'route': '/rate_police_station',
        'color': Colors.amber,
        'description': 'Rate police station services',
      },
      {
        'title': 'Rate Application',
        'icon': Icons.thumb_up_rounded,
        'route': '/rate_application',
        'color': Colors.green,
        'description': 'Rate this application',
      },
      {
        'title': 'Social Media of Police',
        'icon': Icons.share_rounded,
        'route': '/social_media_of_police',
        'color': Colors.blue,
        'description': 'Police social media handles',
      },
      {
        'title': 'Maharashtra Government',
        'icon': Icons.account_balance_rounded,
        'route': '/maharashtra_government',
        'color': Colors.orange,
        'description': 'Government services',
      },
      {
        'title': 'Ahilyanagar Police',
        'icon': Icons.local_police_rounded,
        'route': '/ahilyanagar_police',
        'color': Colors.red,
        'description': 'Local police information',
      },
      {
        'title': 'Cyber Done',
        'icon': Icons.check_circle_rounded,
        'route': '/cyber_done',
        'color': Colors.green,
        'description': 'Completed cyber cases',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading services...'),
            ],
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final services = _getServicesForRole();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.scaffoldBackgroundColor,
                    theme.cardColor,
                    theme.scaffoldBackgroundColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                                      BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
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
                                                          colors: [
                                _getRoleColor(),
                                _getRoleColor().withOpacity(0.7),
                              ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                                                      boxShadow: [
                              BoxShadow(
                                color: _getRoleColor().withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                        ),
                        child: Icon(
                          Icons.apps_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Services',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Available for ${_getRoleDisplayName()}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: _getRoleColor(),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                                          padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _getRoleColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getRoleColor().withOpacity(0.3),
                        ),
                      ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: _getRoleColor(),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'You have access to ${services.length} services as a ${_getRoleDisplayName()}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: _getRoleColor(),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Services Grid
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
                      return _buildServiceCard(service, theme, isDark);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    Map<String, dynamic> service,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
                  gradient: LinearGradient(
            colors: [
              service['color'].withOpacity(0.1),
              service['color'].withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
                  borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: service['color'].withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: service['color'].withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.pushNamed(context, service['route']),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                                              colors: [
                          service['color'],
                          service['color'].withOpacity(0.7),
                        ],
                    ),
                    shape: BoxShape.circle,
                                          boxShadow: [
                        BoxShadow(
                          color: service['color'].withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                  ),
                  child: Icon(
                    service['icon'],
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  service['title'],
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: service['color'],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                                      service['description'],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRoleDisplayName() {
    return RoleService.ROLE_DISPLAY_NAMES[_userRole] ?? 'Unknown';
  }

  Color _getRoleColor() {
    switch (_userRole) {
      case 'citizen':
        return Colors.blue;
      case 'police':
        return Colors.red;
      case 'police_mitr':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _getServicesForRole() {
    switch (_userRole) {
      case 'citizen':
        return _getCitizenServices();
      case 'police':
        return [
          // All citizen services plus police-specific services
          ..._getCitizenServices().where((service) => service['title'] != 'Rate Police Station'),
          {
            'title': 'Mike Sanction Registration',
            'icon': Icons.mic_rounded,
            'route': '/mike_sanction_registration',
            'color': Colors.purple,
            'description': 'Register mike sanctions',
          },
          {
            'title': 'Payment History',
            'icon': Icons.payment_rounded,
            'route': '/payment_history',
            'color': Colors.green,
            'description': 'View payment history',
          },
          {
            'title': 'Event Performance',
            'icon': Icons.event_rounded,
            'route': '/event_performance',
            'color': Colors.orange,
            'description': 'Track event performance',
          },
          {
            'title': 'Grievance Redressal',
            'icon': Icons.gavel_rounded,
            'route': '/grievance_redressal',
            'color': Colors.red,
            'description': 'Handle grievances',
          },
          {
            'title': 'Arrest Search',
            'icon': Icons.search_rounded,
            'route': '/arrest_search',
            'color': Colors.indigo,
            'description': 'Search arrest records',
          },
          {
            'title': 'Locked House Info',
            'icon': Icons.home_rounded,
            'route': '/locked_house_info',
            'color': Colors.brown,
            'description': 'Information about locked houses',
          },
        ];
      case 'police_mitr':
        return _getCitizenServices(); // Same as citizen for now
      default:
        return _getCitizenServices();
    }
  }
}
