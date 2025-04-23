import 'package:bigsangrup/background/background_service.dart';
import 'package:bigsangrup/static/app_router.dart';
import 'package:bigsangrup/static/theme_data.dart';
import 'package:bigsangrup/viewmodel/auth/login_viewmodel.dart';
import 'package:bigsangrup/viewmodel/home/home_viewmodel.dart';
import 'package:bigsangrup/viewmodel/parking/parking_viewmodel.dart';
import 'package:bigsangrup/viewmodel/profile/profile_viewmodel.dart';
import 'package:bigsangrup/viewmodel/quicksupport/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<InternetConnectionStatus>(
          initialData: InternetConnectionStatus.connected,
          create: (_) {
            return InternetConnectionChecker().onStatusChange;
          },
        ),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewmodel()),
        ChangeNotifierProvider(create: (_) => ProfileViewmodel()),
        ChangeNotifierProvider(create: (_) => SupportViewmodel()),
         ChangeNotifierProvider(create: (_) => ParkingViewmodel()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Bigsan Group',
        theme: CustomTheme().themedata,
        routerConfig: AppRoute.router,

        // routerDelegate: AppRoute.router.routerDelegate,
        // routeInformationParser: AppRoute.router.routeInformationParser,
      ),
    );
  }
}
