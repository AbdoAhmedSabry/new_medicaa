import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/call_helper.dart';
import 'package:new_medicaa/config/cachehelper.dart';
import 'package:new_medicaa/config/const/app_routes.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/core/di/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:new_medicaa/features/auth/presentation/manager/auth_cubit.dart';
import 'package:new_medicaa/video_call_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator();
  await CacheHelper.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<AuthCubit>())],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MediCare',
            navigatorKey: CallHelper.navigatorKey, // 👈 التعديل هنا
            theme: ThemeData(fontFamily: 'Cairo'),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: Routes.splashScreen,
            onGenerateRoute: AppRouter().generateRoute,
          );
        },
      ),
    );
  }
}
