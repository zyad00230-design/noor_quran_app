import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quran_provider.dart';
import 'quran_reader_screen.dart';

class QuranListScreen extends StatelessWidget {
  const QuranListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quranProvider = context.watch<QuranProvider>();
    final surahs = quranProvider.getAllSurahs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('سور القرآن الكريم'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: surahs.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Text(
                surah['number'].toString(),
                style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              surah['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text('${surah['revelation']} - ${surah['verses']} آية'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuranReaderScreen(surahNumber: surah['number']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
