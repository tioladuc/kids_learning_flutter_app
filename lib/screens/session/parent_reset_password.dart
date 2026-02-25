import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constance_session.dart';
import '../../core/constances.dart';
import '../../core/notify_data.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';

class ParentResetPassword extends StatefulWidget {
  final String email;

  const ParentResetPassword({
    super.key,
    required this.email,
  });

  @override
  State<ParentResetPassword> createState() => _ParentResetPasswordState();
}

class _ParentResetPasswordState extends State<ParentResetPassword> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailCtrl;
  final codeCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController(text: widget.email);
  }

  Future<void> _resetPassword(NotifyData notifyData) async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordCtrl.text != confirmCtrl.text) {
      _showError((notifyData.currentLanguage == Constant.languageEN
          ? ConstantSession.ParentResetPasswordPasswordsNotMatchEN
          : ConstantSession.ParentResetPasswordPasswordsNotMatchFR));
      return;
    }

    final session = context.read<SessionProvider>();

    final success = await session.resetPassword(
      email: emailCtrl.text,
      code: codeCtrl.text,
      newPassword: passwordCtrl.text,
    );

    if (!mounted) return;

    if (success) {
      _showSuccess(notifyData);
    } else {
      _showError(session.errorMessage ??
          (notifyData.currentLanguage == Constant.languageEN
              ? ConstantSession.ParentResetPasswordErrorEN
              : ConstantSession.ParentResetPasswordErrorFR));
    }
  }

  void _showSuccess(NotifyData notifyData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text((notifyData.currentLanguage == Constant.languageEN
            ? ConstantSession.ParentResetPasswordSuccessEN
            : ConstantSession.ParentResetPasswordSuccessFR)),
        content: Text((notifyData.currentLanguage == Constant.languageEN
            ? ConstantSession.ParentResetPasswordPasswordResetSuccessfullyEN
            : ConstantSession.ParentResetPasswordPasswordResetSuccessfullyFR)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              // Back to login or root
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text((notifyData.currentLanguage == Constant.languageEN
                ? ConstantSession.ParentResetPasswordContinueEN
                : ConstantSession.ParentResetPasswordContinueFR)),
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
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();

    return AppScaffold(
      //appBar: AppBar(title: const Text("Reset Password")),
      body: SingleChildScrollView(
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
                    ? ConstantSession.ParentResetPasswordResetPasswordEN
                    : ConstantSession.ParentResetPasswordResetPasswordFR)),
              ),
              const SizedBox(height: 24),
              Text(
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantSession.ParentResetPasswordEnterYourEmailEN
                    : ConstantSession.ParentResetPasswordEnterYourEmailFR),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _field(notifyData,
                  emailCtrl,
                  (notifyData.currentLanguage == Constant.languageEN
                      ? ConstantSession.ParentResetPasswordEmailEN
                      : ConstantSession.ParentResetPasswordEmailFR),
                  keyboardType: TextInputType.emailAddress),
              _field(notifyData,
                  codeCtrl,
                  (notifyData.currentLanguage == Constant.languageEN
                      ? ConstantSession.ParentResetPasswordResetCodeEN
                      : ConstantSession.ParentResetPasswordResetCodeFR)),
              _field(notifyData,
                  passwordCtrl,
                  (notifyData.currentLanguage == Constant.languageEN
                      ? ConstantSession.ParentResetPasswordNewPasswordEN
                      : ConstantSession.ParentResetPasswordNewPasswordFR),
                  obscure: true),
              _field(notifyData,
                  confirmCtrl,
                  (notifyData.currentLanguage == Constant.languageEN
                      ? ConstantSession.ParentResetPasswordConfirmPasswordEN
                      : ConstantSession.ParentResetPasswordConfirmPasswordFR),
                  obscure: true),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonStyle(),
                  onPressed: () {
                    session.isLoading ? null : _resetPassword(notifyData);
                  },
                  child: session.isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantSession
                                  .ParentResetPasswordResetPasswordBtnEN
                              : ConstantSession
                                  .ParentResetPasswordResetPasswordBtnFR)),
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
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        obscureText: obscure,
        keyboardType: keyboardType,
        validator: (v) => v == null || v.isEmpty
            ? (notifyData.currentLanguage == Constant.languageEN
                ? ConstantSession.ParentResetPasswordRequiredEN
                : ConstantSession.ParentResetPasswordRequiredFR)
            : null,
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
