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
      _showError(session.errorMessage ?? "Error");
    }
  }

  void _showSuccess(NotifyData notifyData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Email Sent"),
        content: const Text(
          "A reset code has been sent to your email.",
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
                child: Text("Reset Password: Received Reset Code"),
              ),
              const SizedBox(height: 24),
              const Text(
                "Enter your email to receive a reset code",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailCtrl,
                validator: (v) =>
                    v == null || v.isEmpty ? "Email required" : null,
                decoration: InputDecoration(
                  labelText: "Email",
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
                      : const Text("Send Reset Code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
