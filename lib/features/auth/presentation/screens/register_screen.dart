import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/const/validator.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/auth/presentation/manager/auth_cubit.dart';
import 'package:new_medicaa/features/auth/presentation/manager/authstate.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/app_text_field.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/auth_social.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/curved_header.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/gradient_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _agreed = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleCreateAccount(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            'please_agree_to_terms'.tr(),
            style: const TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }
    context.read<AuthCubit>().signUpWithEmailAndPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
      _mobileController.text.trim(),
    );
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
            final userModel = UserModel(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              phone: _mobileController.text.trim(),
              uid: state.user.uid,
            );
            Navigator.pushReplacementNamed(
              context,
              Routes.checkMailScreen,
              arguments: userModel,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Curved blue header with back arrow
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
                      12.h,
                      r.horizontalPadding,
                      16.h,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'create_account'.tr(),
                            style: AppTextStyles.font26LexendBold.copyWith(
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'lets_get_you_all_set_up'.tr(),
                            style: AppTextStyles.font14InterRegular.copyWith(
                              color: AppColors.textGrey,
                            ),
                          ),
                          SizedBox(height: 12.h),

                          AppTextField(
                            hint: 'full_name'.tr(),
                            icon: Icons.person_outline,
                            controller: _nameController,
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'please_enter_your_full_name'.tr()
                                : null,
                          ),
                          SizedBox(height: 10.h),

                          AppTextField(
                            hint: 'email_address'.tr(),
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: AppValidator.validateEmail,
                          ),
                          SizedBox(height: 10.h),

                          AppTextField(
                            hint: 'phone_number'.tr(),
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            controller: _mobileController,
                            validator: AppValidator.validatePhoneNumber,
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

                          AppTextField(
                            hint: 'confirm_password'.tr(),
                            icon: Icons.lock_outline,
                            isPassword: true,
                            controller: _confirmController,
                            validator: (v) {
                              if (v != _passwordController.text) {
                                return 'passwords_do_not_match'.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 22.r,
                                height: 22.r,
                                child: Checkbox(
                                  value: _agreed,
                                  activeColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  onChanged: (v) =>
                                      setState(() => _agreed = v ?? false),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(top: 3.h),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        'i_agree_to_the'.tr(),
                                        style: AppTextStyles.font13InterRegular
                                            .copyWith(
                                              color: AppColors.textGrey,
                                            ),
                                      ),
                                      Text(
                                        'terms_and_conditions'.tr(),
                                        style: AppTextStyles.font13InterSemiBold
                                            .copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                      ),
                                      Text(
                                        'and'.tr(),
                                        style: AppTextStyles.font13InterRegular
                                            .copyWith(
                                              color: AppColors.textGrey,
                                            ),
                                      ),
                                      Text(
                                        'privacy_policy'.tr(),
                                        style: AppTextStyles.font13InterSemiBold
                                            .copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),

                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) => GradientButton(
                              label: 'create_account'.tr(),
                              onPressed: () => _handleCreateAccount(context),
                              loading: state is RegisterLoading,
                            ),
                          ),
                          SizedBox(height: 14.h),

                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen: (prev, cur) =>
                                cur is FacebookLoading ||
                                prev is FacebookLoading ||
                                cur is GoogleLoading ||
                                prev is GoogleLoading ||
                                cur is AuthInitial,
                            builder: (context, state) => CustomSocialButton(
                              isFacebookLoading: state is FacebookLoading,
                              isGoogleLoading: state is GoogleLoading,
                              facebooktap: () => context
                                  .read<AuthCubit>()
                                  .signInWithFacebook(),
                              googletap: () =>
                                  context.read<AuthCubit>().signInWithGoogle(),
                            ),
                          ),
                          SizedBox(height: 14.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'already_have_an_account'.tr(),
                                style: AppTextStyles.font13InterRegular
                                    .copyWith(color: AppColors.textGrey),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                  context,
                                  Routes.loginScreen,
                                ),
                                child: Text(
                                  'login'.tr(),
                                  style: AppTextStyles.font13InterSemiBold
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
