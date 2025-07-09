
import 'package:flutter/material.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  final List<Map<String, dynamic>> newsList = [
    {
      'headline': 'Major Crime Alert in City Center',
      'date': DateTime.now().subtract(Duration(hours: 2)),
      'description': 'A robbery was reported at City Center. Police are investigating. Stay alert and report any suspicious activity.',
      'category': 'Crime Alerts',
      'image': Icons.warning,
      'important': true,
    },
    {
      'headline': 'Missing Person: Rohan Patil',
      'date': DateTime.now().subtract(Duration(hours: 5)),
      'description': '16-year-old Rohan Patil has been missing since yesterday. If seen, contact Ahilyanagar Police immediately.',
      'category': 'Missing Persons',
      'image': Icons.person_search,
      'important': true,
    },
    {
      'headline': 'Public Announcement: Road Closure',
      'date': DateTime.now().subtract(Duration(days: 1)),
      'description': 'Main Street will be closed for maintenance from 10 AM to 4 PM tomorrow. Please use alternate routes.',
      'category': 'Public Announcements',
      'image': Icons.announcement,
      'important': false,
    },
    {
      'headline': 'Successful Drug Bust',
      'date': DateTime.now().subtract(Duration(days: 2)),
      'description': 'Police seized illegal substances in a major operation. Several suspects are in custody.',
      'category': 'Law Enforcement Actions',
      'image': Icons.gavel,
      'important': false,
    },
  ];

  String selectedCategory = 'All';
  bool isLoading = false;

  List<String> categories = [
    'All',
    'Crime Alerts',
    'Missing Persons',
    'Public Announcements',
    'Law Enforcement Actions',
  ];

  void refreshNews() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 1));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final filteredNews = selectedCategory == 'All'
        ? newsList
        : newsList.where((n) => n['category'] == selectedCategory).toList();
    final importantNews = filteredNews.where((n) => n['important'] == true).toList();
    final regularNews = filteredNews.where((n) => n['important'] != true).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Updates'),
        actions: [
          IconButton(
            icon: isLoading ? CircularProgressIndicator(color: Colors.white) : Icon(Icons.refresh),
            onPressed: isLoading ? null : refreshNews,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: categories.map((cat) {
                final selected = selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedCategory = cat),
                    selectedColor: Colors.amber.shade700,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Important Notices/Alerts
          if (importantNews.isNotEmpty)
            Column(
              children: importantNews.map((news) => _NewsCard(news: news, highlight: true)).toList(),
            ),
          // News List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: regularNews.map((news) => _NewsCard(news: news)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final Map<String, dynamic> news;
  final bool highlight;
  const _NewsCard({required this.news, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewsDetailPage(news: news),
          ),
        );
      },
      child: Card(
        color: highlight ? Colors.amber.shade100 : Colors.white,
        elevation: highlight ? 6 : 2,
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(news['image'], size: 40, color: highlight ? Colors.amber.shade800 : Colors.blueGrey),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news['headline'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _formatDate(news['date']),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      news['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class NewsDetailPage extends StatelessWidget {
  final Map<String, dynamic> news;
  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Details')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(news['image'], size: 48, color: Colors.blueGrey),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    news['headline'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(_formatDate(news['date']), style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            SizedBox(height: 18),
            Text(news['description'], style: TextStyle(fontSize: 16)),
            // You can add more details, images, or links here
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

