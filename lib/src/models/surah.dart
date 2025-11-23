class Surah {
  final int number;
  final String name;
  final String englishName;
  final int ayahCount;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.ayahCount,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        ayahCount: json["ayahCount"],
      );
}
