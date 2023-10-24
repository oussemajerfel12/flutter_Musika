// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:musika/View/MasterPage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ViewModel/LoginViewModel.dart';
import '../consts/Mygradient.dart';

class LoginView extends GetView<LoginViewModel> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginView({Key? key}) : super(key: key);
  bool debugPrintGestureArenaDiagnostics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(gradient: MyGradient.getGradient()),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width * 2,
              child: Image(
                image: AssetImage('lib/Resources/drawable/musikasplash.png'),
                width: 1000,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(
              height: 40,
            ),

            /*  TextFormField(
                obscureText: false,
                controller: emailController,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.white), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  labelText: 'Identifier',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 249, 248, 251),
                    fontSize: 20, //<-- SEE HERE
                  ),
                )),*/
            /*const SizedBox(
              height: 40,
            ),
             TextFormField(
                obscureText: true,
                controller: passwordController,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.white), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 249, 248, 251),
                    fontSize: 20, //<-- SEE HERE
                  ),
                )),*/ /*
            const SizedBox(
              height: 40,
            ),
            
            GestureDetector(
              onTap: () {
                controller.login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('CONNECT',
                      style: TextStyle(
                          color: Color.fromARGB(214, 7, 6, 26),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),*/
            GestureDetector(
              onTap: () async {
                await controller.loginSSO(context);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text('CONNECT',
                      style: TextStyle(
                          color: Color.fromARGB(214, 7, 6, 26),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            /*  const Divider(color: Colors.white, thickness: 2),
            const SizedBox(
              height: 0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Vous n' + "'" + 'avez pas un compte ?',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              TextButton(
                  child: const Text(
                    'S' + "'" + 'inscrire',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    launch(
                        'https://integ03-cmam.archimed.fr/MUSIKA/'); // Replace with the desired URL
                  })
            ]), /*
            TextButton(
                child: const Text(
                  'FORGOT YOUR PASSWORD?',
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
                onPressed: () {
                  launch('https://integ03-cmam.archimed.fr/MUSIKA/');
                })*/*/
          ],
        ),
      ),
    );
  }
}
