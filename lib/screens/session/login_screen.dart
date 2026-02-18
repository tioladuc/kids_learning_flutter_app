import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/notify_data.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/main_intro_screen_child.dart';
import 'package:provider/provider.dart';
import '../../core/constance_session.dart';
import '../../core/constances.dart';
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
  NotifyData _notifyData = NotifyData();
  SessionProvider _sessionProvider = SessionProvider();

  //final ChoiceChild = 'child';
  //final ChoiceParent = 'parent';
  String selectedProfile = "";

  void chooseLoginChoice(String choice) {
    setState(() {
      //_isVisible = !_isVisible;
      selectedProfile = choice;
      //_notifyData.setRole(selectedProfile);
      print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ' + selectedProfile);
      //_sessionProvider.setRole(selectedProfile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    final sessionProvider = context.watch<SessionProvider>();
    _sessionProvider = sessionProvider;
    //final session = context.watch<SessionProvider>();
    _notifyData = notifyData;

    return AppScaffold(
      //appBar: const AppHeader(),
      //bottomNavigationBar: const AppFooter(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedProfile != '')
              ElevatedButton(
                onPressed: () => chooseLoginChoice(
                  '',
                ), //context.read<SessionProvider>().login('child'),
                style: Constant.getTitle1ButtonStyle(),
                child: notifyData.currentLanguage == Constant.languageEN
                    ? Text(ConstantSession.ReturnLoginChoicesEN)
                    : Text(ConstantSession.ReturnLoginChoicesFR),
              ),
            if (selectedProfile != '') const SizedBox(height: 24),

            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceChild)
              ElevatedButton(
                onPressed: () => chooseLoginChoice(
                  ConstantSession.ChoiceChild,
                ), //context.read<SessionProvider>().login('child'),
                style: selectedProfile == ConstantSession.ChoiceChild
                    ? Constant.getTitle1ButtonStyleWhite()
                    : Constant.getTitle1ButtonStyleBlack(),
                child: notifyData.currentLanguage == Constant.languageEN
                    ? Text(ConstantSession.LoginAsChildEN)
                    : Text(ConstantSession.LoginAsChildFR),
              ),
            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceChild)
              const SizedBox(height: 24),

            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceParent)
              ElevatedButton(
                onPressed: () =>
                    chooseLoginChoice(ConstantSession.ChoiceParent),
                style: selectedProfile == ConstantSession.ChoiceParent
                    ? Constant.getTitle1ButtonStyleWhite()
                    : Constant.getTitle1ButtonStyleBlack(), //context.read<SessionProvider>().login('parent'),
                child: notifyData.currentLanguage == Constant.languageEN
                    ? Text(ConstantSession.LoginAsParentEN)
                    : Text(ConstantSession.LoginAsParentFR),
              ),
            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceParent)
              const SizedBox(height: 24),

            if (selectedProfile == ConstantSession.ChoiceParent ||
                selectedProfile == ConstantSession.ChoiceChild)
              TextField(
                controller: controllerLogin,
                decoration: notifyData.currentLanguage == Constant.languageEN
                    ? InputDecoration(labelText: ConstantSession.LoginTextEN)
                    : InputDecoration(labelText: ConstantSession.LoginTextFR),
              ),
            if (selectedProfile == ConstantSession.ChoiceParent ||
                selectedProfile == ConstantSession.ChoiceChild)
              const SizedBox(height: 24),

            if (selectedProfile == ConstantSession.ChoiceParent ||
                selectedProfile == ConstantSession.ChoiceChild)
              TextField(
                controller: controllerPwd,
                decoration: notifyData.currentLanguage == Constant.languageEN
                    ? InputDecoration(labelText: ConstantSession.PasswordTextEN)
                    : InputDecoration(
                        labelText: ConstantSession.PasswordTextFR,
                      ),
              ),
            if (selectedProfile == ConstantSession.ChoiceParent ||
                selectedProfile == ConstantSession.ChoiceChild)
              const SizedBox(height: 24),

            if (selectedProfile == ConstantSession.ChoiceParent ||
                selectedProfile == ConstantSession.ChoiceChild)
              ElevatedButton(
                style: Constant.getTitle3ButtonStyle(),
                onPressed: () async {
                  _sessionProvider.setRole(selectedProfile);
                  if (_sessionProvider.role == ConstantSession.ChoiceChild) {
                    _sessionProvider.setParent(null);
                    _sessionProvider.setChild(_sessionProvider.tmpChild);
                  } else {
                    _sessionProvider.setChild(null);
                    _sessionProvider.setParent(_sessionProvider.tmpParent);
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          _sessionProvider.role == ConstantSession.ChoiceChild
                          ? const MainIntroScreenChild()
                          : const MainIntroScreenParent(),
                    ),
                  );
                },
                child: notifyData.currentLanguage == Constant.languageEN
                    ? Text(ConstantSession.LoginButtonEN)
                    : Text(ConstantSession.LoginButtonFR),
              ),

            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceParent)
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
                selectedProfile == ConstantSession.ChoiceParent)
              const SizedBox(height: 24),

            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceParent)
              ElevatedButton(
                onPressed: () =>{
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateParentAccount(),
                ),
              )
                },
                style: selectedProfile == ConstantSession.ChoiceParent
                    ? Constant.getTitle1ButtonStyleForResetCreate()
                    : Constant.getTitle1ButtonStyleForResetCreate(), //context.read<SessionProvider>().login('parent'),
                child: notifyData.currentLanguage == Constant.languageEN
                    ? Text(ConstantSession.CreateParentAccountEN)
                    : Text(ConstantSession.CreateParentAccountFR),
              ),
            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceParent)
              const SizedBox(height: 24),

            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceParent)
              ElevatedButton(
                onPressed: () =>{
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ParentReset(),
                ),
              )
                },
                style: selectedProfile == ConstantSession.ChoiceParent
                    ? Constant.getTitle1ButtonStyleForResetCreate()
                    : Constant.getTitle1ButtonStyleForResetCreate(), //context.read<SessionProvider>().login('parent'),
                child: notifyData.currentLanguage == Constant.languageEN
                    ? Text(ConstantSession.ResetParentAccountEN)
                    : Text(ConstantSession.ResetParentAccountFR),
              ),
            if (selectedProfile == '' ||
                selectedProfile == ConstantSession.ChoiceParent)
              const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
