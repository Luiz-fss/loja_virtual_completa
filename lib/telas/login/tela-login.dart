import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/helpers/validators.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/usuario-model.dart';
import 'package:provider/provider.dart';

class TelaLogin extends StatelessWidget {
   TelaLogin({Key? key}) : super(key: key);

   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
   TextEditingController emailController = TextEditingController();
   TextEditingController senhaController = TextEditingController();
   final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldState,
      backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
        backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                  ),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email){
                    if(!validarEmail(email!)){
                      return "E-mail inválido";
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  autocorrect: false,
                  controller: senhaController,
                  validator: (senha){
                    if(senha!.isEmpty || senha.length < 6){
                      return "Senha Inválida";
                    }else{
                      return null;
                    }
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){},
                    child: const Text(
                        "Esqueci minha senha",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                      onPressed: (){
                       if( formKey.currentState!.validate()){
                         Usuario usuario =  Usuario();
                         usuario.email = emailController.text;
                         usuario.senha = senhaController.text;
                         context.read<GerenciadorUsuario>().signIn(
                             usuario: usuario,
                             onFail: (e){
                               ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                 content: Text("Falha ao entrar: ${e}"),
                                 backgroundColor: Colors.red,
                               ));
                             },
                             onSucess: (){});
                       }
                      },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 4, 125, 141),),
                    ),
                      child: const Text(
                          "Entrar",
                        style: TextStyle(
                          fontSize: 18
                        ),
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
