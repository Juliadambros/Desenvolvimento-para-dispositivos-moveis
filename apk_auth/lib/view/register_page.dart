import 'package:apk_auth/view/components/my_button.dart';
import 'package:apk_auth/view/components/my_textfield.dart';
import 'package:apk_auth/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void showAlert(String msg){
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void showWaiting(){
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void register() async {
    showWaiting();
    try {
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userNameController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      }else{
        Navigator.pop(context);
        showAlert("Senhas não Conferem!");
      }
    //no trabalho precisa verificar as outras msg de erro 
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        Navigator.pop(context);
        showAlert("Já existe um usuário com esse email!");
        
      }
      if (e.code == 'weak-password') {
        Navigator.pop(context);
        showAlert("A senha precisa ter no mínimo seis caracteres!");
        
      }
    }
  }

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
                Text('Crie seu cadastro!', style: TextStyle(fontSize: 18),),
                SizedBox(height: 2),
                MyTextfield(
                  controller: userNameController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                SizedBox(height: 15),
                
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 15),
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirmação de Senha',
                  obscureText: true,
                ),
                SizedBox(height: 15),
                MyButton(onTap: register, text: 'Cadastrar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
