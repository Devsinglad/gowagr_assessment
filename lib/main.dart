import 'package:flutter/material.dart';
import 'package:gowagr_assessment/data/local_data/repository.dart';
import 'package:gowagr_assessment/provider/event_provider.dart';
import 'package:gowagr_assessment/theme.dart';
import 'package:gowagr_assessment/utils/assets/constansts.dart';
import 'package:gowagr_assessment/view/home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Repository.init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ExploreViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme(context),
      home: HomePage(),
    );
  }
}
