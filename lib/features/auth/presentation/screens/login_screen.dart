import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/const/validator.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/auth/presentation/manager/auth_cubit.dart';
import 'package:new_medicaa/features/auth/presentation/manager/authstate.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/app_text_field.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/curved_header.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/gradient_button.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/medicare_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, Routes.mainLayoutScreen);
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.errorRed,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(15.r),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.bgGradient),
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.horizontalPadding,
                    vertical: 16.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: r.isTablet ? 10.h : 4.h),
                        const Center(child: MediCareBrand()),
                        SizedBox(height: r.isTablet ? 24.h : 16.h),

                        Text(
                          'welcome_back'.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font26LexendBold.copyWith(
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'please_login_to_your_account'.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font14InterRegular.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        AppTextField(
                          hint: 'email_address'.tr(),
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: AppValidator.validateEmail,
                        ),
                        SizedBox(height: 10.h),

                        AppTextField(
                          hint: 'password'.tr(),
                          icon: Icons.lock_outline,
                          isPassword: true,
                          controller: _passwordController,
                          validator: AppValidator.validatePassword,
                        ),
                        SizedBox(height: 10.h),

                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(10, 10),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              Routes.forgotPasswordScreen,
                            ),
                            child: Text(
                              'forgot_password'.tr(),
                              style: AppTextStyles.font14InterSemiBold.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) => GradientButton(
                            label: 'login'.tr(),
                            loading: state is LoginLoading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<AuthCubit>()
                                    .signInWithEmailAndPassword(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),

                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.dividerLine),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                'or'.tr(),
                                style: AppTextStyles.font13InterRegular
                                    .copyWith(color: AppColors.textGrey),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.dividerLine),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),

                        BlocBuilder<AuthCubit, AuthState>(
                          buildWhen: (prev, cur) =>
                              cur is FacebookLoading ||
                              prev is FacebookLoading ||
                              cur is GoogleLoading ||
                              prev is GoogleLoading ||
                              cur is AuthInitial,
                          builder: (context, state) => Column(
                            children: [
                              _SocialButton(
                                label: 'continue_with_google'.tr(),
                                leading: Text(
                                  'G',
                                  style: AppTextStyles.font18InterSemiBold
                                      .copyWith(
                                        color: AppColors.googleBlue,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                onTap: () {
                                  if (state is! GoogleLoading) {
                                    context
                                        .read<AuthCubit>()
                                        .signInWithGoogle();
                                  }
                                },
                              ),
                              SizedBox(height: 10.h),
                              _SocialButton(
                                label: 'continue_with_facebook'.tr(),
                                leading: Icon(
                                  Icons.facebook,
                                  color: AppColors.facebookBlue,
                                ),
                                onTap: () {
                                  if (state is! FacebookLoading) {
                                    context
                                        .read<AuthCubit>()
                                        .signInWithFacebook();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'dont_have_an_account'.tr(),
                              style: AppTextStyles.font13InterRegular.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                Routes.signupScreen,
                              ),
                              child: Text(
                                'sign_up'.tr(),
                                style: AppTextStyles.font13InterSemiBold
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget leading;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.socialButtonBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading,
            SizedBox(width: 10.w),
            Text(
              label,
              style: AppTextStyles.font14InterSemiBold.copyWith(
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
