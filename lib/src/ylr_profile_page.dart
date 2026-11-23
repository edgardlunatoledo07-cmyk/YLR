import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'content.dart';
import 'identity_card.dart';
import 'state.dart';
import 'style.dart';

/// Perfil seudónimo de Y.LR. El apodo y avatar son locales;
/// el código de participante viene del documento autenticado.
class YlrProfilePage extends StatefulWidget {
  const YlrProfilePage({
    super.key,
    required this.state,
    required this.onSettings,
    required this.onHome,
  });

  final YlrState state;
  final VoidCallback onSettings;
  final VoidCallback onHome;

  @override
  State<YlrProfilePage> createState() => _YlrProfilePageState();
}

class _YlrProfilePageState extends State<YlrProfilePage> {
  static const _avatars = <IconData>[
    Icons.favorite_rounded,
    Icons.local_hospital_outlined,
    Icons.school_outlined,
    Icons.spa_outlined,
    Icons.psychology_outlined,
    Icons.health_and_safety_outlined,
  ];

  late final TextEditingController _nickname;
  late Future<String> _participantCode;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _nickname = TextEditingController(text: widget.state.nickname);
    _participantCode = _loadParticipantCode();
  }

  Future<String> _loadParticipantCode() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return 'Sin sesión en Firebase';
      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(const GetOptions(source: Source.server))
          .timeout(const Duration(seconds: 12));
      final code = document.data()?['participantCode'];
      return code is String && code.isNotEmpty
          ? code
          : 'Cuenta activa · código no disponible';
    } catch (_) {
      return 'Sin conexión · cuenta local disponible';
    }
  }

  @override
  void dispose() {
    _nickname.dispose();
    super.dispose();
  }

  void _saveNickname() {
    final value = _nickname.text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (value.isNotEmpty &&
        (value.runes.length < 2 ||
            value.runes.length > 24 ||
            !RegExp(r'^[\p{L}\p{N} _-]+$', unicode: true).hasMatch(value))) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Usa entre 2 y 24 caracteres: letras, números, espacios, guiones o _. '),
      ));
      return;
    }
    widget.state.setNickname(value);
    setState(() => _editing = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value.isEmpty
          ? 'Se restauró el nombre predeterminado.'
          : 'Apodo guardado en este dispositivo.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final palette = Theme.of(context).colorScheme;
    final avatarIndex = state.avatarIndex.clamp(0, _avatars.length - 1).toInt();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 7, 16, 30),
      children: [
        const YTitle('Mi perfil',
            subtitle:
                'Tu identidad educativa, preferencias y progreso por ruta.'),
        YCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: YColors.teal.withValues(alpha: .13),
              child: Icon(_avatars[avatarIndex], size: 33, color: YColors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(state.displayName,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text('Perfil educativo · ${state.route?.label ?? 'Sin ruta'}',
                      style: Theme.of(context).textTheme.bodyMedium),
                ])),
          ]),
          const SizedBox(height: 14),
          if (_editing) ...[
            TextField(
              controller: _nickname,
              maxLength: 24,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Apodo (opcional)',
                hintText: 'Ej.: Estudiante TENS',
                helperText: 'Déjalo vacío para usuario.predeterminado',
              ),
              onSubmitted: (_) => _saveNickname(),
            ),
            Wrap(spacing: 8, children: [
              FilledButton.icon(
                onPressed: _saveNickname,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Guardar apodo'),
              ),
              TextButton(
                onPressed: () => setState(() {
                  _nickname.text = state.nickname;
                  _editing = false;
                }),
                child: const Text('Cancelar'),
              ),
            ]),
          ] else ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => setState(() => _editing = true),
              label: const Text('Editar apodo'),
            ),
          ],
          const SizedBox(height: 12),
          Text('Elige un ícono',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: List.generate(
                _avatars.length,
                (i) => Tooltip(
                      message: 'Ícono ${i + 1}',
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => widget.state.setAvatarIndex(i),
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: avatarIndex == i
                                    ? YColors.blue
                                    : palette.outlineVariant,
                                width: avatarIndex == i ? 2.5 : 1),
                            color: avatarIndex == i
                                ? YColors.teal.withValues(alpha: .1)
                                : palette.surface,
                          ),
                          child: Icon(_avatars[i],
                              color: avatarIndex == i
                                  ? YColors.blue
                                  : palette.onSurfaceVariant),
                        ),
                      ),
                    )),
          ),
        ])),
        yGap(12),
        YCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.verified_user_outlined, color: YColors.teal),
            const SizedBox(width: 8),
            Expanded(
                child: Text('Identificador del piloto',
                    style: Theme.of(context).textTheme.titleMedium)),
          ]),
          yGap(8),
          FutureBuilder<String>(
            future: _participantCode,
            builder: (context, snapshot) => SelectableText(
              snapshot.connectionState == ConnectionState.waiting
                  ? 'Consultando Firebase…'
                  : snapshot.data ?? 'No disponible',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: YColors.blue),
            ),
          ),
          yGap(7),
          TextButton.icon(
            onPressed: () =>
                setState(() => _participantCode = _loadParticipantCode()),
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Actualizar código'),
          ),
          Text(
              'Es un código de participante, no una contraseña. La cuenta anónima se conserva en esta instalación; si eliminas los datos de la app podrías perder el acceso hasta vincular otro método de ingreso.',
              style: Theme.of(context).textTheme.bodySmall),
        ])),
        yGap(17),
        YlrIdentityCard(state: state),
        yGap(17),
        Text('Mis rutas educativas',
            style: Theme.of(context).textTheme.titleLarge),
        yGap(9),
        ...RouteKind.values.map((route) {
          final completed = state.completed
              .where((x) => x.startsWith('${route.name}:'))
              .length;
          final routeScores =
              state.scores.where((x) => x.startsWith('${route.name}:')).length;
          final total = lessons.length;
          final selected = state.route == route;
          return Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: YCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(children: [
                    Icon(
                        route == RouteKind.personal
                            ? Icons.home_outlined
                            : route == RouteKind.tens
                                ? Icons.medical_services_outlined
                                : Icons.school_outlined,
                        color: YColors.blue),
                    const SizedBox(width: 9),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(route.label,
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(
                              '$completed/$total lecciones · $routeScores evaluaciones',
                              style: Theme.of(context).textTheme.bodySmall),
                        ])),
                    if (selected)
                      const YBadge('Actual')
                    else
                      TextButton(
                        onPressed: () => widget.state.chooseRoute(route),
                        child: const Text('Cambiar'),
                      ),
                  ]),
                  yGap(9),
                  LinearProgressIndicator(
                    value: total == 0 ? 0 : (completed / total).clamp(0.0, 1.0),
                    minHeight: 7,
                    color: YColors.teal,
                    backgroundColor: palette.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(9),
                  ),
                ])),
          );
        }),
        yGap(8),
        FilledButton.tonalIcon(
          onPressed: widget.onSettings,
          icon: const Icon(Icons.tune_outlined),
          label: const Text('Accesibilidad y preferencias'),
        ),
        yGap(8),
        OutlinedButton.icon(
          onPressed: widget.onHome,
          icon: const Icon(Icons.home_outlined),
          label: const Text('Volver al inicio'),
        ),
        yGap(14),
        const YNotice(
            'Privacidad: apodo y avatar quedan en este dispositivo. Firebase conserva un usuario anónimo y su progreso educativo; no ingreses nombres reales de pacientes, fichas clínicas ni otros datos sensibles. Esta app no certifica competencias clínicas.'),
      ],
    );
  }
}
