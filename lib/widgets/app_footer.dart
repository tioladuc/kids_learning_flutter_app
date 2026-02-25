import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/providers/session_provider.dart';
import 'package:kids_learning_flutter_app/screens/footer_intro_widget/payment.dart';
import 'package:kids_learning_flutter_app/screens/footer_intro_widget/presentation.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/main_intro_screen_parent.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/statistics/intro_statistics.dart';
import 'package:provider/provider.dart';

import '../core/constance_session.dart';
import '../core/constances.dart';
import '../core/notify_data.dart';
import '../models/child.dart';
import '../screens/audio/audio_list_screen.dart';
import '../screens/footer_intro_widget/intro_statistics_for_parent.dart';
import '../screens/introscreen/child/child_pick_course.dart';
import '../screens/introscreen/main_intro_screen_child.dart';
import '../screens/session/login_screen.dart';


class AppFooter extends StatefulWidget {
  
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooter();

}

class _AppFooter  extends State<AppFooter>  {//class AppFooter extends StatelessWidget {
  int _currentIndex = 0;
  final List<Widget> _pages = [
                  LoginScreen(),
                  MainIntroScreenChild(),
                  AudioListScreen(),
                  ChildPickCourse( child:Child(  id: 's', login: 'login', name: 'name', password: 'pwd')),
                ];
  void goTo(Widget widget) {
    Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => widget),
                  (Route<dynamic> route) => false,
                );
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    final session = context.watch<SessionProvider>();
    _currentIndex = notifyData.currentBottomPosition;

    return BottomNavigationBar(
      currentIndex: _currentIndex,
            onTap: (index) => setState(() {
              _currentIndex = index; 
              notifyData.setCurrentBottomPosition(index); 
              if(!session.isLoggedIn) {
                goTo(LoginScreen());
              }
              else {
                if(index==0) {
                  goTo(Presentation());
                }
                else if(index==1) {
                  if(session.parent != null) {
                    goTo(MainIntroScreenParent());
                  }
                  else {
                    goTo(MainIntroScreenChild());
                  }
                }
                else if(index==2){
                  if(session.parent != null) {
                    goTo(IntroStatisticsForParent());
                  }
                  else {
                    goTo(IntroStatistics(child: session.child!, isResponsible: false, isViewParent: false,));
                  }
                }
                else if(index==3) {
                  goTo(Payment());
                }
              }
              
              }),

            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent, // IMPORTANT
            elevation: 0,

            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,

            

            selectedFontSize: 12,
            unselectedFontSize: 11,
      items:  [
        BottomNavigationBarItem(icon: Icon(Icons.home),  label: (notifyData.currentLanguage == Constant.languageEN) ? ConstantSession.BottomHomeEN : ConstantSession.BottomHomeFR),
        BottomNavigationBarItem(icon: Icon(Icons.workspaces), label: (notifyData.currentLanguage == Constant.languageEN) ? ConstantSession.BottomOperationEN : ConstantSession.BottomOperationFR),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: (notifyData.currentLanguage == Constant.languageEN) ? ConstantSession.BottomStatisticsEN : ConstantSession.BottomStatisticsFR, ),
        BottomNavigationBarItem(icon: Icon(Icons.monetization_on_outlined), label: (notifyData.currentLanguage == Constant.languageEN) ? ConstantSession.BottomPaymentEN : ConstantSession.BottomPaymentFR),
      ],
    );
  }
}
