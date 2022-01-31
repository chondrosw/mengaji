import 'package:flutter/material.dart';
import 'package:mengaji/Shared/shared.dart';
import 'package:mengaji/View/Pages/LoginPageView.dart';
import 'package:mengaji/View/Pages/RegisterPageView.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                "assets/onboarding.png",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "Membaca Al-quran",
              style: poppinsTitle1,
            ),
            Text(
              "Jadilah Al-quran \n sebagai pedomanmu\nagar membantu di hari kelak",
              style: poppinsTitle3,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 160,
                  child: TextButton(

                      style: TextButton.styleFrom(backgroundColor: primaryColor),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPageView()));
                      },
                      child: Text("Login",style: poppinsWhiteButton1,)),
                ),
                SizedBox(
                  width: 160,
                  child: TextButton(

                      style: TextButton.styleFrom(backgroundColor: secondaryColor),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPageView()));
                      },
                      child: Text("Register",style: poppinsWhiteButton1,)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
