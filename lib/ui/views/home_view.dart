import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/ui/views/Pageview%20Views/discover_page_view.dart';
import 'package:quasar_music/ui/views/Pageview%20Views/home_page_view.dart';
import 'package:quasar_music/ui/views/Pageview%20Views/playlist_page_view.dart';
import 'package:quasar_music/viewmodels/home_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class HomeView extends StatelessWidget {
  DateTime? currentBackPressTime;

  HomeView({Key? key, this.currentBackPressTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
              currentBackPressTime = now;
              showToast(
                'Press again to exit',
                context: context,
                animation: StyledToastAnimation.scale,
                curve: Curves.bounceIn,
                reverseCurve: Curves.bounceOut,
              );
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemUiOverlayStyle,
            child: Scaffold(
              body: PageView(
                  onPageChanged: (index) {
                    model.updateIdx(index);
                  },
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const HomePageView(),
                    PlaylistPageView(),
                    const DiscoverPageView(),
                  ]),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                currentIndex: model.idx,
                backgroundColor: scaffoldBackgroundColor,
                unselectedItemColor: lightgrey,
                selectedItemColor: primaryColorLight,
                elevation: 10,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.homeOutline),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.musicOutline),
                    label: 'My Playlist',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.globe),
                    label: 'Discover',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
