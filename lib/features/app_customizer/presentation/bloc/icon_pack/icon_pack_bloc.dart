import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'icon_pack_event.dart';
import 'icon_pack_state.dart';

class IconPackBloc extends Bloc<IconPackEvent, IconPackState> {
  IconPackBloc() : super(IconPackInitial()) {
    on<LoadIconPackEvent>(_onLoad);
    on<FilterIconPackEvent>(_onFilter);
    on<ToggleStyleEvent>(_onToggleStyle);
    on<SelectIconEvent>(_onSelectIcon);
  }

  // ──────────────────────────── Data ────────────────────────────
  static final List<IconItem> _carbonIcons = [
    IconItem(
      outlineIcon: Iconsax.sms,
      solidIcon: Iconsax.sms_copy,
      name: 'Mail',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.message,
      solidIcon: Iconsax.message_copy,
      name: 'Messages',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.camera,
      solidIcon: Iconsax.camera_copy,
      name: 'Camera',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.music,
      solidIcon: Iconsax.music_copy,
      name: 'Music',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.map,
      solidIcon: Iconsax.map_copy,
      name: 'Maps',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.setting_2,
      solidIcon: Iconsax.setting_2_copy,
      name: 'Settings',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.gallery,
      solidIcon: Iconsax.gallery_copy,
      name: 'Photos',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.calendar,
      solidIcon: Iconsax.calendar_copy,
      name: 'Calendar',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.call,
      solidIcon: Iconsax.call_copy,
      name: 'Phone',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.note,
      solidIcon: Iconsax.note_copy,
      name: 'Notes',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.folder_2,
      solidIcon: Iconsax.folder_2_copy,
      name: 'Files',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.clock,
      solidIcon: Iconsax.clock_copy,
      name: 'Clock',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.calculator,
      solidIcon: Iconsax.calculator_copy,
      name: 'Calculator',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.user,
      solidIcon: Iconsax.user_copy,
      name: 'Contacts',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.shop,
      solidIcon: Iconsax.shop_copy,
      name: 'Store',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.cloud,
      solidIcon: Iconsax.cloud_copy,
      name: 'Cloud',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.send_2,
      solidIcon: Iconsax.send_2_copy,
      name: 'Telegram',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.facebook,
      solidIcon: Iconsax.facebook_copy,
      name: 'Facebook',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.instagram,
      solidIcon: Iconsax.instagram_copy,
      name: 'Instagram',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.youtube,
      solidIcon: Iconsax.youtube_copy,
      name: 'YouTube',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Icons.tiktok,
      solidIcon: Icons.tiktok,
      name: 'TikTok',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.global,
      solidIcon: Iconsax.global_copy,
      name: 'Twitter',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Icons.discord,
      solidIcon: Icons.discord,
      name: 'Discord',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.briefcase,
      solidIcon: Iconsax.briefcase_copy,
      name: 'LinkedIn',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.wallet,
      solidIcon: Iconsax.wallet_copy,
      name: 'Wallet',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.chart_2,
      solidIcon: Iconsax.chart_2_copy,
      name: 'Stocks',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.edit_2,
      solidIcon: Iconsax.edit_2_copy,
      name: 'Editor',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.book,
      solidIcon: Iconsax.book_copy,
      name: 'Books',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.task,
      solidIcon: Iconsax.task_copy,
      name: 'Tasks',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.status_up,
      solidIcon: Iconsax.status_up_copy,
      name: 'Analytics',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.search_normal,
      solidIcon: Iconsax.search_normal_copy,
      name: 'Search',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.shield,
      solidIcon: Iconsax.shield,
      name: 'Security',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.cloud_plus,
      solidIcon: Iconsax.cloud_plus_copy,
      name: 'Downloads',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.translate,
      solidIcon: Iconsax.translate_copy,
      name: 'Translate',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.headphone,
      solidIcon: Iconsax.headphone_copy,
      name: 'Spotify',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.shopping_cart,
      solidIcon: Iconsax.shopping_cart_copy,
      name: 'Shop',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.receipt_2,
      solidIcon: Iconsax.receipt_2_copy,
      name: 'Receipts',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.lock,
      solidIcon: Iconsax.lock_copy,
      name: 'Lock',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.health,
      solidIcon: Iconsax.health_copy,
      name: 'Health',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.sun_1,
      solidIcon: Iconsax.sun_1_copy,
      name: 'Weather',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.home,
      solidIcon: Iconsax.home_copy,
      name: 'Home',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.global_search,
      solidIcon: Iconsax.global_search_copy,
      name: 'Browser',
      category: 'system',
    ),
  ];

