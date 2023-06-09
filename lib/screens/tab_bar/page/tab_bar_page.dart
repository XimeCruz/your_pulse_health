import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/screens/home/page/home_page.dart';
import 'package:your_pulse_health/screens/pressure/page/pressure_page.dart';
import 'package:your_pulse_health/screens/pressure_camera/page/pressurecamera_page.dart';
import 'package:your_pulse_health/screens/settings/settings_screen.dart';
import 'package:your_pulse_health/screens/tab_bar/bloc/tab_bar_bloc.dart';
import 'package:your_pulse_health/screens/workouts/page/workouts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {},
        buildWhen: (_, currState) =>
            currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createdBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createdBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      fixedColor: ColorConstants.primaryColor,
      items: [
        BottomNavigationBarItem(
          /*icon: Image(
            image: AssetImage(PathConstants.menu),
            color: bloc.currentIndex == 0 ? ColorConstants.primaryColor : null,
          ),*/
          icon: Icon(
              Icons.menu,
              color: bloc.currentIndex == 0 ? ColorConstants.primaryColor : null
          ),
          label: TextConstants.homeIcon,
        ),
        BottomNavigationBarItem(
          /*icon: Image(
            image: AssetImage(PathConstants.pressure),
            color: bloc.currentIndex == 1 ? ColorConstants.primaryColor : null,
          ),*/
          icon: Icon(
              Icons.monitor_heart,
              color: bloc.currentIndex == 1 ? ColorConstants.primaryColor : null
          ),
          label: TextConstants.workoutsIcon,
        ),
        BottomNavigationBarItem(
          /*icon: Image(
            image: AssetImage(PathConstants.settings),
            color: bloc.currentIndex == 2 ? ColorConstants.primaryColor : null,
          ),*/
          icon: Icon(
              Icons.settings,
              color: bloc.currentIndex == 2 ? ColorConstants.primaryColor : null
          ),
          label: TextConstants.settingsIcon,
        ),
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index: index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [
      HomePage(),
      PressurePage(),
      //WorkoutsPage(),
      SettingsScreen(),
      // Scaffold(
      //   body: Center(
      //     child: RawMaterialButton(
      //       fillColor: Colors.red,
      //       child: Text(
      //         TextConstants.signOut,
      //         style: TextStyle(
      //           color: ColorConstants.white,
      //         ),
      //       ),
      //       onPressed: () {
      //         AuthService.signOut();
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (_) => SignInPage()),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    ];
    return children[index];
  }
}
