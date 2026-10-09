import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ─── Feature: Auth ───────────────────────────────────────────────────────────
import 'package:new_medicaa/config/services/databaseservice.dart';
import 'package:new_medicaa/features/auth/data/data_sources/remote_data_source.dart';
import 'package:new_medicaa/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:new_medicaa/features/auth/domain/repositories/auth_repository.dart';
import 'package:new_medicaa/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:new_medicaa/features/auth/domain/usecases/login_usecase.dart';
import 'package:new_medicaa/features/auth/domain/usecases/logout_usecase.dart';
import 'package:new_medicaa/features/auth/domain/usecases/register_usecase.dart';
import 'package:new_medicaa/features/auth/presentation/manager/auth_cubit.dart';

// ─── Feature: Patient Profile ────────────────────────────────────────────────
import 'package:new_medicaa/features/patient_profile/data/datasource/profile_localdata_source.dart';
import 'package:new_medicaa/features/patient_profile/data/repositories/patient_repo_impl.dart';
import 'package:new_medicaa/features/patient_profile/domain/repositories/patient_repo.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_cubit.dart';

// ─── Feature: Home — Data Layer ──────────────────────────────────────────────
import 'package:new_medicaa/features/home/data/datasources/home_local_datasource.dart';
import 'package:new_medicaa/features/home/data/datasources/home_remote_datasource.dart';
import 'package:new_medicaa/features/home/data/repositories/home_repository_impl.dart';
import 'package:new_medicaa/features/home/data/repositories/appointment_repository_impl.dart';

// ─── Feature: Home — Domain Layer ────────────────────────────────────────────
import 'package:new_medicaa/features/home/domain/repositories/home_repository.dart';
import 'package:new_medicaa/features/home/domain/repositories/appointment_repository.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_doctors_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_patient_data_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/book_appointment_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_book_time_slots_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_my_appointment_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_doctors_by_category_use_case.dart';

// ─── Feature: Home — Presentation Layer ──────────────────────────────────────
import 'package:new_medicaa/features/home/presentation/manager/home_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/doctor_cubit.dart';

// ─── Feature: Payment — Data Layer ───────────────────────────────────────────
import 'package:dio/dio.dart';
import 'package:new_medicaa/features/payment/data/datasources/paymob_remote_data_source.dart';
import 'package:new_medicaa/features/payment/data/repositories/payment_repository_impl.dart';

// ─── Feature: Payment — Domain Layer ─────────────────────────────────────────
import 'package:new_medicaa/features/payment/domain/repositories/payment_repository.dart';
import 'package:new_medicaa/features/payment/domain/use_case/getcard_payment_key_use_case.dart';

// ─── Feature: Payment — Presentation Layer ───────────────────────────────────
import 'package:new_medicaa/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:new_medicaa/features/payment/presentation/cubit/payment_state.dart';

/// Global Service Locator instance.
final GetIt sl = GetIt.instance;

