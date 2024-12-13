import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/daily_devotion.dart';

class DailyDevotionScreen extends StatelessWidget {
  const DailyDevotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data
    final List<DailyDevotion> dailyDevotions = [
      DailyDevotion(
        date: DateTime(2024, 12, 9),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: true,
      ),
      DailyDevotion(
        date: DateTime(2024, 12, 10),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: true,
      ),
      DailyDevotion(
        date: DateTime(2024, 12, 11),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: false,
      ),
      DailyDevotion(
        date: DateTime(2024, 12, 12),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: true,
      ),
      DailyDevotion(
        date: DateTime(2024, 12, 13),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: false,
      ),
      DailyDevotion(
        date: DateTime(2024, 12, 14),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: false,
      ),
      DailyDevotion(
        date: DateTime(2024, 13, 14),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: false,
      ),
      DailyDevotion(
        date: DateTime(2024, 14, 14),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: false,
      ),
      DailyDevotion(
        date: DateTime(2024, 15, 14),
        scripture: "Proverbs 3:5-6 (NIV)",
        isCompleted: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Daily Devotion",
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
          children: List.generate(dailyDevotions.length, (index) {
            final devotion = dailyDevotions[index];
            return _buildTimelineItem(
              date: devotion.date,
              scripture: devotion.scripture,
              isCompleted: devotion.isCompleted,
              isFirst: index == 0,
              isLast: index == dailyDevotions.length - 1,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required DateTime date,
    required String scripture,
    required bool isCompleted,
    required bool isFirst,
    required bool isLast,
  }) {
    // Current date
    final currentDate = DateTime.now();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline
        Column(
          children: [
            // Top Line (Always visible, even for the first item)
            Container(
              height: 43.48, // Adjust for a seamless look
              width: 2,
              color: isFirst?Colors.transparent: isCompleted
                      ? Colors.black
                      : Colors.grey[300],
            ),
            // Circle
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.black : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            // Bottom Line (Always visible, even for the last item)
            Container(
              height: 43.48, // Adjust for a seamless look
              width: 2,
              color: isLast
                  ? Colors.transparent
                  : isCompleted
                      ? Colors.black
                      : Colors.grey[300],
            ),
          ],
        ),
        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
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
                          DateFormat('MMMM dd, yyyy').format(date), // Format date
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          scripture,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCompleted ? Colors.black : Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        
                      ],
                      
                    ),
                    date.year == currentDate.year &&
                            date.month == currentDate.month &&
                            date.day == currentDate.day
                        ? const Icon(Icons.arrow_forward, color: Colors.black)
                        : isCompleted
                            ? const Icon(Icons.check_circle,
                                color: Colors.black)
                            : const Icon(Icons.cancel, color: Colors.grey),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
