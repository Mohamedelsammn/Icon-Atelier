import 'package:flutter/material.dart';
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
  String get shortcutCreated => _get('shortcutCreated');
  String get creationFailed => _get('creationFailed');
  String get customizeIcon => _get('customizeIcon');
  String get premiumPacks => _get('premiumPacks');
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
  String get applyIconPack => _get('applyIconPack');
  String get applying => _get('applying');

  // ===== PRISM PACK =====
  String get prismPack => _get('prismPack');
  String get prismPackTitle => _get('prismPackTitle');
  String get prismPackDesc => _get('prismPackDesc');
  String get gradient => _get('gradient');
  String get premiumTheme => _get('premiumTheme');
  String get darkMinimal => _get('darkMinimal');
  String get glassmorphism => _get('glassmorphism');

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
  String get privacyText4 => _get('privacyText4');
  String get privacyText5 => _get('privacyText5');
  String get english => _get('english');
  String get arabic => _get('arabic');
  String get loadingApps => _get('loadingApps');
  String get developer => _get('developer');
  String get lastUpdated => _get('lastUpdated');
  String get madeWith => _get('madeWith');
  String get privacyQuestions => _get('privacyQuestions');
  String get prismModernTitle => _get('prismModernTitle');
  String get prismModernDesc => _get('prismModernDesc');
  String get allIcons => _get('allIcons');
  String get system => _get('system');
  String get social => _get('social');
  String get productivity => _get('productivity');
  String get allowPermission => _get('allowPermission');
  String get permissionDesc => _get('permissionDesc');
  String get allow => _get('allow');
  String get exit => _get('exit');
  String get digitalCurator => _get('digitalCurator');
  String get curating => _get('curating');

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
      'shortcutCreated': 'Shortcut created successfully!',
      'creationFailed': 'Creation Failed',
      'customizeIcon': 'Customize Icon',
      'premiumPacks': 'Premium Packs',
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
      'iconAppliedSuccess': '{name} icon applied successfully!',
      'applyIconPack': 'Apply Icon Pack',
      'applying': 'Applying...',
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
      'aboutText': 'Icon Atelier is your premier destination for home screen personalization. We offer a curated selection of handcrafted icon packs, from the stealthy Carbon aesthetics to the vibrant Prism gradients. Our goal is to provide a seamless, ad-free experience that empowers you to express your unique style through your device.',
      'privacyText1': 'Your privacy is our top priority. Icon Atelier is designed to respect your data:',
      'privacyText2': '• No Data Collection: We do not collect, store, or transmit any personal information, location data, or device identifiers.',
      'privacyText3': '• Local Processing: All icon customizations and shortcut creations are performed entirely on your device.',
      'privacyText4': '• App List Usage: We access your installed apps list only to allow you to select which app to customize. This list never leaves your device.',
      'privacyText5': '• No Analytics: We do not use any third-party tracking or analytics services.',
      'english': 'English',
      'arabic': 'Arabic',
      'darkMinimal': 'Dark & Minimal',
      'glassmorphism': 'Glassmorphism',
      'loadingApps': 'Loading apps...',
      'developer': 'Developer',
      'lastUpdated': 'Last Updated',
      'madeWith': 'Made with Creative Hub ❤️ for Android Customizers',
      'privacyQuestions': 'Questions? Contact our support team for privacy concerns.',
      'prismModernTitle': 'Prism Modern',
      'prismModernDesc': 'A sophisticated collection of glassmorphic icons featuring subtle gradients and minimal geometric structure.',
      'allIcons': 'All Icons',
      'system': 'System',
      'social': 'Social',
      'productivity': 'Productivity',
      'allowPermission': 'Allow Permission',
      'permissionDesc': 'To change app icons, we need permission to read your installed apps.',
      'allow': 'Allow',
      'exit': 'Exit',
      'digitalCurator': 'THE DIGITAL CURATOR',
      'curating': 'CURATING',
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
      'shortcutCreated': 'تم إنشاء الاختصار بنجاح!',
      'creationFailed': 'فشل الإنشاء',
      'customizeIcon': 'تخصيص الأيقونة',
      'premiumPacks': 'حزم مميزة',
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
      'applyIconPack': 'تطبيق حزمة الأيقونات',
      'applying': 'جاري التطبيق...',
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
      'aboutText': 'أيقونة أتلييه هي وجهتك الأولى لتخصيص شاشة هاتفك. نحن نقدم مجموعة مختارة من حزم الأيقونات المصممة يدوياً، من جماليات "كاربون" الهادئة إلى تدرجات "بريزم" الحيوية. هدفنا هو توفير تجربة سلسة وخالية من الإعلانات تمنحك القوة للتعبير عن أسلوبك الفريد من خلال جهازك.',
      'privacyText1': 'خصوصيتك هي أولويتنا القصوى. تم تصميم "أيقونة أتلييه" لاحترام بياناتك:',
      'privacyText2': '• عدم جمع البيانات: نحن لا نجمع أو نخزن أو ننقل أي معلومات شخصية أو بيانات موقع أو معرفات جهاز.',
      'privacyText3': '• معالجة محلية: يتم تنفيذ جميع تخصيصات الأيقونات وإنشاء الاختصارات بالكامل على جهازك.',
      'privacyText4': '• استخدام قائمة التطبيقات: نصل إلى قائمة التطبيقات المثبتة فقط للسماح لك باختيار التطبيق الذي تريد تخصيصه. هذه القائمة لا تغادر جهازك أبداً.',
      'privacyText5': '• لا توجد تحليلات: نحن لا نستخدم أي خدمات تتبع أو تحليلات من طرف ثالث.',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'darkMinimal': 'داكن وبسيط',
      'glassmorphism': 'تأثير زجاجي',
      'loadingApps': 'جاري تحميل التطبيقات...',
      'developer': 'المطور',
      'lastUpdated': 'آخر تحديث',
      'madeWith': 'صنع بـ ❤️ من Creative Hub لمخصصي الأندرويد',
      'privacyQuestions': 'لديك أسئلة؟ تواصل مع فريق الدعم لدينا بخصوص مخاوف الخصوصية.',
      'prismModernTitle': 'بريزم مودرن',
      'prismModernDesc': 'مجموعة متطورة من الأيقونات الزجاجية تتميز بتدرجات خفيفة وهيكل هندسي بسيط.',
      'allIcons': 'الكل',
      'system': 'النظام',
      'social': 'التواصل',
      'productivity': 'الإنتاجية',
      'allowPermission': 'السماح بالإذن',
      'permissionDesc': 'لتغيير أيقونات التطبيقات، نحتاج إلى إذن لقراءة تطبيقاتك المثبتة.',
      'allow': 'السماح',
      'exit': 'خروج',
      'digitalCurator': 'المنسق الرقمي',
      'curating': 'جاري التجهيز',
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
