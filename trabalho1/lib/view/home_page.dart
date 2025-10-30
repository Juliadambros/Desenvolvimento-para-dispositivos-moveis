import 'package:flutter/material.dart';
import 'package:trabalho1/view/busca_filme_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Color roxoNeon = const Color(0xFFB026FF);
  final Color cianoNeon = const Color(0xFF00FFF6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Busca de Filmes",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Primeiro trabalho da disciplina\nDesenvolvimento de Dispositivos Móveis",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: cianoNeon,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Aluna: Júlia Dambrós\n\n"
                  "Este aplicativo consome a OMDb API, "
                  "que fornece informações sobre filmes como título, ano, nota do IMDb e sinopse.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 150), 
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 35,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BuscaFilmePage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cianoNeon, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: cianoNeon.withAlpha(80),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: roxoNeon.withAlpha(60),
                        blurRadius: 14,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search, color: cianoNeon, size: 26),
                      const SizedBox(width: 14),
                      Text(
                        "Buscar Filme",
                        style: TextStyle(
                          color: roxoNeon,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
