import 'package:flutter/material.dart';

class AthkarScreen extends StatelessWidget {
  const AthkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> athkarCategories = [
      {'title': 'أذكار الصباح', 'count': '30 ذكر'},
      {'title': 'أذكار المساء', 'count': '30 ذكر'},
      {'title': 'أذكار النوم', 'count': '15 ذكر'},
      {'title': 'أذكار بعد الصلاة', 'count': '10 أذكار'},
      {'title': 'أدعية نبوية', 'count': '20 دعاء'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأذكار والأدعية'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: athkarCategories.length,
        itemBuilder: (context, index) {
          final category = athkarCategories[index];
          return InkWell(
            onTap: () {
              // Open details
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: Theme.of(context).primaryColor, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    category['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    category['count']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
