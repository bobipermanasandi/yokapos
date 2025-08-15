import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yokapos/core/routing/route_names.dart';
import 'package:yokapos/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:yokapos/features/auth/presentation/screens/login_screen.dart';
import 'package:yokapos/features/auth/presentation/screens/register_screen.dart';
import 'package:yokapos/features/home/presentation/screens/home_screen.dart';

class AuthBlocListenable extends ChangeNotifier {
  final AuthBloc _authBloc;
  StreamSubscription<AuthState>? _subscription;

  AuthBlocListenable(this._authBloc) {
    _subscription = _authBloc.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

class AppRouter {
  AppRouter(this._authBloc) {
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  final AuthBloc _authBloc;

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.home,
    redirect: (context, state) {
      final authState = _authBloc.state;
      // Jika user sudah authenticated, redirect ke home
      if (authState.maybeWhen(
        authenticated: (user) => user != null,
        orElse: () => false,
      )) {
        // Jika sudah di home, tidak perlu redirect
        if (state.matchedLocation == RouteNames.home) {
          return null;
        }
        // Redirect ke home
        return RouteNames.home;
      }

      // Jika user tidak authenticated dan mencoba akses home, redirect ke login
      if (state.matchedLocation == RouteNames.home) {
        return RouteNames.login;
      }

      // Jika di login dan tidak authenticated, tetap di login
      return null;
    },
    refreshListenable: AuthBlocListenable(_authBloc),
    routes: [
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
  );
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

/// Error Page
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty State'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(RouteNames.home),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go(RouteNames.home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
