import 'package:apk_auth/view/components/my_button.dart';
import 'package:apk_auth/view/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Icon(Icons.lock, size: 100),
              SizedBox(height: 50),
              Text(
                'Seja bem Vindo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              MyTextfield(
                controller: userNameController,
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 15),
              MyTextfield(
                controller: passwordController,
                hintText: "Senha",
                obscureText: true,
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Esqueceu sua senha?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              MyButton(onTap: signUserIn, text: "Entrar"),
              SizedBox(height: 25,),



              SizedBox(width: 5,),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Registre-se Agora",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
