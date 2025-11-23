import 'package:flutter/material.dart';
import 'surah_screen.dart';
import 'settings_screen.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  static final List<Map<String, dynamic>> surahs = [
    {"number": 1, "name": "الفاتحة", "english": "Al-Fatihah", "ayat": 7},
    {"number": 2, "name": "البقرة", "english": "Al-Baqarah", "ayat": 286},
    {"number": 3, "name": "آل عمران", "english": "Aal-Imran", "ayat": 200},
    {"number": 4, "name": "النساء", "english": "An-Nisa", "ayat": 176},
    {"number": 5, "name": "المائدة", "english": "Al-Ma'idah", "ayat": 120},
    {"number": 6, "name": "الأنعام", "english": "Al-An'am", "ayat": 165},
    {"number": 7, "name": "الأعراف", "english": "Al-A'raf", "ayat": 206},
    {"number": 8, "name": "الأنفال", "english": "Al-Anfal", "ayat": 75},
    {"number": 9, "name": "التوبة", "english": "At-Tawbah", "ayat": 129},
    {"number": 10, "name": "يونس", "english": "Yunus", "ayat": 109},
    {"number": 11, "name": "هود", "english": "Hud", "ayat": 123},
    {"number": 12, "name": "يوسف", "english": "Yusuf", "ayat": 111},
    {"number": 13, "name": "الرعد", "english": "Ar-Ra'd", "ayat": 43},
    {"number": 14, "name": "ابراهيم", "english": "Ibrahim", "ayat": 52},
    {"number": 15, "name": "الحجر", "english": "Al-Hijr", "ayat": 99},
    {"number": 16, "name": "النحل", "english": "An-Nahl", "ayat": 128},
    {"number": 17, "name": "الإسراء", "english": "Al-Isra", "ayat": 111},
    {"number": 18, "name": "الكهف", "english": "Al-Kahf", "ayat": 110},
    {"number": 19, "name": "مريم", "english": "Maryam", "ayat": 98},
    {"number": 20, "name": "طه", "english": "Ta-Ha", "ayat": 135},
    {"number": 21, "name": "الأنبياء", "english": "Al-Anbiya", "ayat": 112},
    {"number": 22, "name": "الحج", "english": "Al-Hajj", "ayat": 78},
    {"number": 23, "name": "المؤمنون", "english": "Al-Mu'minun", "ayat": 118},
    {"number": 24, "name": "النور", "english": "An-Nur", "ayat": 64},
    {"number": 25, "name": "الفرقان", "english": "Al-Furqan", "ayat": 77},
    {"number": 26, "name": "الشعراء", "english": "Ash-Shu'ara", "ayat": 227},
    {"number": 27, "name": "النمل", "english": "An-Naml", "ayat": 93},
    {"number": 28, "name": "القصص", "english": "Al-Qasas", "ayat": 88},
    {"number": 29, "name": "العنكبوت", "english": "Al-Ankabut", "ayat": 69},
    {"number": 30, "name": "الروم", "english": "Ar-Rum", "ayat": 60},
    {"number": 31, "name": "لقمان", "english": "Luqman", "ayat": 34},
    {"number": 32, "name": "السجدة", "english": "As-Sajdah", "ayat": 30},
    {"number": 33, "name": "الأحزاب", "english": "Al-Ahzab", "ayat": 73},
    {"number": 34, "name": "سبأ", "english": "Saba", "ayat": 54},
    {"number": 35, "name": "فاطر", "english": "Fatir", "ayat": 45},
    {"number": 36, "name": "يس", "english": "Ya-Sin", "ayat": 83},
    {"number": 37, "name": "الصافات", "english": "As-Saffat", "ayat": 182},
    {"number": 38, "name": "ص", "english": "Sad", "ayat": 88},
    {"number": 39, "name": "الزمر", "english": "Az-Zumar", "ayat": 75},
    {"number": 40, "name": "غافر", "english": "Ghafir", "ayat": 85},
    {"number": 41, "name": "فصلت", "english": "Fussilat", "ayat": 54},
    {"number": 42, "name": "الشورى", "english": "Ash-Shuraa", "ayat": 53},
    {"number": 43, "name": "الزخرف", "english": "Az-Zukhruf", "ayat": 89},
    {"number": 44, "name": "الدخان", "english": "Ad-Dukhan", "ayat": 59},
    {"number": 45, "name": "الجاثية", "english": "Al-Jathiyah", "ayat": 37},
    {"number": 46, "name": "الأحقاف", "english": "Al-Ahqaf", "ayat": 35},
    {"number": 47, "name": "محمد", "english": "Muhammad", "ayat": 38},
    {"number": 48, "name": "الفتح", "english": "Al-Fath", "ayat": 29},
    {"number": 49, "name": "الحجرات", "english": "Al-Hujurat", "ayat": 18},
    {"number": 50, "name": "ق", "english": "Qaf", "ayat": 45},
    {"number": 51, "name": "الذاريات", "english": "Adh-Dhariyat", "ayat": 60},
    {"number": 52, "name": "الطور", "english": "At-Tur", "ayat": 49},
    {"number": 53, "name": "النجم", "english": "An-Najm", "ayat": 62},
    {"number": 54, "name": "القمر", "english": "Al-Qamar", "ayat": 55},
    {"number": 55, "name": "الرحمن", "english": "Ar-Rahman", "ayat": 78},
    {"number": 56, "name": "الواقعة", "english": "Al-Waqi'ah", "ayat": 96},
    {"number": 57, "name": "الحديد", "english": "Al-Hadid", "ayat": 29},
    {"number": 58, "name": "المجادلة", "english": "Al-Mujadila", "ayat": 22},
    {"number": 59, "name": "الحشر", "english": "Al-Hashr", "ayat": 24},
    {"number": 60, "name": "الممتحنة", "english": "Al-Mumtahanah", "ayat": 13},
    {"number": 61, "name": "الصف", "english": "As-Saff", "ayat": 14},
    {"number": 62, "name": "الجمعة", "english": "Al-Jumu'ah", "ayat": 11},
    {"number": 63, "name": "المنافقون", "english": "Al-Munafiqun", "ayat": 11},
    {"number": 64, "name": "التغابن", "english": "At-Taghabun", "ayat": 18},
    {"number": 65, "name": "الطلاق", "english": "At-Talaq", "ayat": 12},
    {"number": 66, "name": "التحريم", "english": "At-Tahrim", "ayat": 12},
    {"number": 67, "name": "الملك", "english": "Al-Mulk", "ayat": 30},
    {"number": 68, "name": "القلم", "english": "Al-Qalam", "ayat": 52},
    {"number": 69, "name": "الحاقة", "english": "Al-Haqqah", "ayat": 52},
    {"number": 70, "name": "المعارج", "english": "Al-Ma'arij", "ayat": 44},
    {"number": 71, "name": "نوح", "english": "Nuh", "ayat": 28},
    {"number": 72, "name": "الجن", "english": "Al-Jinn", "ayat": 28},
    {"number": 73, "name": "المزمل", "english": "Al-Muzzammil", "ayat": 20},
    {"number": 74, "name": "المدثر", "english": "Al-Muddathir", "ayat": 56},
    {"number": 75, "name": "القيامة", "english": "Al-Qiyamah", "ayat": 40},
    {"number": 76, "name": "الانسان", "english": "Al-Insan", "ayat": 31},
    {"number": 77, "name": "المرسلات", "english": "Al-Mursalat", "ayat": 50},
    {"number": 78, "name": "النبإ", "english": "An-Naba", "ayat": 40},
    {"number": 79, "name": "النازعات", "english": "An-Nazi'at", "ayat": 46},
    {"number": 80, "name": "عبس", "english": "Abasa", "ayat": 42},
    {"number": 81, "name": "التكوير", "english": "At-Takwir", "ayat": 29},
    {"number": 82, "name": "الإنفطار", "english": "Al-Infitar", "ayat": 19},
    {"number": 83, "name": "المطففين", "english": "Al-Mutaffifin", "ayat": 36},
    {"number": 84, "name": "الإنشقاق", "english": "Al-Inshiqaq", "ayat": 25},
    {"number": 85, "name": "البروج", "english": "Al-Buruj", "ayat": 22},
    {"number": 86, "name": "الطارق", "english": "At-Tariq", "ayat": 17},
    {"number": 87, "name": "الأعلى", "english": "Al-A'la", "ayat": 19},
    {"number": 88, "name": "الغاشية", "english": "Al-Ghashiyah", "ayat": 26},
    {"number": 89, "name": "الفجر", "english": "Al-Fajr", "ayat": 30},
    {"number": 90, "name": "البلد", "english": "Al-Balad", "ayat": 20},
    {"number": 91, "name": "الشمس", "english": "Ash-Shams", "ayat": 15},
    {"number": 92, "name": "الليل", "english": "Al-Layl", "ayat": 21},
    {"number": 93, "name": "الضحى", "english": "Ad-Duha", "ayat": 11},
    {"number": 94, "name": "الشرح", "english": "Ash-Sharh", "ayat": 8},
    {"number": 95, "name": "التين", "english": "At-Tin", "ayat": 8},
    {"number": 96, "name": "العلق", "english": "Al-Alaq", "ayat": 19},
    {"number": 97, "name": "القدر", "english": "Al-Qadr", "ayat": 5},
    {"number": 98, "name": "البينة", "english": "Al-Bayyinah", "ayat": 8},
    {"number": 99, "name": "الزلزلة", "english": "Az-Zalzalah", "ayat": 8},
    {"number": 100, "name": "العاديات", "english": "Al-Adiyat", "ayat": 11},
    {"number": 101, "name": "القارعة", "english": "Al-Qari'ah", "ayat": 11},
    {"number": 102, "name": "التكاثر", "english": "At-Takathur", "ayat": 8},
    {"number": 103, "name": "العصر", "english": "Al-Asr", "ayat": 3},
    {"number": 104, "name": "الهمزة", "english": "Al-Humazah", "ayat": 9},
    {"number": 105, "name": "الفيل", "english": "Al-Fil", "ayat": 5},
    {"number": 106, "name": "قريش", "english": "Quraysh", "ayat": 4},
    {"number": 107, "name": "الماعون", "english": "Al-Ma'un", "ayat": 7},
    {"number": 108, "name": "الكوثر", "english": "Al-Kawthar", "ayat": 3},
    {"number": 109, "name": "الكافرون", "english": "Al-Kafirun", "ayat": 6},
    {"number": 110, "name": "النصر", "english": "An-Nasr", "ayat": 3},
    {"number": 111, "name": "المسد", "english": "Al-Masad", "ayat": 5},
    {"number": 112, "name": "الإخلاص", "english": "Al-Ikhlas", "ayat": 4},
    {"number": 113, "name": "الفلق", "english": "Al-Falaq", "ayat": 5},
    {"number": 114, "name": "الناس", "english": "An-Nas", "ayat": 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran Desktop"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, i) {
          final s = surahs[i];

          return ListTile(
            title: Text(
              "${s['number']}. ${s['english']}",
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              s['name'],
              style: const TextStyle(fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
            trailing: Text(
              "${s['ayat']} Ayat",
              style: const TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SurahScreen(
                    surahNumber: s['number'],
                    surahNameAr: s['name'],
                    surahNameEn: s['english'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
