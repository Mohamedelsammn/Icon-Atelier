import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // ===== GENERAL =====
  String get appName => _get('appName');
  String get iconAtelier => _get('iconAtelier');
  String get cancel => _get('cancel');
  String get apply => _get('apply');
  String get ok => _get('ok');
  String get error => _get('error');
  String get success => _get('success');

  // ===== HOME SCREEN =====
  String get chooseApp => _get('chooseApp');
  String get selectApp => _get('selectApp');
  String get searchApplications => _get('searchApplications');
  String get targetApplication => _get('targetApplication');

  // ===== APP DETAILS =====
  String get curatedPacks => _get('curatedPacks');
  String get customArt => _get('customArt');
  String get uploadFromGallery => _get('uploadFromGallery');
  String get uploadHint => _get('uploadHint');
  String get applyCustomIcon => _get('applyCustomIcon');
  String get editAppName => _get('editAppName');
  String get enterNewName => _get('enterNewName');
  String get createShortcut => _get('createShortcut');
  String get shortcutCreatedSuccess => _get('shortcutCreatedSuccess');
  String get creatingShortcut => _get('creatingShortcut');
  String get appInfo => _get('appInfo');
  String get help => _get('help');
  String get name => _get('name');
  String get package => _get('package');

  // ===== CARBON PACK =====
  String get carbonPack => _get('carbonPack');
  String get carbonPackTitle => _get('carbonPackTitle');
  String get carbonPackDesc => _get('carbonPackDesc');
  String get solid => _get('solid');
  String get outline => _get('outline');
  String get includedIcons => _get('includedIcons');
  String get total => _get('total');
  String get applyIcon => _get('applyIcon');
  String get applyToApp => _get('applyToApp');
  String get iconAppliedSuccess => _get('iconAppliedSuccess');

  // ===== PRISM PACK =====
  String get prismPack => _get('prismPack');
  String get prismPackTitle => _get('prismPackTitle');
  String get prismPackDesc => _get('prismPackDesc');
  String get gradient => _get('gradient');
  String get premiumTheme => _get('premiumTheme');

  // ===== SETTINGS =====
  String get settings => _get('settings');
  String get darkMode => _get('darkMode');
  String get darkModeSub => _get('darkModeSub');
  String get language => _get('language');
  String get languageSub => _get('languageSub');
  String get about => _get('about');
  String get aboutSub => _get('aboutSub');
  String get privacyPolicy => _get('privacyPolicy');
  String get privacySub => _get('privacySub');
  String get version => _get('version');
  String get aboutText => _get('aboutText');
  String get privacyText1 => _get('privacyText1');
  String get privacyText2 => _get('privacyText2');
  String get privacyText3 => _get('privacyText3');
  String get english => _get('english');
  String get arabic => _get('arabic');

  String _get(String key) {
    return _translations[locale.languageCode]?[key] ??
        _translations['en']![key]!;
  }

  static const Map<String, Map<String, String>> _translations = {
    'en': {
      'appName': 'Icon Atelier',
      'iconAtelier': 'Icon Atelier',
      'cancel': 'Cancel',
      'apply': 'Apply',
      'ok': 'OK',
      'error': 'Error',
      'success': 'Success',
      'chooseApp': 'Choose an App',
      'selectApp': 'select an application from your device',
      'searchApplications': 'Search applications...',
      'targetApplication': 'Target Application',
      'curatedPacks': 'Curated Packs',
      'customArt': 'Custom Art',
      'uploadFromGallery': 'Upload from Gallery',
      'uploadHint': 'PNG, JPG or SVG up to 5MB',
      'applyCustomIcon': 'Apply Custom Icon',
      'editAppName': 'Edit App Name',
      'enterNewName': 'Enter new name',
      'createShortcut': 'Create Shortcut',
      'shortcutCreatedSuccess': 'Shortcut created successfully!',
      'creatingShortcut': 'Creating shortcut...',
      'appInfo': 'App Info',
      'help': 'Help',
      'name': 'Name',
      'package': 'Package',
      'carbonPack': 'Carbon Pack',
      'carbonPackTitle': 'Carbon Pack',
      'carbonPackDesc':
          'Deep blacks and charcoal grays for a stealthy, refined aesthetic. Perfect for AMOLED displays.',
      'solid': 'Solid',
      'outline': 'Outline',
      'includedIcons': 'Included Icons',
      'total': 'total',
      'applyIcon': 'Apply Icon',
      'applyToApp': 'Apply this {style} icon to {app}?',
      'iconAppliedSuccess': '{name} icon applied successfully!',
      'prismPack': 'Prism Pack',
      'prismPackTitle': 'Prism Pack',
      'prismPackDesc':
          'Vibrant gradients and bold colors that pop. Transform your home screen with stunning chromatic effects.',
      'gradient': 'Gradient',
      'premiumTheme': 'PREMIUM THEME',
      'settings': 'Settings',
      'darkMode': 'Dark Mode',
      'darkModeSub': 'Switch between light and dark theme',
      'language': 'Language',
      'languageSub': 'Select your preferred language',
      'about': 'About',
      'aboutSub': 'App version and information',
      'privacyPolicy': 'Privacy Policy',
      'privacySub': 'Read our privacy policy',
      'version': 'Version',
      'aboutText': 'Customize your home screen with beautiful icons and packs.',
      'privacyText1': 'We value your privacy. This app:',
      'privacyText2': '• Does not collect personal data',
      'privacyText3': '• Only accesses installed apps for icon changing',
      'english': 'English',
      'arabic': 'Arabic',
    },
    'ar': {
      'appName': 'أيقونة أتلييه',
      'iconAtelier': 'أيقونة أتلييه',
      'cancel': 'إلغاء',
      'apply': 'تطبيق',
      'ok': 'حسناً',
      'error': 'خطأ',
      'success': 'نجاح',
      'chooseApp': 'اختر تطبيقاً',
      'selectApp': 'اختر تطبيقاً من جهازك',
      'searchApplications': 'ابحث عن تطبيقات...',
      'targetApplication': 'التطبيق المستهدف',
      'curatedPacks': 'حزم مختارة',
      'customArt': 'فن مخصص',
      'uploadFromGallery': 'رفع من المعرض',
      'uploadHint': 'PNG, JPG أو SVG حتى 5MB',
      'applyCustomIcon': 'تطبيق أيقونة مخصصة',
      'editAppName': 'تعديل اسم التطبيق',
      'enterNewName': 'أدخل اسماً جديداً',
      'createShortcut': 'إنشاء اختصار',
      'shortcutCreatedSuccess': 'تم إنشاء الاختصار بنجاح!',
      'creatingShortcut': 'جاري إنشاء الاختصار...',
      'appInfo': 'معلومات التطبيق',
      'help': 'مساعدة',
      'name': 'الاسم',
      'package': 'الحزمة',
      'carbonPack': 'حزمة كاربون',
      'carbonPackTitle': 'حزمة كاربون',
      'carbonPackDesc':
          'درجات الأسود العميق والرمادي الفحمي لإطلالة أنيقة وسوداوية. مثالية لشاشات AMOLED.',
      'solid': 'مصمت',
      'outline': 'مخطط',
      'includedIcons': 'الأيقونات المتضمنة',
      'total': 'إجمالي',
      'applyIcon': 'تطبيق أيقونة',
      'applyToApp': 'تطبيق هذه الأيقونة {style} على {app}؟',
      'iconAppliedSuccess': 'تم تطبيق أيقونة {name} بنجاح!',
      'prismPack': 'حزمة بريزم',
      'prismPackTitle': 'حزمة بريزم',
      'prismPackDesc':
          'تدرجات لونية نابضة بالحياة وألوان جريئة. حول شاشة هاتفك بتأثيرات لونية مذهلة.',
      'gradient': 'تدرج',
      'premiumTheme': 'ثيم مميز',
      'settings': 'الإعدادات',
      'darkMode': 'الوضع المظلم',
      'darkModeSub': 'التبديل بين الوضع الفاتح والداكن',
      'language': 'اللغة',
      'languageSub': 'اختر لغتك المفضلة',
      'about': 'حول التطبيق',
      'aboutSub': 'إصدار التطبيق والمعلومات',
      'privacyPolicy': 'سياسة الخصوصية',
      'privacySub': 'اقرأ سياسة الخصوصية',
      'version': 'الإصدار',
      'aboutText': 'خصص شاشة هاتفك بأيقونات وحزم جميلة.',
      'privacyText1': 'نحن نقدر خصوصيتك. هذا التطبيق:',
      'privacyText2': '• لا يجمع بيانات شخصية',
      'privacyText3': '• يصل فقط للتطبيقات المثبتة لتغيير الأيقونات',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'en' || locale.languageCode == 'ar';
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
