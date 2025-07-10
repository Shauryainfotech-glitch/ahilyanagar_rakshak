import 'package:flutter/material.dart';
import 'app_localizations_english.dart';
import 'app_localizations_hindi.dart';
import 'app_localizations_marathi.dart';

abstract class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Profile Page
  String get profile;
  String get manageAccount;
  String get personal;
  String get settings;
  String get security;
  String get dateOfBirth;
  String get notSet;
  String get notifications;
  String get locationServices;
  String get biometricLogin;
  String get autoSync;
  String get emergencyAlerts;
  String get theme;
  String get language;
  String get selectLanguage;
  String get languageChangedTo;
  String get changePassword;
  String get twoFactorAuth;
  String get privacySettings;
  String get dataExport;
  String get deleteAccount;
  String get logout;
  String get logoutConfirm;
  String get cancel;
  String get loggedOut;
  String get profileUpdated;
  String get accountDeletionFeature;

  // Common
  String get home;
  String get services;
  String get contact;
  String get search;
  String get save;
  String get edit;
  String get delete;
  String get confirm;
  String get ok;
  String get yes;
  String get no;
  String get back;
  String get next;
  String get previous;
  String get submit;
  String get reset;
  String get clear;
  String get loading;
  String get error;
  String get success;
  String get warning;
  String get info;

  // Login/Registration
  String get login;
  String get register;
  String get email;
  String get password;
  String get confirmPassword;
  String get forgotPassword;
  String get rememberMe;
  String get signIn;
  String get signUp;
  String get signOut;
  String get createAccount;
  String get alreadyHaveAccount;
  String get dontHaveAccount;
  String get forgotPasswordQuestion;
  String get resetPassword;
  String get sendResetLink;

  // Home Page
  String get welcome;
  String get quickServices;
  String get emergencyContacts;
  String get dailyUpdates;
  String get missingPersonAlert;
  String get fileComplaint;
  String get safetyTips;
  String get bloodRequest;
  String get appointments;
  String get police;
  String get ambulance;
  String get fire;
  String get trafficDiversion;
  String get policeAwareness;
  String get cyberSafetyTips;
  String get missingPersonAlertTitle;
  String get missingPersonAlertDescription;

  // Services
  String get policeServices;
  String get accessAllServices;
  String get thunaService;
  String get officialPoliceServices;
  String get polBloodService;
  String get bloodDonationRequests;
  String get citizenSafetyService;
  String get personalSafetyFeatures;
  String get reportOffence;
  String get reportCrimesIncidents;
  String get appointmentSearch;
  String get scheduleFindServices;
  String get internetTips;
  String get cyberSafetyGuidance;
  String get rate;
  String get rateOurServices;
  String get webLinks;
  String get externalResources;
  String get aiAssistant;
  String get policeChatbot;

  // Contact
  String get contactEmergency;
  String get getInTouch;
  String get searchContacts;
  String get helpline;
  String get emergency;
  String get womenHelpline;
  String get childHelpline;
  String get emergencyNotification;
  String get sendEmergencyAlert;
  String get notify;
  String get policeDepartment;
  String get ambulanceService;
  String get fireDepartment;
  String get call;
  String get access;

  // Forms
  String get complaintRegistration;
  String get mikeSanctionRegistration;
  String get firDownload;
  String get accidentGd;
  String get lostProperty;
  String get paymentHistory;
  String get eventPerformance;
  String get grievanceRedressal;
  String get arrestSearch;
  String get feedback;
  String get bloodDonor;
  String get trackMyTrip;
  String get lockedHouseInfo;
  String get seniorCitizenInfo;
  String get singleWomenLivingAlone;
  String get reportAbduction;
  String get reportCyberFraud;
  String get shareInformation;
  String get appointmentWithSho;
  String get searchPoliceStation;
  String get cyberSecurityInfo;
  String get touristGuide;
  String get userManual;
  String get awarenessClasses;
  String get ratePoliceStation;
  String get rateApplication;
  String get socialMediaOfPolice;
  String get maharashtraGovernment;
  String get ahilyanagarPolice;
  String get cyberDone;

  // Form Fields
  String get selectIdProofType;
  String get idProofNumber;
  String get enterIdProofNumber;
  String get emergencyContactName;
  String get enterEmergencyContactName;
  String get emergencyContactNumber;
  String get enterEmergencyContactNumber;
  String get serviceType;
  String get selectServiceType;
  String get descriptionOfServiceNeeded;
  String get enterServiceDescription;
  String get preferredDate;
  String get selectDate;
  String get selectPreferredDate;
  String get preferredTime;
  String get selectTime;
  String get selectPreferredTime;
  String get locationAddress;
  String get enterLocationAddress;
  String get additionalNotes;
  String get formSubmitted;
  String get applicantName;
  String get applicantContactNumber;
  String get applicantEmail;
  String get address;
  String get enterYourName;
  String get enterContactNumber;
  String get enterEmail;
  String get enterAddress;

  // ID Proof Types
  String get idProofType;
  String get aadhaar;
  String get pan;
  String get voterId;
  String get passport;
  String get other;

  // Service Types
  String get policeVerification;
  String get noc;
  String get characterCertificate;
  String get eventPermission;

  // Placeholder
  String get placeholder;

  // Daily Updates
  String get trafficDiversionTitle;
  String get trafficDiversionSubtitle;
  String get awarenessDriveTitle;
  String get awarenessDriveSubtitle;
  String get cyberSafetyTipsTitle;
  String get cyberSafetyTipsSubtitle;

  // Form coming soon
  String get formComingSoon;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'mr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return AppLocalizationsEnglish();
      case 'hi':
        return AppLocalizationsHindi();
      case 'mr':
        return AppLocalizationsMarathi();
      default:
        return AppLocalizationsEnglish();
    }
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 