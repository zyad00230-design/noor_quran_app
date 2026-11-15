import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prayer_provider.dart';
import '../providers/quran_provider.dart';
import 'quran_list_screen.dart';
import 'athkar_screen.dart';
import 'qibla_screen.dart';
import 'package:adhan/adhan.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<PrayerProvider>().fetchPrayerTimes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prayerProvider = context.watch<PrayerProvider>();
    final quranProvider = context.watch<QuranProvider>();
    final hijri = HijriCalendar.now();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B5E20), Color(0xFF4CAF50), Colors.white],
            stops: [0.0, 0.3, 0.6],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildHeader(hijri, prayerProvider),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildPrayerTimesCard(prayerProvider),
                      const SizedBox(height: 20),
                      _buildQuickActions(context),
                      const SizedBox(height: 20),
                      _buildLastReadCard(quranProvider),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(HijriCalendar hijri, PrayerProvider prayer) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, d MMMM', 'ar').format(DateTime.now()),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'السلام عليكم',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              prayer.locationName,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimesCard(PrayerProvider provider) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Text('مواقيت الصلاة اليوم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _prayerTimeItem('الفجر', provider.getPrayerTime(Prayer.fajr)),
                _prayerTimeItem('الظهر', provider.getPrayerTime(Prayer.dhuhr)),
                _prayerTimeItem('العصر', provider.getPrayerTime(Prayer.asr)),
                _prayerTimeItem('المغرب', provider.getPrayerTime(Prayer.maghrib)),
                _prayerTimeItem('العشاء', provider.getPrayerTime(Prayer.isha)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _prayerTimeItem(String name, String time) {
    return Column(
      children: [
        Text(name, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionButton(context, Icons.menu_book, 'القرآن الكريم', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const QuranListScreen()));
        }),
        _actionButton(context, Icons.favorite, 'الأذكار', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AthkarScreen()));
        }),
        _actionButton(context, Icons.explore, 'القبلة', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const QiblaScreen()));
        }),
        _actionButton(context, Icons.access_time, 'التنبيهات', () {}),
      ],
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Icon(icon, color: Theme.of(context).primaryColor, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLastReadCard(QuranProvider provider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(Icons.bookmark, color: Theme.of(context).primaryColor),
        title: const Text('آخر ما قرأت'),
        subtitle: Text('سورة البقرة - آية 1'), // Placeholder for dynamic update
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
