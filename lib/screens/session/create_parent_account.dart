import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../core/notify_data.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';
import 'activate_parent_account.dart';

class CreateParentAccount extends StatefulWidget {
  const CreateParentAccount({super.key});

  @override
  State<CreateParentAccount> createState() => _CreateParentAccountState();
}

class _CreateParentAccountState extends State<CreateParentAccount> {
  final _formKey = GlobalKey<FormState>();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final loginCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final session = context.read<SessionProvider>();

    final success = await session.createParentAccount(
      firstName: firstNameCtrl.text,
      lastName: lastNameCtrl.text,
      login: loginCtrl.text,
      password: passwordCtrl.text,
      email: emailCtrl.text,
    );

    if (!mounted) return;

    if (success) {
      _showSuccessDialog();
    } else {
      _showError(session.errorMessage ?? "Error");
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Account Created"),
        content: const Text(
          "A validation code has been sent to your email.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivateParentAccount(
                    email: emailCtrl.text,
                  ),
                ),
              );
            },
            child: const Text("Activate"),
          )
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    loginCtrl.dispose();
    passwordCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();

    return AppScaffold(
      //appBar: AppBar(title: const Text("Create Parent Account")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {}, //context.read<SessionProvider>().login('child'),
                style: Constant.getTitle1ButtonStyle(),
                child: Text("Create Parent Account"),
              ),
            const SizedBox(height: 24),
              _field(firstNameCtrl, "First Name"),
              _field(lastNameCtrl, "Last Name"),
              _field(loginCtrl, "Login"),
              _field(emailCtrl, "Email",
                  keyboardType: TextInputType.emailAddress),
              _field(passwordCtrl, "Password", obscure: true),

              

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonStyle(),
                  onPressed: session.isLoading ? null : _submit,
                  child: session.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Create Account"),
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
