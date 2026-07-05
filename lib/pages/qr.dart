import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'generate_qr.dart';
import 'scan.dart';

class QRPage extends StatefulWidget {
  final int initialIndex;

  const QRPage({super.key, this.initialIndex = 0});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  late int _selectedIndex = widget.initialIndex;

  final List<Widget> _pages = const [
    GenerateQRPage(),
    ScanPage(),
  ];

  final List<String> _titles = const [
    "Generate QR Code",
    "Scan QR Code",
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primarySoft : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ), // BoxDecoration
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? AppColors.primary : AppColors.textMuted,
                size: 24,
              ), // Icon
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: isActive ? AppColors.primary : AppColors.textMuted,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ), // TextStyle
              ), // Text
            ],
          ), // Column
        ), // AnimatedContainer
      ), // GestureDetector
    ); // Expanded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ), // IndexedStack
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppTheme.softShadow,
          ), // BoxDecoration
          child: Row(
            children: [
              _navItem(
                icon: Icons.qr_code_rounded,
                label: "Generate",
                index: 0,
              ), // _navItem
              _navItem(
                icon: Icons.qr_code_scanner_rounded,
                label: "Scan",
                index: 1,
              ), // _navItem
            ],
          ), // Row
        ), // Container
      ), // Padding
    ); // Scaffold
  }
}