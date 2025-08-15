import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yokapos/core/design_system/components/app_components.dart';
import 'package:yokapos/core/design_system/components/custom_snackbar.dart';
import 'package:yokapos/features/auth/presentation/blocs/auth/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              unauthenticated: (message) {
                customSnackbar(context, message ?? 'Success', isSuccess: true);
              },
              orElse: () {},
            );
          },
          child: AppComponents.textButton(
            text: 'HomeScreen',
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ),
      ),
    );
  }
}
