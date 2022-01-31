import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mengaji/Bloc/AuthBloc.dart';
import 'package:mengaji/Shared/shared.dart';
import 'package:mengaji/View/Components/CustomTextField.dart';
import 'package:mengaji/View/Pages/MainPageView.dart';
import 'package:provider/src/provider.dart';

class RegisterPageView extends StatefulWidget {
  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  String error = "";

  String passwordError = "";

  DateTime selectedDate = DateTime.now();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmationController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget createAccount() {
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
                onPressed: ()async{
                  print(state);
                  if (formKey.currentState!.validate() ) {
                    if(confirmationController.value.text == passwordController.value.text){
                      context.read<AuthCubit>().register(
                          email: emailController.text.toString().trim(),
                          password: passwordController.text.toString().trim(),
                          name: nameController.text,
                          date:
                          "${selectedDate.day}:${selectedDate.month}:${selectedDate.year}");
                    } else {
                      passwordError = "Password harus sama";
                    }

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
        }else if (state is AuthFailed){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Silahkan dibaca errornya kak")));
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Membuat Akun",
                  style: poppinsTitle1,
                ),
                Text(
                  "Jangan lupa untuk melengkapi data\nyang kami butuhkan, agar membantu kami",
                  style: poppinsTitle4.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                CustomTextField(
                    isEmail: false,
                    controller: nameController,
                    title: "Name",
                    hint: "nama",
                    error: error),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                    isEmail: true,
                    controller: emailController,
                    title: "Email",
                    hint: "****@email.com",
                    error: error),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                    isEmail: false,
                    controller: passwordController,
                    title: "Password",
                    hint: "Katasandi",
                    error: passwordError),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                    isEmail: false,
                    controller: confirmationController,
                    title: "Confirmation Password",
                    hint: "Ketik Ulang Password",
                    error: passwordError),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? selected = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(1970),
                        lastDate: DateTime.now());
                    if (selected != null && selected != selectedDate) {
                      setState(() {
                        selectedDate = selected;
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              offset: Offset(4, 4))
                        ]),
                    child: Center(
                      child: Text(
                        "${selectedDate.day}:${selectedDate.month}:${selectedDate.year} ",
                        style: poppinsWhiteButton1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                createAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
