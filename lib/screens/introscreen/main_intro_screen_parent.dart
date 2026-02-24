import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/main_intro_screen_child.dart';
import 'package:provider/provider.dart';
import '../../core/constance_parent.dart';
import '../../core/constances.dart';
import '../../core/notify_data.dart';
import '../../models/child.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../audio/audio_list_screen.dart';
import 'parent/parent_child_screen.dart';

class MainIntroScreenParent extends StatefulWidget {
  const MainIntroScreenParent({super.key});

  @override
  State<MainIntroScreenParent> createState() => _MainIntroScreenParent();
}

class _MainIntroScreenParent extends State<MainIntroScreenParent> {
  void _navigateTo(Child? item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ParentChildScreen(child: item!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    SessionProvider session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();
    print('dododododododdo');
    return AppScaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Title
            Center(
              child: ElevatedButton(
          onPressed: () {},
          style: Constant.getTitle1ButtonStyle(),
          child: Text(notifyData.currentLanguage == Constant.languageEN
                    ? ConstantParent.menuTitrePageIntroParentEN
                    : ConstantParent.menuTitrePageIntroParentFR),
        ),
            ),

            const SizedBox(height: 16),

            // Children list
            Expanded(
              child: session.parent!.children.isEmpty
                  ? Center(
                      child: Text(
                        notifyData.currentLanguage == Constant.languageEN
                            ? ConstantParent.menuNoChildRegisterEN
                            : ConstantParent.menuNoChildRegisterEN,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: session.parent?.children.length,
                      itemBuilder: (context, index) {
                        final item = session.parent?.children[index];

                        return GestureDetector(
                          onTap: () => _navigateTo(item),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_3_outlined,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    item!.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        (session.parent?.currentChild != null &&
                                            item.id ==
                                                session
                                                    .parent
                                                    ?.currentChild
                                                    ?.id)
                                        ? Colors.blue
                                        : Colors.grey, // The background color
                                    shape: BoxShape
                                        .circle, // The shape of the background
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.bluetooth_audio_outlined,
                                    ),
                                    color:
                                        (session.parent?.currentChild != null &&
                                            item.id ==
                                                session
                                                    .parent
                                                    ?.currentChild
                                                    ?.id)
                                        ? Colors.white
                                        : Colors.black,
                                    onPressed: () {
                                      // Handle button press
                                      session.setCurrentChildAsParent(item);
                                      //print(item!.name + ' ===== ' + session.parent!.currentChild!.name);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const MainIntroScreenChild(),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 16),
                                const Icon(Icons.arrow_forward_ios, size: 16),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 10),

            // Actions
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showAddChildDialog(context, notifyData),
                icon: const Icon(Icons.person_add),
                label: Text(
                  notifyData.currentLanguage == Constant.languageEN
                      ? ConstantParent.menuAddChildEN
                      : ConstantParent.menuAddChildFR,
                ),
                style: Constant.getTitle3ButtonStyle(),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () =>
                    _showChangePasswordDialog(context, session, notifyData),
                icon: const Icon(Icons.lock),
                label: Text(
                  notifyData.currentLanguage == Constant.languageEN
                      ? ConstantParent.menuChangeNameAndPwdEN
                      : ConstantParent.menuChangeNameAndPwdFR,
                ),
                style: Constant.getTitle3ButtonRedStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // Add Child Dialog
  // -------------------------
  void _showAddChildDialog(BuildContext context, NotifyData notifyData) {
    final controllerLogin = TextEditingController();
    final controllerPassword = TextEditingController();
    final controllerName = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          notifyData.currentLanguage == Constant.languageEN
              ? ConstantParent.titleAddChildEN
              : ConstantParent.titleAddChildFR,
        ),
        content: Column(
          children: [
            TextField(
              controller: controllerName,
              decoration: InputDecoration(
                labelText: notifyData.currentLanguage == Constant.languageEN
                    ? ConstantParent.labelChildNameEN
                    : ConstantParent.labelChildNameFR,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controllerLogin,
              decoration: InputDecoration(
                labelText: notifyData.currentLanguage == Constant.languageEN
                    ? ConstantParent.labelChildLoginEN
                    : ConstantParent.labelChildLoginFR,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controllerPassword,
              decoration: InputDecoration(
                labelText: notifyData.currentLanguage == Constant.languageEN
                    ? ConstantParent.labelChildPwdEN
                    : ConstantParent.labelChildPwdEN,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              notifyData.currentLanguage == Constant.languageEN
                  ? ConstantParent.labelChildCancelButtonEN
                  : ConstantParent.labelChildCancelButtonFR,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controllerLogin.text.isNotEmpty &&
                  controllerName.text.isNotEmpty &&
                  controllerPassword.text.isNotEmpty) {
                context.read<SessionProvider>().addChild(
                  controllerLogin.text,
                  controllerName.text,
                  controllerPassword.text,
                );
                Navigator.pop(context);
              }
            },
            child: Text(
              notifyData.currentLanguage == Constant.languageEN
                  ? ConstantParent.labelChildSaveButtonEN
                  : ConstantParent.labelChildSaveButtonFR,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // Change Password Dialog
  // -------------------------
  void _showChangePasswordDialog(
    BuildContext context,
    SessionProvider session,
    NotifyData notifyData,
  ) {
    final controllerName = TextEditingController();
    final controllerPassword = TextEditingController();
    controllerName.text = session.parent!.name;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          notifyData.currentLanguage == Constant.languageEN
              ? ConstantParent.labelTitleParentPwdChangeEN
              : ConstantParent.labelTitleParentPwdChangeFR,
        ),
        content: Column(
          children: [
            TextField(
              controller: controllerName,
              decoration: InputDecoration(
                labelText: notifyData.currentLanguage == Constant.languageEN
                    ? ConstantParent.labelNameParentPwdChangeEN
                    : ConstantParent.labelNameParentPwdChangeFR,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: notifyData.currentLanguage == Constant.languageEN
                    ? ConstantParent.labelNameParentPwdChangeEN
                    : ConstantParent.labelNameParentPwdChangeFR,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              notifyData.currentLanguage == Constant.languageEN
                  ? ConstantParent.labelCancelButtonParentPwdChangeEN
                  : ConstantParent.labelCancelButtonParentPwdChangeFR,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controllerName.text.isNotEmpty &&
                  controllerPassword.text.isNotEmpty) {
                context.read<SessionProvider>().changeParentPassword(
                  controllerName.text,
                  controllerPassword.text,
                );
                Navigator.pop(context);
              }
            },
            child: Text(
              notifyData.currentLanguage == Constant.languageEN
                  ? ConstantParent.labelSaveButtonParentPwdChangeEN
                  : ConstantParent.labelSaveButtonParentPwdChangeFR,
            ),
          ),
        ],
      ),
    );
  }
}
