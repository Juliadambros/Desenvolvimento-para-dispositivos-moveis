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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Primeiro trabalho da disciplina Desenvolvimento de Dispositivos Móveis\n"
              "Aluna: Júlia Dambrós\n\n"
              "Este aplicativo consome a OMDb API, que fornece informações sobre filmes, "
              "como título, ano, nota do IMDb e sinopse.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BuscaFilmePage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: cianoNeon, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x66B026FF),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search, color: cianoNeon, size: 35), // maior
                      const SizedBox(width: 20),
                      Text(
                        "Buscar Filme",
                        style: TextStyle(
                          color: roxoNeon,
                          fontSize: 26, // maior
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

