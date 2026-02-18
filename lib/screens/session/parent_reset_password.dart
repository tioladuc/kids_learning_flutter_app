import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';

class ParentResetPassword extends StatefulWidget {
  final String email;

  const ParentResetPassword({
    super.key,
    required this.email,
  });

  @override
  State<ParentResetPassword> createState() =>
      _ParentResetPasswordState();
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

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordCtrl.text != confirmCtrl.text) {
      _showError("Passwords do not match");
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
      _showSuccess();
    } else {
      _showError(session.errorMessage ?? "Error");
    }
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Password reset successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              // Back to login or root
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Continue"),
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

    return AppScaffold(
      //appBar: AppBar(title: const Text("Reset Password")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {}, //context.read<SessionProvider>().login('child'),
                style: Constant.getTitle1ButtonStyle(),
                child: Text("Reset Password"),
              ),
            const SizedBox(height: 24),
              const Text(
                "Enter your email, reset code and new password",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              _field(emailCtrl, "Email",
                  keyboardType: TextInputType.emailAddress),
              _field(codeCtrl, "Reset Code"),
              _field(passwordCtrl, "New Password", obscure: true),
              _field(confirmCtrl, "Confirm Password", obscure: true),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonStyle(),
                  onPressed: session.isLoading ? null : _resetPassword,
                  child: session.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Reset Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
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
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
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
