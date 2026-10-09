import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/const/validator.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/auth_button.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_cubit.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_state.dart';
import 'package:new_medicaa/features/patient_profile/presentation/widgets/custom_drop.dart';

class Dataprofile extends StatefulWidget {
  const Dataprofile({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<Dataprofile> createState() => _DataprofileState();
}

class _DataprofileState extends State<Dataprofile> {

  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController chronicDiseasesController =
      TextEditingController();


  String? gender;
  String? bloodType;
  String? pressure;
  String? diabetes;


  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    chronicDiseasesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [

            PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              height: 300,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/profilephoto.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),


            PositionedDirectional(
              top: 260,
              start: 0,
              end: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadiusDirectional.only(
                    topStart: Radius.circular(35),
                    topEnd: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .08),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: BlocConsumer<PatientCubit, PatientState>(
                  listener: (context, state) {
                    if (state is PatientSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'patient_data_updated_successfully'.tr(),
                            style: const TextStyle(color: AppColors.white),
                          ),
                          backgroundColor: AppColors.successGreen,
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.mainLayoutScreen,
                        (route) => false,
                      );
                    }
                    if (state is PatientError) {
                      ScaffoldMessenger.of(context).showSnackBar(
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
                  builder: (context, state) {
                    if (state is PatientLoading) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                    }
                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),


                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff0A8FBE),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'medical_information'.tr(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'medical_information_subtitle'.tr(),
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),


                              CustomTextfield(
                                hintText: 'enter_your_height'.tr(),
                                label: 'height'.tr(),
                                controller: heightController,
                                validator: (value) =>
                                    AppValidator.validateHeight(value),
                                prefix: const Icon(
                                  Icons.height,
                                  color: Color(0xff0A8FBE),
                                ),
                              ),
                              const SizedBox(height: 15),

                              CustomTextfield(
                                hintText: 'enter_your_weight'.tr(),
                                label: 'weight'.tr(),
                                controller: weightController,
                                validator: (value) =>
                                    AppValidator.validateWeight(value),
                                prefix: const Icon(
                                  Icons.monitor_weight_outlined,
                                  color: Color(0xff0A8FBE),
                                ),
                              ),
                              const SizedBox(height: 15),

                              CustomTextfield(
                                hintText: 'enter_your_age'.tr(),
                                label: 'age'.tr(),
                                controller: ageController,
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    AppValidator.validateAge(value),
                                prefix: const Icon(
                                  Icons.cake_outlined,
                                  color: Color(0xff0A8FBE),
                                ),
                              ),
                              const SizedBox(height: 15),

                              CustomTextfield(
                                hintText: 'if_no_diseases_enter_none'.tr(),
                                label: 'chronic_diseases'.tr(),
                                controller: chronicDiseasesController,
                                validator: (value) =>
                                    AppValidator.validateRequired(
                                      value,
                                      'Chronic diseases',
                                    ),
                                prefix: const Icon(
                                  Icons.medical_services_outlined,
                                  color: Color(0xff0A8FBE),
                                ),
                              ),
                              const SizedBox(height: 15),

                     
                              CustomDropdown(
                                hintText: 'gender'.tr(),
                                prefixIcon: Icons.person_outline,
                                items: const ["Male", "Female"],
                                selectedValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 15),

                              CustomDropdown(
                                hintText: 'blood_type'.tr(),
                                prefixIcon: Icons.bloodtype_outlined,
                                items: const [
                                  "A+",
                                  "A-",
                                  "B+",
                                  "B-",
                                  "AB+",
                                  "AB-",
                                  "O+",
                                  "O-",
                                ],
                                selectedValue: bloodType,
                                onChanged: (value) {
                                  setState(() {
                                    bloodType = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 15),

                              CustomDropdown(
                                hintText: 'blood_pressure'.tr(),
                                prefixIcon: Icons.monitor_heart_outlined,
                                items: const ["yes", "no"],
                                selectedValue: pressure,
                                onChanged: (value) {
                                  setState(() {
                                    pressure = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 15),

                              CustomDropdown(
                                hintText: 'diabetes'.tr(),
                                prefixIcon: Icons.health_and_safety_outlined,
                                items: const ["yes", "no"],
                                selectedValue: diabetes,
                                onChanged: (value) {
                                  setState(() {
                                    diabetes = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('i_agree_to_the'.tr()),
                                  InkWell(
                                    onTap: () {
                                    },
                                    child: Text(
                                      'terms_and_conditions'.tr(),
                                      style: const TextStyle(
                                        color: Color(0xff0A8FBE),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  Text('and'.tr()),
                                  InkWell(
                                    onTap: () {
                                    },
                                    child: Text(
                                      'privacy_policy'.tr(),
                                      style: const TextStyle(
                                        color: Color(0xff0A8FBE),
                                        decoration: TextDecoration.underline,
                                      ),
                                      ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                            
                              CustomButton(
                                text: 'confirm'.tr(),
                                onTap: () {
                                  
                                  if (_formKey.currentState!.validate()) {
                                   
                                    if (bloodType == null ||
                                        gender == null ||
                                        pressure == null ||
                                        diabetes == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'please_select_all_required_fields'.tr(),
                                            style: const TextStyle(color: AppColors.white),
                                          ),
                                          backgroundColor: AppColors.errorRed,
                                        ),
                                      );
                                      return;
                                    }

                                  
                                    final double? weight = double.tryParse(
                                      weightController.text,
                                    );
                                    final double? height = double.tryParse(
                                      heightController.text,
                                    );
                                    final int? age = int.tryParse(
                                      ageController.text,
                                    );

                                    if (weight == null ||
                                        height == null ||
                                        age == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'error_parsing_numbers'.tr(),
                                            style: const TextStyle(color: AppColors.white),
                                          ),
                                          backgroundColor: AppColors.errorRed,
                                        ),
                                      );
                                      return;
                                    }

                                   
                                    List<String> diseases = [];
                                    String chronicText =
                                        chronicDiseasesController.text.trim();
                                    if (chronicText.isNotEmpty &&
                                        chronicText.toLowerCase() != 'none') {
                                      diseases = chronicText.split(",");
                                    }

                                   
                                    BlocProvider.of<PatientCubit>(
                                      context,
                                    ).savePatientData(
                                      userModel: widget.userModel,
                                      weight: weight,
                                      height: height,
                                      bloodType: bloodType!,
                                      hasBloodPressure: pressure == "yes",
                                      hasDiabetes: diabetes == "yes",
                                      chronicDiseases: diseases,
                                      gender: gender!,
                                      age: age,
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
