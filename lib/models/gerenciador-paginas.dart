import 'package:flutter/material.dart';

class GerenciadorPaginas {
  GerenciadorPaginas(this._pageController);
  final PageController _pageController;
  int paginaAtual =0;

  void setPage (int pagina){
    if(paginaAtual != pagina){
      paginaAtual = pagina;
      _pageController.jumpToPage(pagina);
    }

  }
}