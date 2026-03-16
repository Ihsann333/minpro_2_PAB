import 'package:flutter/material.dart';
import 'package:minpro_1/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/home_page.dart';

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'pemimpin ketjam',
    anonKey: 'anthek anthek ashing',
  );

  runApp(const HotelApp());
}

class HotelApp extends StatelessWidget {
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, _) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RoomBook Hotel',

          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),

          themeMode: currentMode,

          home: Supabase.instance.client.auth.currentUser == null
          ? const LoginPage()
          : const HomePage(),
        );
      },
    );
  }
}