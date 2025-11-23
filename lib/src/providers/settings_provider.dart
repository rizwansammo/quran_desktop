import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keys for SharedPreferences
const _kThemeMode = "theme_mode";
const _kArabicFont = "arabic_font";
const _kTranslation1 = "translation_primary";
const _kTranslation2 = "translation_secondary";
const _kTafsirSource = "tafsir_source";

/// Available Arabic fonts
final List<String> arabicFonts = [
  "Uthmani",
  "AmiriQuran",
  "Scheherazade",
  "IndoPak",
];


/// ----------------------
/// THEME MODE PROVIDER
/// ----------------------

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark) {
    _load();
  }

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemeMode);

    if (saved == "light") {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  void toggle() async {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_kThemeMode, state == ThemeMode.dark ? "dark" : "light");
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});


/// ----------------------
/// ARABIC FONT PROVIDER
/// ----------------------

class ArabicFontProvider extends StateNotifier<String> {
  ArabicFontProvider() : super("Uthmani") {
    _load();
  }

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(_kArabicFont) ?? "Uthmani";
  }

  void setFont(String fontName) async {
    state = fontName;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_kArabicFont, fontName);
  }
}

final arabicFontProvider =
    StateNotifierProvider<ArabicFontProvider, String>((ref) {
  return ArabicFontProvider();
});


/// ----------------------
/// TRANSLATION PROVIDERS
/// ----------------------

class TranslationProvider extends StateNotifier<String> {
  TranslationProvider(this.keyName, {required this.defaultValue})
      : super(defaultValue) {
    _load();
  }

  final String keyName;
  final String defaultValue;

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString(keyName) ?? defaultValue;
  }

  void setTranslation(String value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyName, value);
  }
}

final translationProvider1 =
    StateNotifierProvider<TranslationProvider, String>((ref) {
  return TranslationProvider(_kTranslation1, defaultValue: "en.sahih");
});

final translationProvider2 =
    StateNotifierProvider<TranslationProvider, String>((ref) {
  return TranslationProvider(_kTranslation2, defaultValue: "bn.bengali");
});


/// ----------------------
/// TAFSIR PROVIDER
/// ----------------------

final tafsirProvider =
    StateNotifierProvider<TranslationProvider, String>((ref) {
  return TranslationProvider(_kTafsirSource, defaultValue: "en.ibnkathir");
});
