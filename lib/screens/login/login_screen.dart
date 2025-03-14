import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual_completa/models/user.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:provider/provider.dart';

import '../../helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: const Color.fromARGB(255, 4, 125, 141),
      appBar: AppBar(
        title: const Text(
          "Entrar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/signup");
              },
              child: const Text(
                "CRIAR CONTA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                ),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Consumer<UserManager>(
              builder: (context,userManager, child){
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      controller: _emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "E-mail",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return "E-mail inválido";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "Senha",
                      ),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass == null || pass.isEmpty || pass.length < 6) {
                          return "Senha inválida";
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Esqueci minha senha",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading ? null :() {
                          if (_formKey.currentState!.validate()) {
                            final UserModel user = UserModel(
                                email: _emailController.text,
                                password: _passController.text);
                            userManager
                                .signIn(user: user,
                                onFail: (e) {
                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                    content: Text("Falha ao entrar: ${e}"),
                                    backgroundColor: Colors.red,
                                  ));
                                },
                                onSuccess: (){
                                  Navigator.of(context).pop();
                                }
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          surfaceTintColor: Theme.of(context).primaryColor.withAlpha(100)
                        ),
                        child: userManager.loading ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                            :const Text(
                          "Entrar",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