  static final List<IconItem> _prismIcons = [
    IconItem(
      outlineIcon: Iconsax.sms,
      solidIcon: Iconsax.sms_copy,
      name: 'Mail',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.message_2,
      solidIcon: Iconsax.message_2_copy,
      name: 'Messages',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.camera,
      solidIcon: Iconsax.camera_copy,
      name: 'Camera',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.gallery,
      solidIcon: Iconsax.gallery_copy,
      name: 'Photos',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.setting_2,
      solidIcon: Iconsax.setting_2_copy,
      name: 'Settings',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.health,
      solidIcon: Iconsax.health_copy,
      name: 'Health',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.sun_1,
      solidIcon: Iconsax.sun_1_copy,
      name: 'Weather',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.map,
      solidIcon: Iconsax.map_copy,
      name: 'Maps',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.calendar,
      solidIcon: Iconsax.calendar_copy,
      name: 'Calendar',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.clock,
      solidIcon: Iconsax.clock_copy,
      name: 'Clock',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.calculator,
      solidIcon: Iconsax.calculator_copy,
      name: 'Calculator',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.music,
      solidIcon: Iconsax.music_copy,
      name: 'Music',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.folder_2,
      solidIcon: Iconsax.folder_2_copy,
      name: 'Files',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.note,
      solidIcon: Iconsax.note_copy,
      name: 'Notes',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.shop,
      solidIcon: Iconsax.shop_copy,
      name: 'Store',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.home,
      solidIcon: Iconsax.home_copy,
      name: 'Home',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Iconsax.user,
      solidIcon: Iconsax.user_copy,
      name: 'Contacts',
      category: 'system',
    ),
    IconItem(
      outlineIcon: Icons.telegram,
      solidIcon: Icons.telegram,
      name: 'Telegram',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.facebook,
      solidIcon: Iconsax.facebook_copy,
      name: 'Facebook',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.instagram,
      solidIcon: Iconsax.instagram_copy,
      name: 'Instagram',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.youtube,
      solidIcon: Iconsax.youtube_copy,
      name: 'YouTube',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Icons.tiktok,
      solidIcon: Icons.tiktok,
      name: 'TikTok',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Icons.discord,
      solidIcon: Icons.discord,
      name: 'Discord',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.briefcase,
      solidIcon: Iconsax.briefcase_copy,
      name: 'LinkedIn',
      category: 'social',
    ),
    IconItem(
      outlineIcon: Iconsax.wallet,
      solidIcon: Iconsax.wallet_copy,
      name: 'Wallet',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.chart_2,
      solidIcon: Iconsax.chart_2_copy,
      name: 'Stocks',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.edit_2,
      solidIcon: Iconsax.edit_2_copy,
      name: 'Editor',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.book,
      solidIcon: Iconsax.book_copy,
      name: 'Books',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.task,
      solidIcon: Iconsax.task_copy,
      name: 'Tasks',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.chart,
      solidIcon: Iconsax.chart_copy,
      name: 'Analytics',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.headphone,
      solidIcon: Iconsax.headphone_copy,
      name: 'Spotify',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.shop,
      solidIcon: Iconsax.shop_copy,
      name: 'Shop',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.star,
      solidIcon: Iconsax.star_copy,
      name: 'Magic',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.brush,
      solidIcon: Iconsax.brush_copy,
      name: 'Design',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.translate,
      solidIcon: Iconsax.translate_copy,
      name: 'Translate',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.shield,
      solidIcon: Iconsax.shield,
      name: 'Security',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.export,
      solidIcon: Iconsax.export_copy,
      name: 'Cloud',
      category: 'productivity',
    ),
    IconItem(
      outlineIcon: Iconsax.star,
      solidIcon: Iconsax.star_copy,
      name: 'Premium',
      category: 'productivity',
    ),
  ];

  // ──────────────────────────── Handlers ────────────────────────────
  void _onLoad(LoadIconPackEvent event, Emitter<IconPackState> emit) {
    emit(IconPackLoading());
    final icons = event.packType == 'carbon' ? _carbonIcons : _prismIcons;
    final defaultStyle = event.packType == 'carbon' ? 'outline' : 'gradient';
    emit(
      IconPackLoaded(
        allIcons: icons,
        filteredIcons: icons,
        selectedCategory: 'all',
        selectedStyle: defaultStyle,
      ),
    );
  }

  void _onFilter(FilterIconPackEvent event, Emitter<IconPackState> emit) {
    final current = state as IconPackLoaded;
    final filtered = event.category == 'all'
        ? current.allIcons
        : current.allIcons.where((i) => i.category == event.category).toList();
    emit(
      current.copyWith(
        filteredIcons: filtered,
        selectedCategory: event.category,
        selectedIndex: null,
      ),
    );
  }

  void _onToggleStyle(ToggleStyleEvent event, Emitter<IconPackState> emit) {
    final current = state as IconPackLoaded;
    emit(current.copyWith(selectedStyle: event.style));
  }

  void _onSelectIcon(SelectIconEvent event, Emitter<IconPackState> emit) {
    final current = state as IconPackLoaded;
    emit(current.copyWith(selectedIndex: event.index));
  }
}
