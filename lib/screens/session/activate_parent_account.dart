import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../core/core_translator.dart';
import '../../core/notify_data.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';

class ActivateParentAccount extends StatefulWidget {
  final String email;

  const ActivateParentAccount({
    super.key,
    required this.email,
  });

  @override
  State<ActivateParentAccount> createState() => _ActivateParentAccountState();
}

class _ActivateParentAccountState extends State<ActivateParentAccount> {
  final _formKey = GlobalKey<FormState>();
  Translator translator = Translator();

  late TextEditingController emailCtrl;
  final codeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController(text: widget.email);
  }

  Future<void> _activate(NotifyData notifyData) async {
    if (!_formKey.currentState!.validate()) return;

    final session = context.read<SessionProvider>();

    final success = await session.activateParentAccount(
      email: emailCtrl.text,
      code: codeCtrl.text,
    );

    if (!mounted) return;

    if (success) {
      _showSuccess(
        notifyData,
          message:
              translator.getText('ActivationSuccessMessage'),
          returnLogin: true);
    } else {
      _showError(session.errorMessage ?? translator.getText('ActivationErrorMessage'));
    }
  }

  Future<void> _resendActivationCode(NotifyData notifyData) async {
    if (!_formKey.currentState!.validate()) return;

    final session = context.read<SessionProvider>();

    final success = await session.resendActivationCode(
      email: emailCtrl.text,
    );

    if (!mounted) return;

    if (success) {
      _showSuccess(
        notifyData,
          message: translator.getText('ResendActivationCode'),
          returnLogin: false);
    } else {
      _showError(session.errorMessage ?? translator.getText('ResendActivationErrorMessage'));
    }
  }

  void _showSuccess(NotifyData notifyData, {String message = '', bool returnLogin = true}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(translator.getText('SuccessMessage')),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              if (returnLogin) {
                // back to login/home
                Navigator.pop(context);

                // back to login/home
                Navigator.pop(context);
              }
            },
            child: Text(translator.getText('ContinueMessage')),
          )
        ],
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final NotifyData notifyData = context.watch<NotifyData>();
    translator = Translator(status: StatusLangue.CONSTANCE_SESSION, lang: notifyData.currentLanguage);

    return AppScaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed:
                    () {}, 
                style: Constant.getTitle1ButtonStyle(),
                child: Text(translator.getText('ActivateAccount')),
              ),
              const SizedBox(height: 24),
              Text(translator.getText('EnterActivationCode'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _field(
                  notifyData,
                  emailCtrl,
                  "Email",
                  keyboardType: TextInputType.emailAddress
                  ),
              _field(notifyData, codeCtrl, translator.getText('ActivationCode'),
                  keyboardType: TextInputType.text, addValidator: false),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonStyle(),
                  onPressed: (){session.isLoading ? null : _activate(notifyData);},
                  child: session.isLoading
                      ? const CircularProgressIndicator()
                      : Text(translator.getText('ActivateAccountBeta')),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonRedStyle(),
                  onPressed: () {
                    session.isActivationCodeSending
                        ? null
                        : _resendActivationCode(notifyData);
                  },
                  child: session.isActivationCodeSending
                      ? const CircularProgressIndicator()
                      : Text(translator.getText('ResendActivationCodeBeta')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    NotifyData notifyData,
    TextEditingController ctrl,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    bool addValidator = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        validator: (v) =>
            addValidator ? (v == null || v.isEmpty ? translator.getText('Required') : null) : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
