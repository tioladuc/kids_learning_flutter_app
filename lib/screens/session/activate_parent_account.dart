import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
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
        notifyData: notifyData,
          message:
              (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ActivationSuccessMessageEN
                    : ConstantSession.ActivationSuccessMessageFR),
          returnLogin: true);
    } else {
      _showError(session.errorMessage ?? (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ActivationErrorMessageEN
                    : ConstantSession.ActivationErrorMessageFR));
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
        notifyData: notifyData,
          message: (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ResendActivationCodeEN
                    : ConstantSession.ResendActivationCodeFR),
          returnLogin: false);
    } else {
      _showError(session.errorMessage ?? (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ResendActivationErrorMessageEN
                    : ConstantSession.ResendActivationErrorMessageFR));
    }
  }

  void _showSuccess(NotifyData notifyData, {String message = '', bool returnLogin = true}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.SuccessMessageEN
                    : ConstantSession.SuccessMessageFR)),
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
            child: const Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ContinueMessageEN
                    : ConstantSession.ContinueMessageFR)),
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

    return AppScaffold(
      //appBar: AppBar(title: const Text("Activate Account")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed:
                    () {}, //context.read<SessionPro_resendActivationCodevider>().login('child'),
                style: Constant.getTitle1ButtonStyle(),
                child: Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ActivateAccountEN
                    : ConstantSession.ActivateAccountFR)),
              ),
              const SizedBox(height: 24),
              const Text(
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.EnterActivationCodeEN
                    : ConstantSession.EnterActivationCodeFR),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _field(
                  notifyData,
                  emailCtrl,
                  "Email",
                  keyboardType: TextInputType.emailAddress,
                  notifyData),
              _field(notifyData, codeCtrl, (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ActivationCodeEN
                    : ConstantSession.ActivationCodeFR),
                  keyboardType: TextInputType.text, addValidator: false),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonStyle(),
                  onPressed: (){session.isLoading ? null : _activate(notifyData)},
                  child: session.isLoading
                      ? const CircularProgressIndicator()
                      : const Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ActivateAccountBetaEN
                    : ConstantSession.ActivateAccountBetaFR)),
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
                      : const Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ResendActivationCodeBetaEN
                    : ConstantSession.ResendActivationCodeBetaFR)),
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
            addValidator ? (v == null || v.isEmpty ? (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.RequiredEN
                    : ConstantSession.RequiredFR) : null) : null,
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
