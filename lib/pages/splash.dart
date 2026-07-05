import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Animasi 4 bracket sudut merapat membentuk kotak viewfinder
  late final Animation<double> _bracketAnim;
  // Animasi teks & logo muncul setelah bracket selesai
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _bracketAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
    );

    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2600), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _bracket(Alignment alignment, double rotationTurns) {
    return AnimatedBuilder(
      animation: _bracketAnim,
      builder: (context, child) {
        // Setiap bracket datang dari luar (offset lebih jauh) menuju posisi akhir
        final progress = _bracketAnim.value.clamp(0.0, 1.0);
        final startOffset = alignment * 2.2;
        final endOffset = alignment * 1.0;
        final current = Alignment.lerp(startOffset, endOffset, progress)!;

        return Align(
          alignment: current,
          child: Opacity(
            opacity: progress,
            child: RotatedBox(
              quarterTurns: rotationTurns.toInt(),
              child: CustomPaint(
                size: const Size(36, 36),
                painter: _CornerBracketPainter(color: AppColors.primary),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SizedBox(
          width: 220,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Lingkaran lembut di belakang, seperti aperture kamera
              AnimatedBuilder(
                animation: _bracketAnim,
                builder: (context, child) {
                  return Container(
                    width: 150 * _bracketAnim.value,
                    height: 150 * _bracketAnim.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primarySoft,
                    ), // BoxDecoration
                  ); // Container
                },
              ), // AnimatedBuilder lingkaran

              // 4 bracket sudut viewfinder
              _bracket(const Alignment(-1, -1), 0), // kiri atas
              _bracket(const Alignment(1, -1), 1), // kanan atas
              _bracket(const Alignment(1, 1), 2), // kanan bawah
              _bracket(const Alignment(-1, 1), 3), // kiri bawah

              // Icon QR di tengah
              FadeTransition(
                opacity: _bracketAnim,
                child: const Icon(
                  Icons.qr_code_rounded,
                  size: 46,
                  color: AppColors.primary,
                ), // Icon
              ), // FadeTransition

              // Badge + nama aplikasi, muncul setelah bracket selesai
              Positioned(
                bottom: -78,
                child: SlideTransition(
                  position: _textSlide,
                  child: FadeTransition(
                    opacity: _textFade,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(20),
                          ), // BoxDecoration
                          child: Text(
                            "QR APP",
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ), // TextStyle
                          ), // Text
                        ), // Container badge
                        const SizedBox(height: 12),
                        Text("Flutter QR", style: AppTextStyles.display),
                        const SizedBox(height: 6),
                        Text(
                          "Generate & scan, secepat kedipan mata",
                          style: AppTextStyles.caption,
                        ), // Text
                      ],
                    ), // Column
                  ), // FadeTransition
                ), // SlideTransition
              ), // Positioned
            ],
          ), // Stack
        ), // SizedBox
      ), // Center
    ); // Scaffold
  }
}

// Painter untuk satu bracket sudut ala viewfinder kamera (┌ shape)
class _CornerBracketPainter extends CustomPainter {
  final Color color;

  _CornerBracketPainter({required this.color});

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
  bool shouldRepaint(covariant _CornerBracketPainter oldDelegate) => false;
}