import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';

class MainIntroScreenParent extends StatelessWidget {
  const MainIntroScreenParent({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    print('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM ' + session.parent.name.toString());
    print('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM++ ' + session.parent.children.length.toString());
    return AppScaffold(
      /*appBar: AppBar(
        title: const Text("Parent Dashboard"),
        centerTitle: true,
      ),*/

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "My Children",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Children list
            Expanded(
              child: session.parent.children.isEmpty
                  ? const Center(child: Text("No children added"))
                  : ListView.builder(
                      itemCount: session.parent.children.length,
                      itemBuilder: (context, index) {
                        final child = session.parent.children[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(Icons.child_care),
                            title: Text(child.name),
                            subtitle: Text("ID: ${child.id}"),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 10),

            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddChildDialog(context),
                    icon: const Icon(Icons.person_add),
                    label: const Text("Add Child"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showChangePasswordDialog(context),
                    icon: const Icon(Icons.lock),
                    label: const Text("Change Password"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // Add Child Dialog
  // -------------------------
  void _showAddChildDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Child"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "Child Name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<SessionProvider>().addChild(controller.text, 'password');
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // Change Password Dialog
  // -------------------------
  void _showChangePasswordDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "New Password",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<SessionProvider>().changePassword(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
