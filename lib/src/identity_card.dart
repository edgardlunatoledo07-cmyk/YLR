import 'package:flutter/material.dart';

import 'identity.dart';
import 'state.dart';
import 'style.dart';

/// Vincula la cuenta anonima con un email para que el progreso sea
/// recuperable. Los datos locales no dependen del uid y no se pierden.
class YlrIdentityCard extends StatefulWidget {
  const YlrIdentityCard({super.key, required this.state});
  final YlrState state;
  @override
  State<YlrIdentityCard> createState() => _YlrIdentityCardState();
}

class _YlrIdentityCardState extends State<YlrIdentityCard> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  bool _showForm = false;
  bool _offerSignIn = false;
  String? _message;
  bool _error = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _link() async {
    setState(() {
      _busy = true;
      _message = null;
    });
    final outcome = await YlrIdentity.linkWithEmail(
      email: _email.text,
      password: _password.text,
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = false;
      switch (outcome) {
        case YlrLinkOutcome.linked:
          _message = 'Cuenta vinculada. La recuperación del progreso desde otro dispositivo estará disponible en una próxima etapa.';
          _showForm = false;
        case YlrLinkOutcome.emailInUse:
          _message = 'Ese email ya tiene cuenta.';
          _showForm = false;
          _offerSignIn = true;
        case YlrLinkOutcome.cancelled:
          _message = 'Revisá el email y usá al menos 6 caracteres de contraseña.';
          _error = true;
        case YlrLinkOutcome.failed:
          _message = 'No se pudo vincular. Intentá de nuevo.';
          _error = true;
      }
    });
  }

  Future<void> _signInExisting() async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Entrar en una cuenta existente'),
        content: const Text(
          'El progreso de este teléfono se conserva, pero no se fusiona. '
          'El próximo respaldo reemplazará la copia en la nube de esa cuenta '
          'con el progreso local de este teléfono.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Entrar igual'),
          ),
        ],
      ),
    );
    if (approved != true || !mounted) return;

    setState(() => _busy = true);
    final appState = widget.state;
    final ok = await YlrIdentity.signInToExisting(
      email: _email.text,
      password: _password.text,
    );
    // El UID pudo cambiar aunque la tarjeta dejara de estar montada.
    // La invalidacion no debe depender del ciclo de vida de esta interfaz.
    if (ok) {
      appState.invalidateSync();
      await appState.save();
    }
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = !ok;
      _offerSignIn = false;
      _message = ok
          ? 'Entraste en esa cuenta. El próximo respaldo reemplazará '
              'su copia en la nube con el progreso local de este teléfono.'
          : 'No se pudo entrar en la cuenta existente.';
    });
  }

  @override
  Widget build(BuildContext context) => YCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.key_outlined, color: YColors.blue),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Cuenta recuperable',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ]),
            const SizedBox(height: 8),
            Text(
              'Hoy tu cuenta es anónima: si borrás los datos de la app, '
              'perdés el acceso al respaldo. Vinculá un email para evitarlo.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (_message != null) ...[
              const SizedBox(height: 10),
              YNotice(_message!,
                  icon: _error ? Icons.info_outline : Icons.check_circle_outline),
            ],
            if (_showForm) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  helperText: 'Mínimo 6 caracteres',
                ),
              ),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [
                FilledButton.icon(
                  onPressed: _busy ? null : _link,
                  icon: const Icon(Icons.link_rounded),
                  label: const Text('Vincular'),
                ),
                TextButton(
                  onPressed: _busy ? null : () => setState(() => _showForm = false),
                  child: const Text('Cancelar'),
                ),
              ]),
            ] else if (_offerSignIn) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _busy ? null : _signInExisting,
                icon: const Icon(Icons.login_rounded),
                label: const Text('Entrar en esa cuenta'),
              ),
            ] else ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _busy ? null : () => setState(() => _showForm = true),
                icon: const Icon(Icons.add_link_rounded),
                label: const Text('Vincular email'),
              ),
            ],
            if (_busy) ...[
              const SizedBox(height: 10),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      );
}
