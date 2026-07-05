import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'qr.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 10) return "Selamat pagi";
    if (hour < 15) return "Selamat siang";
    if (hour < 18) return "Selamat sore";
    return "Selamat malam";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_greeting()} 👋",
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ), // TextStyle
                        ), // Text
                        const SizedBox(height: 4),
                        Text(
                          "Selamat datang di\nFlutter QR",
                          style: AppTextStyles.display.copyWith(fontSize: 26),
                        ), // Text
                      ],
                    ), // Column
                  ), // Expanded
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(16),
                    ), // BoxDecoration
                    child: const Icon(
                      Icons.qr_code_2_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ), // Icon
                  ), // Container
                ],
              ), // Row

              const SizedBox(height: 8),

              Text(
                "Mau apa hari ini? Buat QR Code baru atau\npindai QR Code yang sudah ada.",
                style: AppTextStyles.body,
              ), // Text

              const Spacer(),

              // Kartu aksi: Generate
              _ActionCard(
                icon: Icons.qr_code_rounded,
                iconBg: AppColors.primarySoft,
                iconColor: AppColors.primary,
                title: "Generate QR Code",
                subtitle: "Ubah teks atau tautan jadi QR Code",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRPage(initialIndex: 0),
                    ),
                  );
                },
              ), // _ActionCard

              const SizedBox(height: 16),

              // Kartu aksi: Scan
              _ActionCard(
                icon: Icons.qr_code_scanner_rounded,
                iconBg: AppColors.mintSoft,
                iconColor: AppColors.mint,
                title: "Scan QR Code",
                subtitle: "Pindai QR Code lewat kamera",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRPage(initialIndex: 1),
                    ),
                  );
                },
              ), // _ActionCard

              const Spacer(),
            ],
          ), // Column
        ), // Padding
      ), // SafeArea
    ); // Scaffold
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: AppTheme.softShadow,
          ), // BoxDecoration
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ), // BoxDecoration
                child: Icon(icon, color: iconColor, size: 26),
              ), // Container
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.title.copyWith(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.caption),
                  ],
                ), // Column
              ), // Expanded
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.textMuted,
              ), // Icon
            ],
          ), // Row
        ), // Container
      ), // InkWell
    ); // Material
  }
}