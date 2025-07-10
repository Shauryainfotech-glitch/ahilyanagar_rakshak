import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/language_provider.dart';
import 'l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  // Profile Data
  String name = 'John Doe';
  String email = 'john.doe@example.com';
  String phone = '+91 98765 43210';
  String address = 'Ahilyanagar, Maharashtra, India';
  String gender = 'Male';
  String aadhaarNumber = '1234 5678 9012';
  String emergencyContact = '+91 98765 43211';
  DateTime? dob;
  final TextEditingController _dobController = TextEditingController();
  bool isEditing = false;

  // Settings
  bool notificationsEnabled = true;
  bool locationEnabled = true;
  bool biometricEnabled = false;
  String language = 'English';
  String theme = 'Dark';
  bool autoSync = true;
  bool emergencyAlerts = true;

  // Stats
  int totalReports = 12;
  int emergencyCalls = 3;
  int safetyTips = 8;

  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    
    dob = DateTime(1990, 5, 15);
    _dobController.text = "${dob!.year}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}";
    
    _animationController.forward();
    _loadBiometricPreference();
  }

  Future<void> _loadBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      biometricEnabled = prefs.getBool('biometricEnabled') ?? false;
    });
  }

  Future<void> _saveBiometricPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricEnabled', value);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF64B5F6),
              onPrimary: Colors.white,
              surface: Color(0xFF2A2F45),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked;
        _dobController.text = "${dob!.year}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
    if (isEditing) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isEditing = false;
      });
      _showSuccessSnackBar(AppLocalizations.of(context).profileUpdated);
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.logout_rounded, color: Color(0xFFE91E63), size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context).logout,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          AppLocalizations.of(context).logoutConfirm,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context).cancel,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSuccessSnackBar(AppLocalizations.of(context).loggedOut);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(AppLocalizations.of(context).logout),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.availableLanguages.firstWhere(
      (lang) => lang['code'] == languageProvider.currentLocale.languageCode,
      orElse: () => {'name': 'English'},
    )['name'] ?? 'English';

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainGradient = isDark
        ? [Color(0xFF0A0E21), Color(0xFF1A1F35)]
        : [Color(0xFFF5F5F5), Color(0xFFE0E0E0)];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: mainGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120), // Add bottom padding for navbar
            child: Column(
              children: [
                // Enhanced Header with Stats
                _buildEnhancedHeader(),
                
                // Tab Bar with better design
                _buildTabBar(),
                
                // Tab Content - Now scrollable
                _buildTabContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedHeader() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerGradient = isDark
        ? [Color(0xFF1A1F35), Color(0xFF2A2F45), Color(0xFF1A1F35)]
        : [Color(0xFFF5F5F5), Color(0xFFE0E0E0), Color(0xFFF5F5F5)];
    return Container(
      padding: EdgeInsets.all(isDesktop ? 32 : isTablet ? 24 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: headerGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar and Info
          if (isDesktop)
            _buildDesktopHeader()
          else
            _buildMobileHeader(),
          
          SizedBox(height: isDesktop ? 32 : isTablet ? 24 : 20),
          
          // Stats Cards
          if (isDesktop)
            _buildDesktopStats()
          else
            _buildMobileStats(),
        ],
      ),
    );
  }

  Widget _buildMobileHeader() {
    return Row(
      children: [
        // Animated Avatar
        Hero(
          tag: 'profile_avatar',
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF64B5F6).withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Theme.of(context).cardColor,
              child: Text(
                name.split(' ').map((e) => e[0]).join('').toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ahilyanagar Police App User',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Verified User',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Edit Button
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3F51B5).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              isEditing ? Icons.save_rounded : Icons.edit_rounded,
              color: Theme.of(context).colorScheme.onSurface,
              size: 20,
            ),
            onPressed: isEditing ? _saveProfile : _toggleEdit,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
      children: [
        // Animated Avatar
        Hero(
          tag: 'profile_avatar',
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF64B5F6), Color(0xFF3F51B5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF64B5F6).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).cardColor,
              child: Text(
                name.split(' ').map((e) => e[0]).join('').toUpperCase(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ahilyanagar Police App User',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Verified User',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Edit Button
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3F51B5).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              isEditing ? Icons.save_rounded : Icons.edit_rounded,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
            onPressed: isEditing ? _saveProfile : _toggleEdit,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Reports', totalReports, Icons.report_rounded, Theme.of(context).colorScheme.primary)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Emergency', emergencyCalls, Icons.emergency_rounded, Theme.of(context).colorScheme.error)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Safety Tips', safetyTips, Icons.security_rounded, Theme.of(context).colorScheme.primary)),
      ],
    );
  }

  Widget _buildDesktopStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Reports', totalReports, Icons.report_rounded, Theme.of(context).colorScheme.primary)),
        const SizedBox(width: 20),
        Expanded(child: _buildStatCard('Emergency', emergencyCalls, Icons.emergency_rounded, Theme.of(context).colorScheme.error)),
        const SizedBox(width: 20),
        Expanded(child: _buildStatCard('Safety Tips', safetyTips, Icons.security_rounded, Theme.of(context).colorScheme.primary)),
      ],
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 900;
    
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop ? 12 : isTablet ? 10 : 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
            ),
            child: Icon(icon, color: color, size: isDesktop ? 28 : isTablet ? 24 : 20),
          ),
          SizedBox(height: isDesktop ? 12 : isTablet ? 10 : 8),
          Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontSize: isDesktop ? 28 : isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: isDesktop ? 16 : isTablet ? 14 : 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 900;

    // Remove Row and return Container directly
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: isDesktop ? 24 : isTablet ? 20 : 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TabBar(
        isScrollable: true,
        controller: _tabController,
        onTap: (index) {
          setState(() {});
        },
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F51B5).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: Theme.of(context).colorScheme.onSurface,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: isDesktop ? 16 : isTablet ? 15 : 13,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: isDesktop ? 16 : isTablet ? 15 : 13,
        ),
        tabs: [
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : isTablet ? 18 : 12),
              child: Text(
                AppLocalizations.of(context)!.personal,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : isTablet ? 18 : 12),
              child: Text(
                AppLocalizations.of(context)!.settings,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : isTablet ? 18 : 12),
              child: Text(
                AppLocalizations.of(context)!.security,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _getCurrentTabContent(),
    );
  }

  Widget _getCurrentTabContent() {
    switch (_tabController.index) {
      case 0:
        return _buildProfileTab();
      case 1:
        return _buildSettingsTab();
      case 2:
        return _buildSecurityTab();
      default:
        return _buildProfileTab();
    }
  }

  Widget _buildProfileTab() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (isEditing) _buildEditProfileForm() else _buildProfileInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A2F45), Color(0xFF1E2337)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildFormField('Full Name', name, Icons.person_rounded, (val) => name = val ?? ''),
            const SizedBox(height: 16),
            _buildFormField('Email Address', email, Icons.email_rounded, (val) => email = val ?? ''),
            const SizedBox(height: 16),
            _buildFormField('Phone Number', phone, Icons.phone_rounded, (val) => phone = val ?? ''),
            const SizedBox(height: 16),
            _buildFormField('Address', address, Icons.location_on_rounded, (val) => address = val ?? '', maxLines: 2),
            const SizedBox(height: 16),
            _buildDateField(),
            const SizedBox(height: 16),
            _buildDropdownField(),
            const SizedBox(height: 16),
            _buildFormField('Aadhaar Number', aadhaarNumber, Icons.credit_card_rounded, (val) => aadhaarNumber = val ?? ''),
            const SizedBox(height: 16),
            _buildFormField('Emergency Contact', emergencyContact, Icons.emergency_rounded, (val) => emergencyContact = val ?? ''),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4CAF50).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _toggleEdit,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String initialValue, IconData icon, Function(String?) onSaved, {int maxLines = 1}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
      ),
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      maxLines: maxLines,
      onSaved: onSaved,
      validator: (val) {
        if (val == null || val.isEmpty) return 'This field is required';
        if (label == 'Email Address' && !val.contains('@')) return 'Enter valid email';
        return null;
      },
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dobController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.calendar_today_rounded, color: Color(0xFF64B5F6), size: 20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
      ),
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      onTap: () => _selectDate(context),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: gender.isNotEmpty ? gender : null,
      items: ['Male', 'Female', 'Other']
          .map((g) => DropdownMenuItem(value: g, child: Text(g, style: TextStyle(color: Theme.of(context).colorScheme.onSurface))))
          .toList(),
      onChanged: (val) => setState(() => gender = val ?? ''),
      decoration: InputDecoration(
        labelText: 'Gender',
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.wc_rounded, color: Color(0xFF64B5F6), size: 20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
      ),
      dropdownColor: Theme.of(context).cardColor,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        _buildInfoSection('Personal Information', [
          _buildInfoTile(Icons.person_rounded, 'Full Name', name, Theme.of(context).colorScheme.primary),
          _buildInfoTile(Icons.email_rounded, 'Email Address', email, Theme.of(context).colorScheme.primary),
          _buildInfoTile(Icons.phone_rounded, 'Phone Number', phone, Theme.of(context).colorScheme.primary),
          _buildInfoTile(Icons.location_on_rounded, 'Address', address, Theme.of(context).colorScheme.secondary),
          _buildInfoTile(Icons.calendar_today_rounded, 'Date of Birth', 
              dob != null ? "${dob!.day}/${dob!.month}/${dob!.year}" : '-', Theme.of(context).colorScheme.secondary),
          _buildInfoTile(Icons.wc_rounded, 'Gender', gender, Theme.of(context).colorScheme.error),
        ]),
        const SizedBox(height: 16),
        _buildInfoSection('Identity Information', [
          _buildInfoTile(Icons.credit_card_rounded, 'Aadhaar Number', aadhaarNumber, Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          _buildInfoTile(Icons.emergency_rounded, 'Emergency Contact', emergencyContact, Theme.of(context).colorScheme.error),
        ]),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFF64B5F6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3F51B5).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _toggleEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_rounded, color: Theme.of(context).colorScheme.onSurface),
                const SizedBox(width: 8),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sectionGradient = isDark
        ? [Color(0xFF2A2F45), Color(0xFF1E2337)]
        : [Color(0xFFFFFFFF), Color(0xFFF5F5F5)];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: sectionGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.info_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettingsSection(AppLocalizations.of(context)!.notifications, [
                _buildSwitchTile(
                  Icons.notifications_rounded,
                  AppLocalizations.of(context)!.notifications,
                  'Receive app notifications',
                  notificationsEnabled,
                  (value) => setState(() => notificationsEnabled = value),
                ),
                _buildSwitchTile(
                  Icons.emergency_rounded,
                  AppLocalizations.of(context)!.emergencyAlerts,
                  'Get emergency notifications',
                  emergencyAlerts,
                  (value) => setState(() => emergencyAlerts = value),
                ),
              ]),
              const SizedBox(height: 16),
              _buildSettingsSection('Location & Privacy', [
                _buildSwitchTile(
                  Icons.location_on_rounded,
                  AppLocalizations.of(context)!.locationServices,
                  'Allow location access',
                  locationEnabled,
                  (value) => setState(() => locationEnabled = value),
                  ),
                _buildSwitchTile(
                  Icons.sync_rounded,
                  AppLocalizations.of(context)!.autoSync,
                  'Automatically sync data',
                  autoSync,
                  (value) => setState(() => autoSync = value),
                ),
              ]),
              const SizedBox(height: 16),
              // Use Consumer to listen for theme changes
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  final languageProvider = Provider.of<LanguageProvider>(context);
                  final currentLanguage = languageProvider.availableLanguages.firstWhere(
                    (lang) => lang['code'] == languageProvider.currentLocale.languageCode,
                    orElse: () => {'name': 'English'},
                  )['name'] ?? 'English';
                  return _buildSettingsSection('App Preferences', [
                    _buildLanguageDropdown(languageProvider, currentLanguage),
                    _buildThemeDropdown(themeProvider),
                  ]);
                },
              ),
              const SizedBox(height: 16),
              _buildSettingsSection('Data & Storage', [
                _buildActionTile(
                  Icons.download_rounded,
                  'Export Data',
                  'Download your data',
                  () => _showSuccessSnackBar('Data export started'),
                ),
                _buildActionTile(
                  Icons.delete_rounded,
                  'Clear Cache',
                  'Free up storage space',
                  () => _showSuccessSnackBar('Cache cleared'),
                ),
              ]),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityTab() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildSettingsSection('Authentication', [
                _buildSwitchTile(
                  Icons.fingerprint_rounded,
                  'Biometric Login',
                  'Use fingerprint or face ID',
                  biometricEnabled,
                  _handleBiometricSwitch,
                ),
                _buildActionTile(
                  Icons.lock_rounded,
                  'Change Password',
                  'Update your password',
                  () => _showSuccessSnackBar('Password change feature'),
                ),
                _buildActionTile(
                  Icons.security_rounded,
                  'Two-Factor Authentication',
                  'Add extra security layer',
                  () => _showSuccessSnackBar('2FA setup feature'),
                ),
              ]),
              const SizedBox(height: 16),
              _buildSettingsSection('Privacy', [
                _buildActionTile(
                  Icons.visibility_rounded,
                  'Privacy Settings',
                  'Manage your privacy',
                  () => _showSuccessSnackBar('Privacy settings'),
                ),
                _buildActionTile(
                  Icons.block_rounded,
                  'Blocked Users',
                  'Manage blocked contacts',
                  () => _showSuccessSnackBar('Blocked users list'),
                ),
              ]),
              const SizedBox(height: 16),
              _buildSettingsSection('Account', [
                _buildActionTile(
                  Icons.delete_forever_rounded,
                  'Delete Account',
                  'Permanently delete account',
                  () => _showDeleteAccountDialog(),
                  isDestructive: true,
                ),
                _buildActionTile(
                  Icons.logout_rounded,
                  'Logout',
                  'Sign out of your account',
                  _logout,
                  isDestructive: true,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sectionGradient = isDark
        ? [Color(0xFF2A2F45), Color(0xFF1E2337)]
        : [Color(0xFFFFFFFF), Color(0xFFF5F5F5)];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: sectionGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.settings_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
            activeTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(LanguageProvider languageProvider, String currentLanguage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
      ),
      child: InkWell(
        onTap: () => _showLanguageDialog(context, languageProvider),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.language_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    currentLanguage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF64B5F6)),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeDropdown(ThemeProvider themeProvider) {
    String currentTheme = themeProvider.getCurrentThemeName();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.palette_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currentTheme,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: currentTheme,
            onChanged: (String? newValue) async {
              if (newValue != null) {
                switch (newValue) {
                  case 'Dark':
                    await themeProvider.setTheme(ThemeMode.dark);
                    break;
                  case 'Light':
                    await themeProvider.setTheme(ThemeMode.light);
                    break;
                  case 'System':
                    await themeProvider.setTheme(ThemeMode.system);
                    break;
                }
                _showSuccessSnackBar('Theme changed to $newValue');
              }
            },
            dropdownColor: Theme.of(context).cardColor,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            icon: Icon(Icons.arrow_drop_down_rounded, color: Theme.of(context).colorScheme.primary),
            underline: Container(), // Remove the default underline
            items: ['Dark', 'Light', 'System'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          AppLocalizations.of(context)!.selectLanguage,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languageProvider.availableLanguages.map((lang) {
            return ListTile(
              title: Text(
                lang['name']!,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
              trailing: languageProvider.currentLocale.languageCode == lang['code']
                  ? Icon(Icons.check_rounded, color: Theme.of(context).colorScheme.primary)
                  : null,
              onTap: () {
                languageProvider.changeLanguage(lang['code']!);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.language_rounded, color: Theme.of(context).colorScheme.onSurface),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${AppLocalizations.of(context)!.languageChangedTo} ${lang['name']}',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface),
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
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(IconData icon, String title, String value, List<String> options, Function(String?) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            dropdownColor: Theme.of(context).cardColor,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF64B5F6)),
            items: options.map((option) => DropdownMenuItem(
              value: option,
              child: Text(option),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle, VoidCallback onTap, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDestructive 
                  ? Theme.of(context).colorScheme.error.withOpacity(0.05)
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.02),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDestructive 
                    ? Theme.of(context).colorScheme.error.withOpacity(0.2)
                    : Theme.of(context).dividerColor.withOpacity(0.05),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDestructive 
                        ? Theme.of(context).colorScheme.error.withOpacity(0.1)
                        : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon, 
                    color: isDestructive ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary, 
                    size: 20
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isDestructive ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.delete_forever_rounded, color: Theme.of(context).colorScheme.error, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Delete Account',
              style: TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          'This action cannot be undone. All your data will be permanently deleted.',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSuccessSnackBar(AppLocalizations.of(context)!.accountDeletionFeature);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleBiometricSwitch(bool value) async {
    if (value) {
      bool canCheck = await auth.canCheckBiometrics;
      bool isAvailable = await auth.isDeviceSupported();
      if (canCheck && isAvailable) {
        try {
          bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Enable biometric login',
            options: const AuthenticationOptions(biometricOnly: true),
          );
          if (didAuthenticate) {
            setState(() => biometricEnabled = true);
            await _saveBiometricPreference(true);
            _showSuccessSnackBar('Biometric login enabled');
          } else {
            _showSuccessSnackBar('Biometric authentication failed');
          }
        } catch (e) {
          _showSuccessSnackBar('Biometric error: ' + e.toString());
        }
      } else {
        _showSuccessSnackBar('Biometric not available on this device');
      }
    } else {
      setState(() => biometricEnabled = false);
      await _saveBiometricPreference(false);
      _showSuccessSnackBar('Biometric login disabled');
    }
  }
}
