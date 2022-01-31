import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengaji/Bloc/AuthBloc.dart';
import 'package:mengaji/Shared/shared.dart';
import 'package:mengaji/View/Pages/OnboardingPageView.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget logoutButton() {
      return BlocConsumer<AuthCubit,AuthState>(builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return TextButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            child: Text(
              "Logout",
              style: poppinsWhiteButton1.copyWith(color: Colors.red),
            ));
      }, listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => OnboardingPageView()),
              (route) => false);
        }
      });
    }

    Widget account() {
      return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthSuccess) {
          return Column(
            children: [
              Text(state.user.name!),
              Text(state.user.date!),
              logoutButton()
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      });
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [account()],
        ),
      ),
    );
  }
}
