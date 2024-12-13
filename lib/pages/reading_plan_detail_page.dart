import 'package:flutter/material.dart';

class ReadingPlanDetailScreen extends StatelessWidget {
  const ReadingPlanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Reading Plan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add_outlined),
            color: Colors.black,
            onPressed: () {
              // Add bookmark action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),

            // Plan Title
            const Text(
              "30-Day Plan",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Journey to Peace: A 30-Day Devotional",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            // Start Plan Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Start Plan action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(160, 40),
                ),
                child: const Text("Start Plan"),
              ),
            ),
            const SizedBox(height: 24),

            // Plan Description
            const Text(
              "Embark on a transformative journey over the next 30 days as we explore the theme of peace through daily scripture readings, reflections, and prayers. Each day's devotional will guide you in cultivating inner tranquility and trusting in God's promises.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Featured Plans Section
            const Text(
              "Featured Plans",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(3, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      SizedBox(
                        width: 110,
                        child: Text(
                          [
                            "Paths of Grace: A 21-Day Journey",
                            "Finding Hope: A 14-Day Devotional",
                            "Embracing Joy: A 30-Day Reflection"
                          ][index],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
