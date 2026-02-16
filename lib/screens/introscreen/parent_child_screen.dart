import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/main_intro_screen_parent.dart';
import 'package:provider/provider.dart';
import '../../models/child.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';
import 'child_statistics.dart';
import 'main_intro_screen_child.dart';

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
  void _saveChanges() {
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Child updated")));
  }

  // -------------------------
  // DELETE CHILD
  // -------------------------
  void _deleteChild() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Child"),
        content: const Text("Are you sure you want to delete this child?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<SessionProvider>().deleteChild(widget.child.id);

              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Child deleted")));
            },
            child: const Text("Delete"),
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
      MaterialPageRoute(builder: (_) => ChildStatistics(child: widget.child,)),
    );
  }

  // -------------------------
  // WORK AS CHILD
  // -------------------------
  void _workAsChild() {
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

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Switched to child mode+++")));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      /*appBar: AppBar(
        title: const Text("Child Details"),
        centerTitle: true,
      ),*/
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                      "Child ID: ${widget.child.id}",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // Name
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Login (readonly)
                    TextField(
                      controller: TextEditingController(
                        text: widget.child.login,
                      ),
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "Login",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Password
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Save button
                    ElevatedButton.icon(
                      onPressed: _saveChanges,
                      icon: const Icon(Icons.save),
                      label: const Text("Save Changes"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
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
                    leading: const Icon(Icons.bar_chart),
                    title: const Text("View Statistics"),
                    onTap: _viewStatistics,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.play_circle_fill),
                    title: const Text("Work as Child"),
                    onTap: _workAsChild,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text("Delete Child"),
                    onTap: _deleteChild,
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
