import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class ScanResultPage extends StatelessWidget {
  final String result;

  const ScanResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Scan")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mintSoft,
                ), // BoxDecoration
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.mint,
                  size: 52,
                ), // Icon
              ), // Container

              const SizedBox(height: 24),

              Text(
                "QR Code berhasil dipindai",
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ), // Text

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppTheme.softShadow,
                ), // BoxDecoration
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        result,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w500,
                        ), // TextStyle
                      ), // Text
                    ), // Expanded
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: result));
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

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ), // RoundedRectangleBorder
                  ), // ButtonStyle
                  icon: const Icon(Icons.qr_code_scanner_rounded,
                      color: Colors.white),
                  label: Text("Scan Lagi", style: AppTextStyles.button),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ), // ElevatedButton
              ), // SizedBox
            ],
          ), // Column
        ), // Padding
      ), // Center
    ); // Scaffold
  }
}