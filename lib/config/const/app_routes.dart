import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/core/di/injection_container.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/auth/presentation/screens/checkmail.dart';
import 'package:new_medicaa/features/auth/presentation/screens/forgotpassword.dart';
import 'package:new_medicaa/features/auth/presentation/screens/login_screen.dart';
import 'package:new_medicaa/features/auth/presentation/screens/register_screen.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/doctor_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/home_cubit.dart';
import 'package:new_medicaa/features/home/presentation/pages/all_doctors.dart';
import 'package:new_medicaa/features/home/presentation/pages/category_doctors_screen.dart';
import 'package:new_medicaa/features/home/presentation/pages/doctor_details.dart';
import 'package:new_medicaa/features/home/presentation/pages/home_page.dart';
import 'package:new_medicaa/features/home/presentation/pages/user_appointment.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_cubit.dart';
import 'package:new_medicaa/features/patient_profile/presentation/screen/patient_data.dart';
import 'package:new_medicaa/features/patient_profile/presentation/screen/profile_patient_screen.dart';
import 'package:new_medicaa/language_screen.dart';
import 'package:new_medicaa/main_layout.dart';
import 'package:new_medicaa/splash_screen.dart' show SplashScreen;

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.allDoctorsScreen:
        final doctorsList = settings.arguments as List<DoctorEntity>;
        return MaterialPageRoute(
          builder: (_) => Alldoctors(doctors: doctorsList),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<HomeCubit>()..getHomeData(),
            child: HomePage(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.patientDataScreen:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<PatientCubit>(),
            child: Dataprofile(userModel: user),
          ),
        );

      case Routes.doctorProfileScreen:
        final doctor = settings.arguments as DoctorEntity;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AppointmentCubit>(),
            child: DoctorProfileScreen(doctor: doctor),
          ),
        );
      case Routes.checkMailScreen:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => CheckEmailScreen(userModel: user),
        );
      case Routes.mainLayoutScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<HomeCubit>()..getHomeData()),
              BlocProvider(create: (context) => sl<AppointmentCubit>()),
              BlocProvider(create: (context) => sl<PatientCubit>()),
            ],
            child: const MainLayoutScreen(),
          ),
        );
      case Routes.ProfilePatientscreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<PatientCubit>()..getPatientData(),
            child: const ProfilePatientscreen(),
          ),
        );
      case Routes.userAppointmentPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AppointmentCubit>(),
            child: const UserAppointmentPage(),
          ),
        );
      case Routes.categoryDoctorsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryName = args['categoryName'];

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<DoctorCubit>(),
            child: CategoryDoctorsScreen(categoryName: categoryName),
          ),
        );
      case Routes.languageScreen:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());

      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
