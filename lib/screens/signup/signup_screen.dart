import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual_completa/helpers/validators.dart';
import 'package:loja_virtual_completa/models/user.dart';
import 'package:loja_virtual_completa/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  UserModel user = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        title: const Text(
          "Criar conta",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Consumer<UserManager>(
              builder: (context,userManager,child){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Nome Completo"
                      ),
                      enabled: !userManager.loading,
                      onSaved: (name)=> user.name = name,
                      validator: (name){
                        if(name == null || name.isEmpty){
                          return "Campo obrigatório";
                        }else if(name.trim().split(" ").length ==1){
                          return "Preencha seu nome completo";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "E-mail"
                      ),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      onSaved: (email)=> user.email = email,
                      validator: (email){
                        if(email == null || email.isEmpty){
                          return "Campo obrigatório";
                        }else if(!emailValid(email)){
                          return "E-mail inválido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Senha"
                      ),
                      obscureText: true,
                      enabled: !userManager.loading,
                      onSaved: (pass)=> user.password = pass,
                      validator: (pass){
                        if(pass == null || pass.isEmpty){
                          return "Campo obrigatório";
                        }else if(pass.length < 6){
                          return "Senha muito curta";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Repita a senha"
                      ),
                      enabled: !userManager.loading,
                      onSaved: (pass)=> user.confirmPassowrd = pass,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading ? null :(){
                          if( _formKey.currentState!.validate()){
                            _formKey.currentState!.save();

                            if(user.password != user.confirmPassowrd){
                              ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                content: Text("Senhas não coicidem"),
                                backgroundColor: Colors.red,
                              ));
                              return ;
                            }

                            userManager.signUp(
                                userModel: user,
                                onSuccess: (){
                                  Navigator.of(context).pop();
                                },
                                onFail: (e){
                                  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                    content: Text("Falha ao cadastrar"),
                                    backgroundColor: Colors.red,
                                  ));
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
                        ) :const Text(
                          "Criar Conta",
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
