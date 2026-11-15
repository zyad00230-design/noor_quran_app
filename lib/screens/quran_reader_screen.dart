import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class QuranReaderScreen extends StatelessWidget {
  final int surahNumber;

  const QuranReaderScreen({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    int verseCount = quran.getVerseCount(surahNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahNameArabic(surahNumber)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {}, // Play audio
          ),
        ],
      ),
      body: Column(
        children: [
          if (surahNumber != 1 && surahNumber != 9)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                quran.basmala,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: verseCount,
              itemBuilder: (context, index) {
                int ayahNumber = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: quran.getVerse(surahNumber, ayahNumber),
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                            fontFamily: 'Amiri',
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Theme.of(context).primaryColor),
                            ),
                            child: Text(
                              ayahNumber.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
