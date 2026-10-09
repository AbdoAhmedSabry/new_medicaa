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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  bool _sent = false;

  @override
  void dispose() {
    emailController.dispose();
    _formKey.currentState?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBgBottom,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            setState(() => _sent = true);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? 'an_error_occurred'.tr(),
                  style: const TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              WaveHeader(
                onBack: () => Navigator.of(context).maybePop(),
                child: const MediCareBrand(),
              ),

              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      r.horizontalPadding,
                      24.h,
                      r.horizontalPadding,
                      24.h,
                    ),
                    child: _sent ? _buildSuccess(context) : _buildForm(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 72.r,
                height: 72.r,
              decoration: const BoxDecoration(
                color: AppColors.fieldIconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                color: AppColors.primaryColor,
                size: 34.r,
              ),
            ),
          ),
          SizedBox(height: 18.h),

          Text(
            'forgot_password'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.font26LexendBold.copyWith(
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 8.h),

          Text(
            'forgot_password_subtitle'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.font14InterRegular.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          SizedBox(height: 28.h),

          AppTextField(
            hint: 'email_address'.tr(),
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: AppValidator.validateEmail,
          ),
          SizedBox(height: 24.h),

          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (prev, cur) =>
                cur is ForgotPasswordLoading || prev is ForgotPasswordLoading,
            builder: (context, state) => GradientButton(
              label: 'send_reset_link'.tr(),
              loading: state is ForgotPasswordLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthCubit>().forgotPassword(
                    emailController.text.trim(),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 22.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'remember_your_password'.tr(),
                style: AppTextStyles.font13InterRegular.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.loginScreen),
                child: Text(
                  'login'.tr(),
                  style: AppTextStyles.font13InterSemiBold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 84.r,
            height: 84.r,
            decoration: const BoxDecoration(
              color: AppColors.successGreenBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_read_rounded,
              color: AppColors.successGreen,
              size: 40.r,
            ),
          ),
        ),
        SizedBox(height: 20.h),

        Text(
          'check_your_email_title'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.font26LexendBold.copyWith(
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 8.h),

        Text(
          'reset_link_sent'.tr(namedArgs: {'email': emailController.text}),
          textAlign: TextAlign.center,
          style: AppTextStyles.font14InterRegular.copyWith(
            color: AppColors.textGrey,
          ),
        ),
        SizedBox(height: 28.h),

        GradientButton(
          label: 'back_to_login'.tr(),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, Routes.loginScreen),
        ),
        SizedBox(height: 18.h),

        Center(
          child: TextButton(
            onPressed: () => setState(() => _sent = false),
            child: Text(
              'didnt_receive_email_resend'.tr(),
              style: AppTextStyles.font13InterSemiBold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
