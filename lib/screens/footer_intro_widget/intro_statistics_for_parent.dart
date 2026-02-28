import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../core/core_translator.dart';
import '../../core/notify_data.dart';
import '../../models/child.dart';
import '../../providers/session_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../introscreen/statistics/intro_statistics.dart';

class IntroStatisticsForParent extends StatefulWidget {
  const IntroStatisticsForParent({super.key});

  @override
  State<IntroStatisticsForParent> createState() =>
      _IntroStatisticsForParentState();
}

class _IntroStatisticsForParentState
    extends State<IntroStatisticsForParent> {
  Translator translator = Translator();

  @override
  void initState() {
    super.initState();

    // ✅ Load data once
    Future.microtask(() {
      context.read<SessionProvider>().loadChildren();
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();

    translator = Translator(
      status: StatusLangue.CONSTANCE_STATISTICS,
      lang: notifyData.currentLanguage,
    );

    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: Constant.getTitle1ButtonStyle(),
              child: Text(
                translator.getText('ChildrenAccountsStatistics'),
              ),
            ),

            /// 🔥 Main Content
            Expanded(child: _buildContent(session)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(SessionProvider session) {
    /// ✅ SHOW LOADING
    print(session.isLoadingChildren);
    print(session.children.length.toString());
    if (session.isLoadingChildren) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    /// ✅ NO DATA
    if (session.children.isEmpty) {
      return Center(
        child: Text(translator.getText('NoChildrenRegistered')),
      );
    }

    /// ✅ DATA READY
    return ListView.builder(
      itemCount: session.children.length,
      itemBuilder: (context, index) {
        final Child child = session.children[index];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _goToStats(child),
                      icon: const Icon(Icons.person, size: 20),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        child.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () => _goToStats(child),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.arrow_forward_ios, size: 20),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Login
                Row(
                  children: [
                    const Icon(Icons.account_circle, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "${translator.getText('StatisticLogin')}: ${child.login}",
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                /// Password
                Row(
                  children: [
                    const Icon(Icons.lock, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "${translator.getText('StatisticPassword')}: ${child.password}",
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// Financial Owner
                Row(
                  children: [
                    Icon(
                      child.parentResponsible ?? false
                          ? Icons.verified
                          : Icons.info_outline,
                      color: (child.parentResponsible ?? false)
                          ? Colors.green
                          : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      (child.parentResponsible ?? false)
                          ? translator.getText('FinancialOwner')
                          : translator.getText('NotFinancialOwner'),
                      style: TextStyle(
                        color: (child.parentResponsible ?? false)
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _goToStats(Child child) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IntroStatistics(
          child: child,
          isResponsible: child.parentResponsible ?? false,
          isViewParent: true,
        ),
      ),
    );
  }
}
