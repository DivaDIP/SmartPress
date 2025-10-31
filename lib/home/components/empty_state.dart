import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartpress_app/utils/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ikon di bagian atas
             FaIcon(
              FontAwesomeIcons.newspaper,
              size: 120,
              color: Colors.grey,
            ),

            SizedBox(height: 32),

            // Judul
            Text(
              'No news available',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: 8),

            // 💬 Deskripsi
            Text(
              'Please try again later',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),

           SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}
