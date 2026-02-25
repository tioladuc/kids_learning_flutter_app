import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';
import 'parent_reset_password.dart';

class ParentReset extends StatefulWidget {
  const ParentReset({super.key});

  @override
  State<ParentReset> createState() => _ParentResetState();
}

class _ParentResetState extends State<ParentReset> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();

  Future<void> _sendCode(NotifyData notifyData) async {
    if (!_formKey.currentState!.validate()) return;

    final session = context.read<SessionProvider>();

    final success = await session.sendResetCode(
      email: emailCtrl.text,
    );

    if (!mounted) return;

    if (success) {
      _showSuccess(notifyData);
    } else {
      _showError(session.errorMessage ??
          (notifyData.currentLanguage == Constant.languageEN
              ? ConstantSession.ParentResetErrorMsgEN
              : ConstantSession.ParentResetErrorMsgFR));
    }
  }

  void _showSuccess(NotifyData notifyData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text((notifyData.currentLanguage == Constant.languageEN
            ? ConstantSession.ParentResetEmailSentEN
            : ConstantSession.ParentResetEmailSentFR)),
        content: const Text(
          (notifyData.currentLanguage == Constant.languageEN
              ? ConstantSession.ParentResetEmailSentMsgEN
              : ConstantSession.ParentResetEmailSentMsgFR),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ParentResetPassword(
                    email: emailCtrl.text,
                  ),
                ),
              );
            },
            child: const Text((notifyData.currentLanguage == Constant.languageEN
                ? ConstantSession.ParentResetContinueEN
                : ConstantSession.ParentResetContinueFR)),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();

    return AppScaffold(
      //appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed:
                    () {}, //context.read<SessionProvider>().login('child'),
                style: Constant.getTitle1ButtonStyle(),
                child: Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession
                        .ParentResetResetPasswordReceivedResetCodeEN
                    : ConstantSession
                        .ParentResetResetPasswordReceivedResetCodeFR)),
              ),
              const SizedBox(height: 24),
              const Text(
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ParentResetEnterYourEmailEN
                    : ConstantSession.ParentResetEnterYourEmailFR),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailCtrl,
                validator: (v) => v == null || v.isEmpty
                    ? (notifyData.currentLanguage == Constant.languageEN
                        ? ConstantSession.ParentResetEmailRequiredEN
                        : ConstantSession.ParentResetEmailRequiredFR)
                    : null,
                decoration: InputDecoration(
                  labelText: (notifyData.currentLanguage == Constant.languageEN
                      ? ConstantSession.ParentResetEmailEN
                      : ConstantSession.ParentResetEmailFR),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonStyle(),
                  onPressed: () {
                    session.isLoading ? null : _sendCode(notifyData);
                  },
                  child: session.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantSession.ParentResetSendResetCodeBtnEN
                              : ConstantSession.ParentResetSendResetCodeBtnFR)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
