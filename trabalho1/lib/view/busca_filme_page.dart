import 'package:flutter/material.dart';
import 'package:trabalho1/service/busca_filme_service.dart';

class BuscaFilmePage extends StatefulWidget {
  const BuscaFilmePage({super.key});

  @override
  State<BuscaFilmePage> createState() => _BuscaFilmePageState();
}

class _BuscaFilmePageState extends State<BuscaFilmePage> {
  String? titulo;
  final apiService = BuscaFilmeService();

  final Color roxoNeon = const Color(0xFFB026FF);
  final Color cianoNeon = const Color(0xFF00FFF6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Buscar Filme",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Digite o título do filme em inglês",
                labelStyle: TextStyle(color: cianoNeon),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: roxoNeon),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cianoNeon, width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  titulo = value;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: titulo == null ? null : apiService.buscarFilme(titulo!),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return exibeErro(snapshot.error);
                      } else if (!snapshot.hasData) {
                        return const Center(
                          child: Text(
                            "Digite um título para buscar.",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return exibeResultado(context, snapshot);
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot) {
    final dados = snapshot.data;

    if (dados == null) {
      return const Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          "Nenhum resultado encontrado.",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (_) {
              if (dados["Poster"] != null && dados["Poster"] != "N/A") {
                return Image.network(
                  dados["Poster"],
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      color: Colors.grey[900],
                      alignment: Alignment.center,
                      child: const Text(
                        "Imagem não disponível",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  height: 250,
                  color: Colors.grey[900],
                  alignment: Alignment.center,
                  child: const Text(
                    "Imagem não disponível",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.movie, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  dados["Title"] ?? "Título não disponível",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text(
                dados["Year"] ?? "Não disponível",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 22),
              const SizedBox(width: 8),
              Text(
                dados["imdbRating"] ?? "Sem avaliação",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.description, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  dados["Plot"] ?? "Sem descrição disponível.",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget exibeErro(Object? erro) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        "Ocorreu um erro: $erro",
        style: const TextStyle(color: Colors.red, fontSize: 18),
        softWrap: true,
      ),
    );
  }
}