/// Call this once in [main()] before [runApp()], after Firebase.initializeApp().
Future<void> setupServiceLocator() async {
  // ══════════════════════════════════════════════════════════════════
  // EXTERNAL PACKAGES
  // ══════════════════════════════════════════════════════════════════

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // ══════════════════════════════════════════════════════════════════
  // CORE SERVICES
  // ══════════════════════════════════════════════════════════════════

  sl.registerLazySingleton<Databasabaseservice>(
    () => Databasabaseservice(firestoreService: sl<FirebaseFirestore>()),
  );

  // ══════════════════════════════════════════════════════════════════
  // AUTH FEATURE — DATA LAYER
  // ══════════════════════════════════════════════════════════════════

  // Data Sources
  sl.registerLazySingleton<FirebaseAuthServic>(
    () => FirebaseAuthServic(sl<FirebaseAuth>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseAuthServic: sl<FirebaseAuthServic>(),
      databaseservice: sl<Databasabaseservice>(),
    ),
  );

  // ══════════════════════════════════════════════════════════════════
  // AUTH FEATURE — DOMAIN LAYER (Use Cases)
  // ══════════════════════════════════════════════════════════════════

  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetCurrentUserUsecase>(
    () => GetCurrentUserUsecase(sl<AuthRepository>()),
  );

  // ══════════════════════════════════════════════════════════════════
  // AUTH FEATURE — PRESENTATION LAYER (Cubit / Bloc)
  // ══════════════════════════════════════════════════════════════════

  // Registered as Factory so a fresh instance is created each time
  // it is injected (e.g., when wrapping a screen with BlocProvider).
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepository>()));

  // ══════════════════════════════════════════════════════════════════
  // PATIENT PROFILE FEATURE — DATA LAYER
  // ══════════════════════════════════════════════════════════════════

  // Data Sources
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<PatientRepo>(
    () => PatientRepoImpl(
      databaseservice: sl<Databasabaseservice>(),
      localDataSource: sl<ProfileLocalDataSource>(),
      firebaseAuthServic: sl<FirebaseAuthServic>(),
    ),
  );

  // ══════════════════════════════════════════════════════════════════
  // PATIENT PROFILE FEATURE — PRESENTATION LAYER (Cubit / Bloc)
  // ══════════════════════════════════════════════════════════════════

  // Registered as Factory so a fresh instance is created per screen.
  sl.registerFactory<PatientCubit>(() => PatientCubit(sl<PatientRepo>()));

  // ══════════════════════════════════════════════════════════════════
  // HOME FEATURE — DATA LAYER
  // ══════════════════════════════════════════════════════════════════

  // Data Sources
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(
      databaseService: sl<Databasabaseservice>(),
      homeLocalDataSource: sl<HomeLocalDataSource>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl<HomeRemoteDataSource>(),
      localDataSource: sl<HomeLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(
      sl<FirebaseFirestore>(),
      sl<HomeRemoteDataSource>(),
    ),
  );

  // ══════════════════════════════════════════════════════════════════
  // HOME FEATURE — DOMAIN LAYER (Use Cases)
  // ══════════════════════════════════════════════════════════════════

  sl.registerLazySingleton<GetDoctorsUseCase>(
    () => GetDoctorsUseCase(sl<HomeRepository>()),
  );

  sl.registerLazySingleton<GetPatientDataUseCase>(
    () => GetPatientDataUseCase(sl<HomeRepository>()),
  );

  sl.registerLazySingleton<BookAppointmentUseCase>(
    () => BookAppointmentUseCase(sl<AppointmentRepository>()),
  );

  sl.registerLazySingleton<GetBookedTimeSlotsUseCase>(
    () => GetBookedTimeSlotsUseCase(sl<AppointmentRepository>()),
  );

  sl.registerLazySingleton<GetMyAppointmentUseCase>(
    () => GetMyAppointmentUseCase(sl<AppointmentRepository>()),
  );

  sl.registerLazySingleton<GetDoctorsByCategoryUseCase>(
    () => GetDoctorsByCategoryUseCase(sl<HomeRepository>()),
  );

  // ══════════════════════════════════════════════════════════════════
  // HOME FEATURE — PRESENTATION LAYER (Cubit / Bloc)
  // ══════════════════════════════════════════════════════════════════

  sl.registerFactory<HomeCubit>(
    () => HomeCubit(
      getDoctorsUseCase: sl<GetDoctorsUseCase>(),
      getPatientDataUseCase: sl<GetPatientDataUseCase>(),
    ),
  );

  sl.registerFactory<AppointmentCubit>(
    () => AppointmentCubit(
      sl<GetBookedTimeSlotsUseCase>(),
      sl<BookAppointmentUseCase>(),
      getPatientDataUseCase: sl<GetPatientDataUseCase>(),
      getMyAppointmentUseCase: sl<GetMyAppointmentUseCase>(),
    ),
  );

  sl.registerFactory<DoctorCubit>(
    () => DoctorCubit(
      getDoctorsByCategoryUseCase: sl<GetDoctorsByCategoryUseCase>(),
    ),
  );

  // ══════════════════════════════════════════════════════════════════
  // PAYMENT FEATURE — DATA LAYER
  // ══════════════════════════════════════════════════════════════════

  // External: Dio HTTP client
  sl.registerLazySingleton<Dio>(() => Dio());

  // Data Sources
  sl.registerLazySingleton<BasePaymobRemoteDataSource>(
    () => PaymobRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // Repositories
  sl.registerLazySingleton<BasePaymentRepository>(
    () => PaymentRepositoryImpl(
      basePaymobRemoteDataSource: sl<BasePaymobRemoteDataSource>(),
    ),
  );

  // ══════════════════════════════════════════════════════════════════
  // PAYMENT FEATURE — DOMAIN LAYER (Use Cases)
  // ══════════════════════════════════════════════════════════════════

  sl.registerLazySingleton<GetCardPaymentKeyUseCase>(
    () => GetCardPaymentKeyUseCase(sl<BasePaymentRepository>()),
  );

  sl.registerLazySingleton<GetWalletPaymentUrlUseCase>(
    () => GetWalletPaymentUrlUseCase(sl<BasePaymentRepository>()),
  );

  // ══════════════════════════════════════════════════════════════════
  // PAYMENT FEATURE — PRESENTATION LAYER (Cubit / Bloc)
  // ══════════════════════════════════════════════════════════════════

  sl.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      PaymentInitial(),
      getCardPaymentKeyUseCase: sl<GetCardPaymentKeyUseCase>(),
      getWalletPaymentUrlUseCase: sl<GetWalletPaymentUrlUseCase>(),
      getPatientDataUseCase: sl<GetPatientDataUseCase>(),
    ),
  );
}
