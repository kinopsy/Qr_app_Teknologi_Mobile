import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../theme/app_theme.dart';
import 'scan_result.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController controller = MobileScannerController();
  bool _isNavigating = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isNavigating) return;

    final barcode = capture.barcodes.first.rawValue;
    if (barcode == null) return;

    _isNavigating = true;
    await controller.stop();

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanResultPage(result: barcode),
      ),
    );

    if (!mounted) return;
    await controller.start();
    _isNavigating = false;
  }

  Widget _cornerBracket({required Alignment alignment, required int quarterTurns}) {
    return Align(
      alignment: alignment,
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: CustomPaint(
          size: const Size(36, 36),
          painter: _BracketPainter(color: Colors.white),
        ), // CustomPaint
      ), // RotatedBox
    ); // Align
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scanBoxSize = screenSize.width * 0.7;
    final scanWindowRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height / 2 - 40),
      width: scanBoxSize,
      height: scanBoxSize,
    );

    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          scanWindow: scanWindowRect,
          onDetect: _onDetect,
        ), // MobileScanner

        // Overlay gelap lembut di luar kotak fokus
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            AppColors.textDark.withOpacity(0.55),
            BlendMode.srcOut,
          ), // ColorFilter
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ), // BoxDecoration
              ), // Container full layar
              Align(
                alignment: const Alignment(0, -0.1),
                child: Container(
                  width: scanBoxSize,
                  height: scanBoxSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(28),
                  ), // BoxDecoration lubang
                ), // Container
              ), // Align
            ],
          ), // Stack
        ), // ColorFiltered

        // Bracket sudut ala viewfinder di tepi kotak fokus
        Align(
          alignment: const Alignment(0, -0.1),
          child: SizedBox(
            width: scanBoxSize,
            height: scanBoxSize,
            child: Stack(
              children: [
                _cornerBracket(alignment: Alignment.topLeft, quarterTurns: 0),
                _cornerBracket(alignment: Alignment.topRight, quarterTurns: 1),
                _cornerBracket(alignment: Alignment.bottomRight, quarterTurns: 2),
                _cornerBracket(alignment: Alignment.bottomLeft, quarterTurns: 3),
              ],
            ), // Stack
          ), // SizedBox
        ), // Align

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.textDark.withOpacity(0.85),
              borderRadius: BorderRadius.circular(18),
            ), // BoxDecoration
            child: Text(
              "Arahkan QR Code ke dalam kotak",
              style: AppTextStyles.body.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ), // Text
          ), // Container
        ), // Align
      ],
    ); // Stack
  }
}

class _BracketPainter extends CustomPainter {
  final Color color;

  _BracketPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.55)
      ..lineTo(0, 0)
      ..lineTo(size.width * 0.55, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BracketPainter oldDelegate) => false;
}