import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengaji/Bloc/AuthBloc.dart';
import 'package:mengaji/Shared/shared.dart';
import 'package:mengaji/View/Components/CustomTextField.dart';

import 'MainPageView.dart';

class LoginPageView extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget loginAccount() {
      return BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shadowColor: Colors.black.withOpacity(0.7)),
                onPressed: () async {
                  print(state);
                  if (formKey.currentState!.validate()) {
                    context.read<AuthCubit>().login(
                        email: emailController.value.text.trim(),
                        password: passwordController.value.text.trim());
                  }
                },
                child: Text(
                  "Create Account",
                  style: poppinsWhiteButton1,
                )));
      }, listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPageView()),
              (route) => false);
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Silahkan dibaca errornya kak")));
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
            )),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hallo Pembaca Al-quran",
                style: poppinsTitle1,
                textAlign: TextAlign.center,
              ),
              Text(
                "Semoga harimu diberi keberkahan",
                style: poppinsTitle3,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextField(
                isEmail: true,
                controller: emailController,
                title: "Email",
                hint: "Your Email",
                error: error,
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextField(
                isEmail: false,
                controller: passwordController,
                title: "Password",
                hint: "Your Password",
                error: error,
              ),
              SizedBox(
                height: 72,
              ),
              loginAccount(),
              SizedBox(
                height: 28,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                            spreadRadius: 2)
                      ]),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.red,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset("assets/google.jpg")),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          Text(
                            "Google Sign in",
                            style: poppinsTitle3.copyWith(
                                color: Colors.black, fontSize: 14),
                          )
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
