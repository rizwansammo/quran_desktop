import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const translations = {
    "en.sahih": "Sahih International (English)",
    "en.pickthall": "Pickthall (English)",
    "bn.bengali": "Bengali Translation",
  };

  static const tafsirSources = {
    "en.ibnkathir": "Tafsir Ibn Kathir (English)",
    "bn.ibnkathir": "Tafsir Ibn Kathir (Bangla)",
    "bn.abubakar_zakaria": "Abu Bakar Zakaria (Bangla)",
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final arabicFont = ref.watch(arabicFontProvider);

    final t1 = ref.watch(translationProvider1);
    final t2 = ref.watch(translationProvider2);

    final tafsir = ref.watch(tafsirProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Toggle
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Toggle between dark and light themes"),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).toggle();
            },
          ),

          const SizedBox(height: 20),

          // Arabic Font
          Text(
            "Arabic Font",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: arabicFont,
            items: arabicFonts
                .map(
                  (f) => DropdownMenuItem(
                    value: f,
                    child: Text(f),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                ref.read(arabicFontProvider.notifier).setFont(value);
              }
            },
          ),

          const SizedBox(height: 20),

          // Translation 1
          Text(
            "Primary Translation",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: t1,
            items: translations.entries
                .map(
                  (e) => DropdownMenuItem(
                    value: e.key,
                    child: Text(e.value),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                ref.read(translationProvider1.notifier).setTranslation(value);
              }
            },
          ),

          const SizedBox(height: 20),

          // Translation 2
          Text(
            "Secondary Translation",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: t2,
            items: [
              const DropdownMenuItem(value: "", child: Text("None")),
              ...translations.entries.map(
                (e) => DropdownMenuItem(
                  value: e.key,
                  child: Text(e.value),
                ),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(translationProvider2.notifier).setTranslation(value);
              }
            },
          ),

          const SizedBox(height: 20),

          // Tafsir Source
          Text(
            "Tafsir Source",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: tafsir,
            items: tafsirSources.entries
                .map(
                  (e) => DropdownMenuItem(
                    value: e.key,
                    child: Text(e.value),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                ref.read(tafsirProvider.notifier).setTranslation(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
