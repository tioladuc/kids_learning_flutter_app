import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constance_course.dart';
import '../../core/constance_statistics.dart';
import '../../core/constances.dart';
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

class _IntroStatisticsForParentState extends State<IntroStatisticsForParent> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SessionProvider>().loadChildren();
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final NotifyData notifyData = context.watch<NotifyData>();
    final children = session.children;

    return AppScaffold(
      /*appBar: AppBar(
        title: const Text("Children Accounts"),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: Constant.getTitle1ButtonStyle(),
              child: Text(notifyData.currentLanguage == Constant.languageEN
                  ? ConstantStatistics.ChildrenAccountsStatisticsEN
                  : ConstantStatistics.ChildrenAccountsStatisticsFR),
            ),
            Expanded(
              // ✅ gives available space
              child: _buildContent(session, children, notifyData),
            ),
          ],
        ) /*_buildContent(session, children)*/ /*Column(
          children: [
            ElevatedButton(
          onPressed: () {},
          style: Constant.getTitle1ButtonStyle(),
          child: Text("Children Accounts Statistics" ),
        ),
            _buildContent(session, children)
          ],
        ),*/
        ,
      ),
    );
  }

  Widget _buildContent(
      SessionProvider session, List children, NotifyData notifyData) {
    if (session.isLoadingChildren) {
      return const Center(child: CircularProgressIndicator());
    }

    if (children.isEmpty) {
      return Center(
          child: Text(notifyData.currentLanguage == Constant.languageEN
              ? ConstantStatistics.NoChildrenRegisteredEN
              : ConstantStatistics.NoChildrenRegisteredFR));
    }

    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        final Child child = children[index];

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
                      onPressed: () {
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
                      },
                      icon: const Icon(Icons.person, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      child.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
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
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.blue, // ✅ blue background
                        foregroundColor: Colors.white, // ✅ icon color
                        padding: const EdgeInsets.all(12),
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
                    Text((notifyData.currentLanguage == Constant.languageEN
                            ? ConstantStatistics.StatisticLoginEN
                            : ConstantStatistics.StatisticLoginFR) +
                        ": ${child.login}"),
                  ],
                ),

                const SizedBox(height: 5),

                /// Password
                Row(
                  children: [
                    const Icon(Icons.lock, size: 18),
                    const SizedBox(width: 8),
                    Text((notifyData.currentLanguage == Constant.languageEN
                            ? ConstantStatistics.StatisticPasswordEN
                            : ConstantStatistics.StatisticPasswordFR) +
                        ": ${child.password}"),
                  ],
                ),

                const SizedBox(height: 10),

                /// Financial Owner
                Row(
                  children: [
                    Icon(
                      child.parentResponsible!
                          ? Icons.verified
                          : Icons.info_outline,
                      color: child.parentResponsible!
                          ? Colors.green
                          : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      child.parentResponsible!
                          ? (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantStatistics.FinancialOwnerEN
                              : ConstantStatistics.FinancialOwnerFR)
                          : (notifyData.currentLanguage == Constant.languageEN
                              ? ConstantStatistics.NotFinancialOwnerEN
                              : ConstantStatistics.NotFinancialOwnerFR),
                      style: TextStyle(
                        color: child.parentResponsible!
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
}
