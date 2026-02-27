import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/notify_data.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/main_intro_screen_child.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../core/core_translator.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_footer.dart';
import '../../widgets/app_scaffold.dart';
import '../audio/audio_list_screen.dart';
import '../introscreen/main_intro_screen_parent.dart';
import 'create_parent_account.dart';
import 'parent_reset.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final controllerLogin = TextEditingController();
  final controllerPwd = TextEditingController();
  SessionProvider _sessionProvider = SessionProvider();
  Translator translator = Translator();

  String selectedProfile = "";

  void chooseLoginChoice(String choice) {
    setState(() {
      selectedProfile = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    translator = Translator(status: StatusLangue.CONSTANCE_SESSION, lang: notifyData.currentLanguage);
    final sessionProvider = context.watch<SessionProvider>();
    _sessionProvider = sessionProvider;

    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedProfile != '')
              ElevatedButton(
                onPressed: () => chooseLoginChoice(
                  '',
                ),
                style: Constant.getTitle1ButtonStyle(),
                child: Text(translator.getText('ReturnLoginChoices')),
              ),
            if (selectedProfile != '') const SizedBox(height: 24),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceChild)
              ElevatedButton(
                onPressed: () => chooseLoginChoice(
                  NotifyData.ChoiceChild,
                ),
                style: selectedProfile == NotifyData.ChoiceChild
                    ? Constant.getTitle1ButtonStyleWhite()
                    : Constant.getTitle1ButtonStyleBlack(),
                child: Text(translator.getText('LoginAsChild')),
              ),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceChild)
              const SizedBox(height: 24),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              ElevatedButton(
                onPressed: () =>
                    chooseLoginChoice(NotifyData.ChoiceParent),
                style: selectedProfile == NotifyData.ChoiceParent
                    ? Constant.getTitle1ButtonStyleWhite()
                    : Constant.getTitle1ButtonStyleBlack(),
                child: Text(translator.getText('LoginAsParent')),
              ),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              const SizedBox(height: 24),
            if (selectedProfile == NotifyData.ChoiceParent ||
                selectedProfile == NotifyData.ChoiceChild)
              TextField(
                controller: controllerLogin,
                decoration: InputDecoration(labelText: translator.getText('LoginText')),
              ),
            if (selectedProfile == NotifyData.ChoiceParent ||
                selectedProfile == NotifyData.ChoiceChild)
              const SizedBox(height: 24),
            if (selectedProfile == NotifyData.ChoiceParent ||
                selectedProfile == NotifyData.ChoiceChild)
              TextField(
                controller: controllerPwd,
                decoration: InputDecoration(labelText: translator.getText('PasswordText')),
              ),
            if (selectedProfile == NotifyData.ChoiceParent ||
                selectedProfile == NotifyData.ChoiceChild)
              const SizedBox(height: 24),
            if (selectedProfile == NotifyData.ChoiceParent ||
                selectedProfile == NotifyData.ChoiceChild)
              ElevatedButton(
                style: Constant.getTitle3ButtonStyle(),
                onPressed: () async {
                  _sessionProvider.setRole(selectedProfile);
                  if (_sessionProvider.role == NotifyData.ChoiceChild) {
                    _sessionProvider.setParent(null);
                    _sessionProvider.setChild(_sessionProvider.tmpChild);
                  } else {
                    _sessionProvider.setChild(null);
                    _sessionProvider.setParent(_sessionProvider.tmpParent);
                  }
                  notifyData.setCurrentBottomPosition(1);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          _sessionProvider.role == NotifyData.ChoiceChild
                              ? const MainIntroScreenChild()
                              : const MainIntroScreenParent(),
                    ),
                  );
                },
                child: Text(translator.getText('LoginButton')),
              ),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              FractionallySizedBox(
                widthFactor: 0.5, // 50% of the parent width
                child: Divider(
                  color: Colors.blue,
                  thickness: 5.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  height: 30.0,
                ),
              ),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              const SizedBox(height: 24),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateParentAccount(),
                    ),
                  )
                },
                style: selectedProfile == NotifyData.ChoiceParent
                    ? Constant.getTitle1ButtonStyleForResetCreate()
                    : Constant.getTitle1ButtonStyleForResetCreate(),
                child: Text(translator.getText('CreateParentAccount')),
              ),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              const SizedBox(height: 24),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ParentReset(),
                    ),
                  )
                },
                style: selectedProfile == NotifyData.ChoiceParent
                    ? Constant.getTitle1ButtonStyleForResetCreate()
                    : Constant.getTitle1ButtonStyleForResetCreate(),
                child: Text(translator.getText('ResetParentAccount')),
              ),
            if (selectedProfile == '' ||
                selectedProfile == NotifyData.ChoiceParent)
              const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
