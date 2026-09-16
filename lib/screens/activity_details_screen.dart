import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../theme/app_theme.dart';

/// Pure display of the Activity passed to it -> StatelessWidget.
class ActivityDetailsScreen extends StatelessWidget {
  final Activity activity;

  const ActivityDetailsScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Activity Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : Colors.white,
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.border,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                activity.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkBackground
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                activity.label,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.assignment_late_outlined,
                          text: 'Deadline: ${activity.deadline}',
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(
                          icon: Icons.timer_outlined,
                          text: 'Time: ${activity.time}',
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'OBJECTIVE:',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          activity.objective,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.7,
                            color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Instructions:',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...activity.instructions.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.7,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${item.title} - ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item.description,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
            ),
          ),
        ),
      ],
    );
  }
}
