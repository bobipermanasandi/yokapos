import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yokapos/core/design_system/assets/assets.gen.dart';
import 'package:yokapos/core/design_system/components/custom_snackbar.dart';
import 'package:yokapos/core/routing/route_names.dart';
import 'package:yokapos/core/design_system/styles/app_colors.dart';
import 'package:yokapos/core/design_system/styles/app_spacing.dart';
import 'package:yokapos/core/design_system/styles/app_typography.dart';
import 'package:yokapos/core/design_system/components/app_components.dart';
import 'package:yokapos/features/auth/data/models/requests/register_request_model.dart';
import 'package:yokapos/features/auth/presentation/blocs/auth/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController businessNameController;
  late TextEditingController bussinessAddressController;
  bool isRememberVal = false;
  bool obscureText = true;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    businessNameController = TextEditingController();
    bussinessAddressController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    businessNameController.dispose();
    bussinessAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: Center(
                        child: Assets.icons.logo.yokaposWhite.image(
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    AppSpacing.gapVerticalSm,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'YOKA ',
                              style: AppTypography.headlineLarge.copyWith(
                                color: AppColors.primary50,
                                fontWeight: AppTypography.bold,
                              ),
                            ),
                            Text(
                              'POS',
                              style: AppTypography.headlineLarge.copyWith(
                                color: AppColors.yellow,
                                fontWeight: AppTypography.bold,
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.gapVerticalSm,
                        Text(
                          'Create an account or to explore \nabout our app',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                    AppSpacing.gapVerticalHuge,
                    Padding(
                      padding: AppSpacing.horizontalLg,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppComponents.textField(
                              controller: nameController,
                              label: 'Nama',
                              hint: 'Masukkan Nama',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            AppSpacing.gapVerticalMd,
                            AppComponents.textField(
                              controller: emailController,
                              label: 'Email',
                              hint: 'Masukkan Email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            AppSpacing.gapVerticalMd,
                            AppComponents.textField(
                              controller: passwordController,
                              label: 'Password',
                              hint: 'Masukkan password',
                              obscureText: obscureText,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(12),
                                  child: SvgPicture.asset(
                                    (obscureText)
                                        ? Assets.icons.svgs.eye.path
                                        : Assets.icons.svgs.eyeSlash.path,
                                    semanticsLabel: 'Image',
                                    height: 20,
                                    width: 20,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.neutral50.withValues(
                                        alpha: 0.5,
                                      ),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password tidak boleh kosong';
                                }
                                if (value.length < 8) {
                                  return 'password tidak kurang dari 8';
                                }
                                return null;
                              },
                            ),
                            AppSpacing.gapVerticalMd,
                            AppComponents.textField(
                              controller: businessNameController,
                              label: 'Nama Bisnis',
                              hint: 'Masukkan Nama Bisnis',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama Bisnis tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            AppSpacing.gapVerticalMd,
                            AppComponents.textField(
                              controller: bussinessAddressController,
                              label: 'Alamat Bisnis',
                              hint: 'Masukkan Alamat Bisnis',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Alamat Bisnis tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            AppSpacing.gapVerticalLg,
                            BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {},
                                  unauthenticated: (message) {
                                    customSnackbar(
                                      context,
                                      message ?? 'Register Success',
                                    );
                                    context.go(RouteNames.login);
                                  },
                                  failure: (message) {
                                    customSnackbar(
                                      context,
                                      message,
                                      isSuccess: false,
                                    );
                                  },
                                );
                              },
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () {
                                    return AppComponents.primaryButton(
                                      width: double.infinity,
                                      text: 'REGISTER',
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                            RegisterRequested(
                                              RegisterRequestModel(
                                                name: nameController.text,
                                                email: emailController.text
                                                    .trim(),
                                                password:
                                                    passwordController.text,
                                                businessName:
                                                    businessNameController.text,
                                                address:
                                                    bussinessAddressController
                                                        .text,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                  loading: () {
                                    return AppComponents.loadingSpinner(
                                      color: AppColors.primary70,
                                    );
                                  },
                                );
                              },
                            ),
                            AppSpacing.gapVerticalMd,
                            AppComponents.dividerText(text: 'Or register with'),
                            AppSpacing.gapVerticalMd,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppComponents.logoButton(
                                  logo: Assets.icons.svgs.google.path,
                                ),
                                AppComponents.logoButton(
                                  logo: Assets.icons.svgs.fb.path,
                                ),
                                AppComponents.logoButton(
                                  logo: Assets.icons.svgs.apple.path,
                                ),
                                AppComponents.logoButton(
                                  logo: Assets.icons.svgs.mobile.path,
                                ),
                              ],
                            ),
                            AppSpacing.gapVerticalLg,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Have an account? ',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.neutral50,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.go(RouteNames.login);
                                  },
                                  child: Text(
                                    'Login',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.primary50,
                                      fontWeight: AppTypography.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    AppSpacing.gapVerticalHuge,
                    Center(
                      child: FutureBuilder(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) {
                          return Container(
                            margin: EdgeInsets.only(right: 14),
                            child: Text(
                              'App version ${snapshot.data?.version}',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.neutral50.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
