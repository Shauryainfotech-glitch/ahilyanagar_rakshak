import 'package:flutter/material.dart';
// Import real form widgets from the forms directory
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
  runApp(const PoliceServicesApp());
}

class PoliceServicesApp extends StatelessWidget {
  const PoliceServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Police Services',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      home: const ServicesHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ServicesHomePage extends StatelessWidget {
  const ServicesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ServicesListView();
  }
}

class ServicesListView extends StatelessWidget {
  const ServicesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PoliceService> services = [
      PoliceService(
        name: 'Complaint Registration',
        icon: Icons.report_problem,
        formBuilder: () => ComplaintRegistrationForm(),
      ),
      PoliceService(
        name: 'Mike Sanction Registration',
        icon: Icons.verified_user,
        formBuilder: () => MikeSanctionRegistrationForm(),
      ),
      PoliceService(
        name: 'FIR Download',
        icon: Icons.download,
        formBuilder: () => FIRDownloadForm(),
      ),
      PoliceService(
        name: 'Accident GD',
        icon: Icons.car_crash,
        formBuilder: () => AccidentGDForm(),
      ),
      PoliceService(
        name: 'Lost Property',
        icon: Icons.search_off,
        formBuilder: () => LostPropertyForm(),
      ),
      PoliceService(
        name: 'Payment History',
        icon: Icons.payment,
        formBuilder: () => PaymentHistoryForm(),
      ),
      PoliceService(
        name: 'Event Performance',
        icon: Icons.event,
        formBuilder: () => EventPerformanceForm(),
      ),
      PoliceService(
        name: 'Grievance Redressal',
        icon: Icons.gavel,
        formBuilder: () => GrievanceRedressalForm(),
      ),
      PoliceService(
        name: 'Arrest Search',
        icon: Icons.search,
        formBuilder: () => ArrestSearchForm(),
      ),
      PoliceService(
        name: 'Feedback',
        icon: Icons.feedback,
        formBuilder: () => FeedbackForm(),
      ),
      PoliceService(
        name: 'Blood Donor',
        icon: Icons.bloodtype,
        formBuilder: () => BloodDonorForm(),
      ),
      PoliceService(
        name: 'Blood Request',
        icon: Icons.bloodtype,
        formBuilder: () => BloodRequestForm(),
      ),
      PoliceService(
        name: 'Locked House Information',
        icon: Icons.lock,
        formBuilder: () => LockedHouseInfoForm(),
      ),
      PoliceService(
        name: 'Senior Citizen Information',
        icon: Icons.elderly,
        formBuilder: () => SeniorCitizenInfoForm(),
      ),
      PoliceService(
        name: 'Single Women Living Alone',
        icon: Icons.female,
        formBuilder: () => SingleWomenLivingAloneForm(),
      ),
      PoliceService(
        name: 'Report Abduction',
        icon: Icons.report,
        formBuilder: () => ReportAbductionForm(),
      ),
      PoliceService(
        name: 'Report Cyber Fraud',
        icon: Icons.security,
        formBuilder: () => ReportCyberFraudForm(),
      ),
      PoliceService(
        name: 'Share Information',
        icon: Icons.share,
        formBuilder: () => ShareInformationForm(),
      ),
      PoliceService(
        name: 'Appointment with SHO',
        icon: Icons.person,
        formBuilder: () => AppointmentWithSHOForm(),
      ),
      PoliceService(
        name: 'Search Police Station',
        icon: Icons.search,
        formBuilder: () => SearchPoliceStationForm(),
      ),
      PoliceService(
        name: 'Cyber Security Information',
        icon: Icons.security,
        formBuilder: () => CyberSecurityInfoForm(),
      ),
      PoliceService(
        name: 'Tourist Guide',
        icon: Icons.tour,
        formBuilder: () => TouristGuideForm(),
      ),
      PoliceService(
        name: 'User Manual',
        icon: Icons.menu_book,
        formBuilder: () => UserManualForm(),
      ),
      PoliceService(
        name: 'Awareness Classes',
        icon: Icons.school,
        formBuilder: () => AwarenessClassesForm(),
      ),
      PoliceService(
        name: 'Rate Police Station',
        icon: Icons.star,
        formBuilder: () => RatePoliceStationForm(),
      ),
      PoliceService(
        name: 'Rate Application',
        icon: Icons.star_rate,
        formBuilder: () => RateApplicationForm(),
      ),
      PoliceService(
        name: 'Social Media of Police',
        icon: Icons.public,
        formBuilder: () => SocialMediaOfPoliceForm(),
      ),
      PoliceService(
        name: 'Maharashtra Government',
        icon: Icons.account_balance,
        formBuilder: () => MaharashtraGovernmentForm(),
      ),
      PoliceService(
        name: 'Ahilyanagar Police',
        icon: Icons.local_police,
        formBuilder: () => AhilyanagarPoliceForm(),
      ),
      PoliceService(
        name: 'Cyber Done',
        icon: Icons.done,
        formBuilder: () => CyberDoneForm(),
      ),
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceCard(service: service);
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final PoliceService service;

  const ServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(service.icon, size: 32),
        title: Text(
          service.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.2,
            shadows: [
              Shadow(
                color: Colors.white,
                offset: Offset(0.5, 0.5),
                blurRadius: 1,
              ),
            ],
          ),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
              print('ACCESS button pressed for: \'${service.name}\'');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => service.formBuilder()),
            );
          },
          child: const Text('ACCESS'),
        ),
      ),
    );
  }
}

class PoliceService {
  final String name;
  final IconData icon;
  final Widget Function() formBuilder;

  const PoliceService({
    required this.name,
    required this.icon,
    required this.formBuilder,
  });
}
