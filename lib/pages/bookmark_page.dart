import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Bookmarks",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saved Reading Plans
            _buildSectionHeader("Saved Reading Plans", onSeeAll: () {}),
            _buildLargePlaceholder(),

            const SizedBox(height: 24),

            // Verses to Memorize
            _buildSectionHeader("Verses to Memorize", onSeeAll: () {}),
            _buildLargePlaceholder(),

            const SizedBox(height: 24),

            // Important Highlights
            _buildSectionHeader("Important Highlights", onSeeAll: () {}),
            _buildGridPlaceholder(),

            const SizedBox(height: 24),

            // Saved Testimonials
            _buildSectionHeader("Saved Testimonials", onSeeAll: () {}),
            _buildTestimonialCard(
              name: "Saw Aung Thin",
              date: "Oct 12, 2024",
              content:
                  "There was a time when everything around me seemed to crumble. I was battling anxiety, and every day felt like an uphill battle. But when I turned to God in prayer, a sense of peace washed over me. It didn't happen overnight, but over...",
            ),
          ],
        ),
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            "See All",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Placeholder for large sections (Reading Plans, Verses to Memorize)
  Widget _buildLargePlaceholder() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  // Grid Placeholder for Highlights
  Widget _buildGridPlaceholder() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        6,
        (index) => Container(
          width: (MediaQuery.of(context).size.width - 48) / 3, // Dynamic size for grid items
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Testimonial Card Widget
  Widget _buildTestimonialCard({
    required String name,
    required String date,
    required String content,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 14),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
