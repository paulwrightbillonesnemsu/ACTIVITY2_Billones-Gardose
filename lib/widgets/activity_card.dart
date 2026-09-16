import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../theme/app_theme.dart';

/// Purely presentational -> StatelessWidget, per the "Widget Architecture"
/// requirement. All it needs is data (the activity) and a callback.
class ActivityCard extends StatelessWidget {
  final Activity activity;
  final IconData leadingIcon;
  final VoidCallback onViewActivity;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.onViewActivity,
    this.leadingIcon = Icons.access_time_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative gradient orb, matching the Figma "blur" accent.
          Positioned(
            right: -45,
            top: -95,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      leadingIcon,
                      size: 15,
                      color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      activity.label.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.7,
                        color:
                            isDark ? AppColors.textWhiteSoft : AppColors.textGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  activity.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 14,
                      color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      activity.dateDisplay,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? AppColors.textWhiteSoft : AppColors.textGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onViewActivity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Activity',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
