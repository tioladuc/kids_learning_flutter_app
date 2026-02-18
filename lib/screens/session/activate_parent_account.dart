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
  State<ActivateParentAccount> createState() =>
      _ActivateParentAccountState();
}

class _ActivateParentAccountState
    extends State<ActivateParentAccount> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailCtrl;
  final codeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController(text: widget.email);
  }

  Future<void> _activate() async {
    if (!_formKey.currentState!.validate()) return;

    final session = context.read<SessionProvider>();

    final success = await session.activateParentAccount(
      email: emailCtrl.text,
      code: codeCtrl.text,
    );

    if (!mounted) return;

    if (success) {
      _showSuccess( message: "Your account has been activated successfully. You can now login!", returnLogin: true);
    } else {
      _showError(session.errorMessage ?? "Error");
    }
  }

  Future<void> _resendActivationCode() async {
    if (!_formKey.currentState!.validate()) return;

    final session = context.read<SessionProvider>();

    final success = await session.resendActivationCode(
      email: emailCtrl.text,
    );

    if (!mounted) return;

    if (success) {
      _showSuccess( message: "Activation code has been sent into your mailbox.", returnLogin: false);
    } else {
      _showError(session.errorMessage ?? "Error");
    }
  }

  void _showSuccess({String message = '', 
  bool returnLogin = true}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              if(returnLogin) {
                // back to login/home
              Navigator.pop(context);

              // back to login/home
              Navigator.pop(context);
              }
              
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();

    return AppScaffold(
      //appBar: AppBar(title: const Text("Activate Account")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {}, //context.read<SessionPro_resendActivationCodevider>().login('child'),
                style: Constant.getTitle1ButtonStyle(),
                child: Text("Activate Account"),
              ),
            const SizedBox(height: 24),
              const Text(
                "Enter the activation code sent by email",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              _field(emailCtrl, "Email",
                  keyboardType: TextInputType.emailAddress),
              _field(codeCtrl, "Activation Code", keyboardType:TextInputType.text, addValidator: false),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonStyle(),
                  onPressed: session.isLoading ? null : _activate,
                  child: session.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Activate Account"),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Constant.getTitle3ButtonRedStyle(),
                  onPressed: session.isActivationCodeSending ? null : _resendActivationCode,
                  child: session.isActivationCodeSending
                      ? const CircularProgressIndicator()
                      : const Text("Resend Activation Code"),
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
    TextInputType keyboardType = TextInputType.text,
    bool addValidator = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        validator: (v) => addValidator ? (v == null || v.isEmpty ? "Required" : null) : null,
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
