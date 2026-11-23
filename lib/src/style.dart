import 'package:flutter/material.dart';

class YColors {
  static const navy = Color(0xFF071C4A);
  static const blue = Color(0xFF0F72AA);
  static const blue2 = Color(0xFF1286B2);
  static const teal = Color(0xFF16AD9F);
  static const lilac = Color(0xFF7458E9);
  static const rose = Color(0xFFEA536A);
  static const background = Color(0xFFF7FAFD);
  static const muted = Color(0xFF586C8D);
  static const border = Color(0xFFE1EAF3);
}

ThemeData yTheme(bool dark, bool contrast) {
  final scheme = ColorScheme.fromSeed(
    seedColor: YColors.blue,
    brightness: dark ? Brightness.dark : Brightness.light,
    surface: dark ? const Color(0xFF101D31) : Colors.white,
    primary: dark ? const Color(0xFF69C7E5) : YColors.blue,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor:
        dark ? const Color(0xFF091526) : YColors.background,
    appBarTheme: AppBarTheme(
        backgroundColor: dark ? const Color(0xFF091526) : YColors.background,
        elevation: 0),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontSize: 29,
          fontWeight: FontWeight.w800,
          color: dark ? Colors.white : YColors.navy,
          letterSpacing: -0.6),
      headlineSmall: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w800,
          color: dark ? Colors.white : YColors.navy),
      titleLarge: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w800,
          color: dark ? Colors.white : YColors.navy),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: dark ? Colors.white : YColors.navy),
      bodyMedium: TextStyle(
          fontSize: 14.5,
          height: 1.43,
          color: dark ? const Color(0xFFD7E4F5) : YColors.muted),
    ),
    cardTheme: CardThemeData(
      elevation: contrast ? 1 : 0,
      color: scheme.surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: contrast
                  ? YColors.blue
                  : (dark ? const Color(0xFF2B3B53) : YColors.border))),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: YColors.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: YColors.border)),
    ),
  );
}

class YCard extends StatelessWidget {
  const YCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(16),
      this.color});
  final Widget child;
  final EdgeInsets padding;
  final Color? color;
  @override
  Widget build(BuildContext context) => Card(
        color: color,
        child: Padding(padding: padding, child: child),
      );
}

class YTitle extends StatelessWidget {
  const YTitle(this.title, {super.key, this.subtitle});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ]),
      );
}

class YButton extends StatelessWidget {
  const YButton(this.label,
      {super.key,
      required this.onPressed,
      this.icon = Icons.arrow_forward_rounded});
  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: Text(label,
              style:
                  const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700)),
          style: FilledButton.styleFrom(
            backgroundColor: YColors.blue,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
}

class YIcon extends StatelessWidget {
  const YIcon(this.icon,
      {super.key, this.color = YColors.blue, this.background, this.size = 22});
  final IconData icon;
  final Color color;
  final Color? background;
  final double size;
  @override
  Widget build(BuildContext context) => Container(
        height: size + 27,
        width: size + 27,
        decoration: BoxDecoration(
            color: background ?? color.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(15)),
        child: Icon(icon, size: size, color: color),
      );
}

class YNotice extends StatelessWidget {
  const YNotice(this.text, {super.key, this.icon = Icons.info_outline_rounded});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: YColors.blue.withValues(alpha: .075),
            borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(14),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: YColors.blue),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ]),
      );
}

class YBadge extends StatelessWidget {
  const YBadge(this.text, {super.key, this.color = YColors.teal});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
            color: color.withValues(alpha: .11),
            borderRadius: BorderRadius.circular(30)),
        child: Text(text,
            style: TextStyle(
                fontSize: 11.5, fontWeight: FontWeight.w700, color: color)),
      );
}

Widget yGap([double height = 14]) => SizedBox(height: height);
