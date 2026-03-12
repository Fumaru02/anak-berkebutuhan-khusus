import 'package:anak_berkebutuhan_khusus/view/login_%20view.dart';
import 'package:anak_berkebutuhan_khusus/view/splash_screen.dart';
import 'package:get/get.dart';
import 'routes_name.dart';

class AppRoutes {
  AppRoutes._();

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: RoutesName.splashscreenRoute,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    // GetPage<dynamic>(
    //     name: RoutesName.frameRoute,
    //     page: () => const FrameView(),
    //     transition: Transition.fadeIn,
    //     transitionDuration: const Duration(milliseconds: 1000)),
    GetPage<dynamic>(
      name: RoutesName.loginRoute,
      page: () => LoginView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}
