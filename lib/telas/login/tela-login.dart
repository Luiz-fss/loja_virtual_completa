import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
   TelaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
        backgroundColor:  const Color.fromARGB(255, 4, 125, 141),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "E-mail",
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (email){},
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Senha",
                ),
                obscureText: true,
                autocorrect: false,
                validator: (senha){
                  if(senha!.isEmpty || senha.length < 6){
                    return "Senha Inválida";
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
                    onPressed: (){},
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
    );
  }
}
