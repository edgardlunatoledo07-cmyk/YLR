import 'package:flutter/material.dart';
import 'content.dart';
import 'screens.dart';
import 'state.dart';
import 'style.dart';

class YlrApp extends StatefulWidget {
  const YlrApp({super.key});
  @override
  State<YlrApp> createState() => _YlrAppState();
}

class _YlrAppState extends State<YlrApp> {
  late final YlrState state;
  @override
  void initState() {
    super.initState();
    state = YlrState()..addListener(_refresh);
    state.restore();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    state.removeListener(_refresh);
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Y.LR · Aprender hoy, cuidar siempre',
        theme: yTheme(false, state.contrast),
        darkTheme: yTheme(true, state.contrast),
        themeMode: state.dark ? ThemeMode.dark : ThemeMode.light,
        builder: (context, child) {
          final m = MediaQuery.of(context);
          final baseScale = m.textScaler.scale(16) / 16;
          return MediaQuery(
              data: m.copyWith(
                  textScaler:
                      TextScaler.linear(baseScale * (state.large ? 1.17 : 1))),
              child: child!);
        },
        home: !state.ready
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : state.route == null
                ? _Welcome(state: state)
                : YlrShell(state: state),
      );
}

class _Welcome extends StatelessWidget {
  const _Welcome({required this.state});
  final YlrState state;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: ListView(padding: const EdgeInsets.all(23), children: [
          const SizedBox(height: 20),
          const YBadge('PLATAFORMA EDUCATIVA · BETA'),
          const SizedBox(height: 20),
          const Icon(Icons.favorite_rounded, size: 58, color: YColors.teal),
          yGap(10),
          Text('Y.LR',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontSize: 42),
              textAlign: TextAlign.center),
          Text('APRENDER HOY · CUIDAR SIEMPRE',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),
          yGap(32),
          Text('Aprende a tu ritmo',
              style: Theme.of(context).textTheme.headlineLarge),
          Text(
              'Elige tu ruta educativa. Podrás cambiarla luego sin perder el progreso de las otras.',
              style: Theme.of(context).textTheme.bodyMedium),
          yGap(22),
          ...RouteKind.values.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: YCard(
                  child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: YIcon(
                    r == RouteKind.personal
                        ? Icons.home_rounded
                        : r == RouteKind.tens
                            ? Icons.medical_services_outlined
                            : Icons.school_outlined,
                    color: r == RouteKind.personal
                        ? YColors.rose
                        : r == RouteKind.tens
                            ? YColors.teal
                            : YColors.lilac),
                title: Text(r.label,
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text(r.description,
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => state.chooseRoute(r),
              )))),
          yGap(10),
          const YNotice(
              'Prototipo educativo con contenidos de demostración. No sustituye la formación supervisada ni instrucciones clínicas institucionales.'),
        ])),
      );
}
