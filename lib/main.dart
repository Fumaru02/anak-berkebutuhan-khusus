import 'package:anak_berkebutuhan_khusus/routes/app_routes.dart';
import 'package:anak_berkebutuhan_khusus/utils/size_config.dart';
import 'package:anak_berkebutuhan_khusus/view/splash_screen.dart';
import 'package:anak_berkebutuhan_khusus/view/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Fungsi utama aplikasi Flutter.
Future<void> main() async {
  // Memastikan binding Flutter diinisialisasi.
  WidgetsFlutterBinding.ensureInitialized();

  // // Menginisialisasi Firebase.
  // await Firebase.initializeApp();

  // // Mengatur orientasi layar yang diinginkan.
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const SkinAlerts());
}

class SkinAlerts extends StatelessWidget {
  const SkinAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(AuthorizeController());

    // Menginisialisasi `SizeConfig` dengan konteks saat ini.
    SizeConfig().init(context);

    return GetMaterialApp(
      theme: ThemeData(useMaterial3: false),
      title: 'Anak Berkebutuhan Khusus',
      debugShowCheckedModeBanner: false,

      // Membangun tata letak responsif berdasarkan breakpoint.
      builder: (BuildContext context, Widget? child) =>
          ResponsiveBreakpoints.builder(
            breakpoints: const <Breakpoint>[
              Breakpoint(start: 0, end: 480, name: MOBILE),
            ],
            child: child!,
          ),

      // Mengatur halaman awal aplikasi menjadi `AuthorizeView`.
      home: WelcomeView(),

      // Mengatur rute aplikasi menggunakan `AppRoutes.routes`.
      getPages: AppRoutes.routes,

      // Mengatur transisi default menjadi `Transition.noTransition`.
      defaultTransition: Transition.noTransition,
    );
  }
}
