import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/main_intro_screen_parent.dart';
import 'package:provider/provider.dart';
import '../../../core/constance_parent.dart';
import '../../../core/constances.dart';
import '../../../core/notify_data.dart';
import '../../../models/child.dart';
import '../../../providers/session_provider.dart';
import '../../../widgets/app_scaffold.dart';
import '../child/child_statistics.dart';
import '../main_intro_screen_child.dart';
import '../statistics/intro_statistics.dart';
import 'parent_pending_screen.dart';

class ParentChildScreen extends StatefulWidget {
  final Child child;

  const ParentChildScreen({super.key, required this.child});

  @override
  State<ParentChildScreen> createState() => _ParentChildScreenState();
}

class _ParentChildScreenState extends State<ParentChildScreen> {
  late TextEditingController _nameController;
  late TextEditingController _passwordController;

  late Child _editableChild;

  @override
  void initState() {
    super.initState();

    // Create a copy to avoid modifying original directly
    _editableChild = Child.copy(widget.child);

    _nameController = TextEditingController(text: _editableChild.name);
    _passwordController = TextEditingController(text: _editableChild.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // -------------------------
  // SAVE CHANGES
  // -------------------------
  void _saveChanges(NotifyData notifyData) {
    final session = context.read<SessionProvider>();

    _editableChild.name = _nameController.text;
    _editableChild.password = _passwordController.text;

    // TODO: implement update in provider / API
    setState(() {
      session.changePasswordParentChild(
        _nameController.text,
        _passwordController.text,
        widget.child,
      );
    });
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainIntroScreenParent()),
      (Route<dynamic> route) => false, // Removes all routes below the new one
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantParent.detailedChildPageChildUpdateEN
              : ConstantParent.detailedChildPageChildUpdateEN,
        ),
      ),
    );
  }

  // -------------------------
  // DELETE CHILD
  // -------------------------
  void _deleteChild(NotifyData notifyData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantParent.detailedChildPageChildUpdateEN
              : ConstantParent.detailedChildPageChildUpdateFR,
        ),
        content: Text(
          notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantParent.childDeleteTitleEN
              : ConstantParent.childDeleteTitleFR,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              notifyData.currentLanguage == Constant.AppNameEN
                  ? ConstantParent.childDeleteCancelButtonEN
                  : ConstantParent.childDeleteCancelButtonFR,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<SessionProvider>().deleteChild(widget.child.id);

              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    notifyData.currentLanguage == Constant.AppNameEN
                        ? ConstantParent.childDeleteAlertMessageEN
                        : ConstantParent.childDeleteAlertMessageFR,
                  ),
                ),
              );
            },
            child: Text(
              notifyData.currentLanguage == Constant.AppNameEN
                  ? ConstantParent.childDeleteDeleteButtonEN
                  : ConstantParent.childDeleteDeleteButtonFR,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // VIEW STATISTICS
  // -------------------------
  void _viewStatistics() {
    // TODO: navigate to statistics screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => IntroStatistics(child: widget.child, isViewParent: true, isResponsible: widget.child.parentResponsible!,)),
    );
  }

  // -------------------------
  // VIEW PENDING COURSES
  // -------------------------
  void _viewPendingCourses() {
    // TODO: navigate to statistics screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ParentChildPendingScreen(child: widget.child, isResponsible: widget.child.parentResponsible! ,)),
    );
  }

  // -------------------------
  // SETTING THE RESPONSIBLE OF THE CHILD
  // -------------------------
  void setParentAsResponsible(SessionProvider session) {
    session.setParentAsReponsibleOfChild(isResponsible: !widget.child.parentResponsible!, child: widget.child);
  }

  // -------------------------
  // WORK AS CHILD
  // -------------------------
  void _workAsChild(NotifyData notifyData) {
    final session = context.read<SessionProvider>();

    // TODO: implement child login
    session.setCurrentChildAsParent(widget.child);
    //print(item!.name + ' ===== ' + session.parent!.currentChild!.name);
    /*Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainIntroScreenChild()),
    );*/
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainIntroScreenChild()),
      (Route<dynamic> route) => false, // Removes all routes below the new one
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantParent.childParentWorkAsChildEN
              : ConstantParent.childParentWorkAsChildFR,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    final session = context.watch<SessionProvider>();

    return AppScaffold(
      /*appBar: AppBar(
        title: const Text("Child Details"),
        centerTitle: true,
      ),*/
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed:
                  () {}, //context.read<SessionProvider>().login('child'),
              style: Constant.getTitle1ButtonStyle(),
              child: Text(
                notifyData.currentLanguage == Constant.languageEN
                    ? ConstantParent.labelTitleChildIdDetailEN
                    : ConstantParent.labelTitleChildIdDetailFR,
              ) /*notifyData.currentLanguage == Constant.languageEN
                ? Text(Constant.readingAudioTitleEN)
                : Text(Constant.readingAudioTitleFR)*/,
            ),
            // -------------------------
            // CHILD INFO CARD
            // -------------------------
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.child_care, size: 60, color: Colors.blue),
                    const SizedBox(height: 10),

                    Text(
                      (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantParent.labelChildIdFR
                              : ConstantParent.labelChildIdFR) +
                          ": ${widget.child.id}",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // Name
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText:
                            notifyData.currentLanguage == Constant.languageEN
                            ? ConstantParent.labelChildNameDetailEN
                            : ConstantParent.labelChildNameDetailFR,
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Login (readonly)
                    TextField(
                      controller: TextEditingController(
                        text: widget.child.login,
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText:
                            notifyData.currentLanguage == Constant.languageEN
                            ? ConstantParent.labelChildLoginDetailEN
                            : ConstantParent.labelChildLoginDetailFR,
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Password
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText:
                            notifyData.currentLanguage == Constant.languageEN
                            ? ConstantParent.labelChildPasswordDetailEN
                            : ConstantParent.labelChildPasswordDetailFR,
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Save button
                    ElevatedButton.icon(
                      onPressed: () {
                        _saveChanges(notifyData);
                      },
                      icon: const Icon(Icons.save),
                      label: Text(
                        notifyData.currentLanguage == Constant.languageEN
                            ? ConstantParent.labelChildSaveChangesDetailEN
                            : ConstantParent.labelChildSaveChangesDetailFR,
                      ),
                      style: Constant.getTitle3ButtonStyle()
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // ACTIONS
            // -------------------------
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: Text(notifyData.currentLanguage == Constant.languageEN
                          ? ConstantParent.labelChildPendingCourseDetailEN
                          : ConstantParent.labelChildPendingCourseDetailFR),
                    onTap: _viewPendingCourses,
                  ),
                  if(widget.child.parentResponsible!) 
                    ListTile(
                    leading: const Icon(Icons.money_off_csred_outlined),
                    title: Text(notifyData.currentLanguage == Constant.languageEN
                          ? ConstantParent.labelChildRemoveFinancialAuthorityEN
                          : ConstantParent.labelChildRemoveFinancialAuthorityFR),
                    onTap: (){
                      setState(() {
                        session.setParentAsReponsibleOfChild(isResponsible: false, child: widget.child);
                      });
                    },
                  ),
                  if(!widget.child.parentResponsible!) 
                    ListTile(
                    leading: const Icon(Icons.monetization_on_outlined),
                    title: Text(notifyData.currentLanguage == Constant.languageEN
                          ? ConstantParent.labelChildAcquisitionFinancialAuthorityEN
                          : ConstantParent.labelChildAcquisitionFinancialAuthorityFR),
                    onTap: (){
                      setState(() {
                        session.setParentAsReponsibleOfChild(isResponsible: false, child: widget.child);
                      });
                    },
                  ),
                  
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: Text(notifyData.currentLanguage == Constant.languageEN
                          ? ConstantParent.labelChildViewStatsDetailEN
                          : ConstantParent.labelChildViewStatsDetailFR),
                    onTap: _viewStatistics,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.play_circle_fill),
                    title: Text(notifyData.currentLanguage == Constant.languageEN
                          ? ConstantParent.labelChildDeleteChildDetailEN
                          : ConstantParent.labelChildDeleteChildDetailFR),
                    onTap: (){_workAsChild(notifyData);},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: Text(
                      notifyData.currentLanguage == Constant.languageEN
                          ? ConstantParent.labelChildWorkAsDetailEN
                          : ConstantParent.labelChildWorkAsDetailFR,
                    ),
                    onTap: () {
                      _deleteChild(notifyData);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
