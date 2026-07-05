import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';

class GenerateQRPage extends StatelessWidget {
  final String data = "https://is.uad.ac.id";

  const GenerateQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: AppTheme.softShadow,
              ), // BoxDecoration
              child: QrImageView(
                data: data,
                version: QrVersions.auto,
                size: 220,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.circle,
                  color: AppColors.textDark,
                ), // QrEyeStyle
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: AppColors.primary,
                ), // QrDataModuleStyle
              ), // QrImageView
            ), // Container

            const SizedBox(height: 28),

            Text(
              "Data yang dikodekan",
              style: AppTextStyles.caption,
            ), // Text

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
              ), // BoxDecoration
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      data,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500,
                      ), // TextStyle
                    ), // Text
                  ), // Expanded
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: data));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.textDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ), // RoundedRectangleBorder
                          content: Text(
                            "Disalin ke clipboard",
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                            ), // TextStyle
                          ), // Text
                        ), // SnackBar
                      );
                    },
                    child: const Icon(
                      Icons.copy_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ), // Icon
                  ), // GestureDetector
                ],
              ), // Row
            ), // Container
          ],
        ), // Column
      ), // Padding
    ); // Center
  }
}