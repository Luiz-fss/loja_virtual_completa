import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.account_circle,
                color: Theme.of(context).primaryColor,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Faça login para acessar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed("/login");
                },
                style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.all<Color>(
                      Theme.of(context).primaryColor),),
                child: Text("Login",style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
