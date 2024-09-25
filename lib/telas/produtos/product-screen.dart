import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_completa/models/gerenciador-cart.dart';
import 'package:loja_virtual_completa/models/gerenciador-usuario.dart';
import 'package:loja_virtual_completa/models/produto.dart';
import 'package:loja_virtual_completa/telas/produtos/item-tamanho.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final Produto produto;
  ProductScreen(this.produto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: produto,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 125, 141),
          centerTitle: true,
          title: Text(produto.name!),
          actions: [
            Consumer<GerenciadorUsuario>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          "/editar-produto",
                          arguments: produto);
                    },
                    icon: Icon(Icons.edit),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        body: ListView(
          children: [
            BannerCarousel(
              customizedBanners: _retornarImagens(),
              activeColor: Colors.amber,
              width: 250,
              height: 250,
              animation: true,
              borderRadius: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    produto.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "A partir de:",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  Text(
                    "R\$ ${produto.basePrice.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Descrição",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    produto.description!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Tamanhos",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: produto.sizes.map((w) {
                      return ItemTamanho(w);
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _retornarBotao(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _retornarImagens() {
    List<Widget> listaImgs = [];
    for (int i = 0; i < produto.images!.length; i++) {
      listaImgs.add(Image.network(produto.images![i]));
    }
    return listaImgs;
  }

  Widget _retornarBotao(BuildContext context) {
    if (produto.hasStock) {
      return Consumer2<GerenciadorUsuario, Produto>(
        builder: (_, gerenciadorUsuario, produto, child) {
          return SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: produto.selectedSize != null && produto.selectedSize.name != null
                  ? () {
                      if (gerenciadorUsuario.usuarioLogado) {
                        context
                            .read<GerenciadorCarrinho>()
                            .addToCart(produto);
                        Navigator.pushNamed(context, "/tela-carrinho");
                      } else {
                        Navigator.of(context).pushNamed("/tela-login");
                      }
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
              ),
              child: Text(
                gerenciadorUsuario.usuarioLogado
                    ? "Adicionar ao carrinho"
                    : "Entre para comprar",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
