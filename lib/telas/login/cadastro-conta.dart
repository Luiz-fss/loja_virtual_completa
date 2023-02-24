import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/helpers/validators.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';
import 'package:provider/provider.dart';

class CadastroConta extends StatelessWidget {
  CadastroConta({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nomeCompletoController = TextEditingController();
  TextEditingController repetirSenhaController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  Usuario novoUsuario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
        backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<GerenciadorUsuario>(
              builder: (_,gerenciadorUsuario,child){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: nomeCompletoController,
                      decoration: const InputDecoration(
                          hintText: "Nome Completo"
                      ),
                      validator: (nome){
                        if(nome == null || nome!.isEmpty){
                          return "Campo Obrigatorio";
                        }else if (nome.trim().split(" ").length <=1){
                          return "Preencha seu nome completo";
                        }
                      },
                      onSaved: (nomeCompleto)=> novoUsuario.nomeCompleto = nomeCompleto,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "E-mail"
                      ),
                      validator: (email){
                        if(email == null || email!.isEmpty){
                          return "Campo Obrigatorio";
                        }else if(!validarEmail(email)){
                          return "E-mail inválido";
                        }
                      },
                      onSaved: (email)=> novoUsuario.email = email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Senha"
                      ),
                      obscureText: true,
                      validator: (senha){
                        if (senha == null || senha!.isEmpty){
                          return "Campo Obrigatório";
                        }else if(senha.length < 6){
                          return "Senha muito curta";
                        }
                      },
                      onSaved: (senha)=> novoUsuario.senha = senha,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Repita a senha"
                      ),
                      obscureText: true,
                      validator: (senha){
                        if(senha!.isEmpty || senha.length < 6){
                          return "Senha Inválida";
                        }else{
                          return null;
                        }
                      },
                      onSaved: (repeticaoSenha)=>novoUsuario.confirmacaoSenha = repeticaoSenha,
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            if(novoUsuario.senha != novoUsuario.confirmacaoSenha){
                              ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                content: Text("Senhas não coincidem"),
                                backgroundColor: Colors.red,
                              ));
                              return ;
                            }else{
                              gerenciadorUsuario.signUp(
                                  usuario: novoUsuario,
                                  onFail: (e){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Falha ao cadastrar novo usuario: ${e}"),
                                      backgroundColor: Colors.red,
                                    ));
                                  },
                                  onSucess: (){}
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 4, 125, 141),),
                        ),
                        child: const Text(
                          "Criar Conta",
                          style: TextStyle(
                              fontSize: 18
                          ),
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
