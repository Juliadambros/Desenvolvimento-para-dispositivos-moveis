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
  final TextEditingController _controller = TextEditingController();

  final Color roxoNeon = const Color(0xFFB026FF);
  final Color cianoNeon = const Color(0xFF00FFF6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Buscar Filme",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Digite o título do filme",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF1C1C1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: cianoNeon, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: roxoNeon, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cianoNeon,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      _mostrarErro("Digite um título antes de buscar.");
                    } else {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        titulo = _controller.text;
                      });
                    }
                  },
                  child: const Icon(Icons.search, size: 28),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: titulo == null
                      ? null
                      : apiService.buscarFilme(titulo!),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 5,
                            ),
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          final mensagem = snapshot.error.toString();

                          WidgetsBinding.instance.addPostFrameCallback((
                            _,
                          ) async {
                            if (!mounted) return;

                            setState(() {
                              titulo = null;
                            });

                            await _mostrarErro(
                              mensagem.replaceAll("Exception:", "").trim(),
                            );

                            if (mounted) {
                              _controller.clear(); // limpa o campo
                              FocusScope.of(
                                // ignore: use_build_context_synchronously
                                context,
                              ).nextFocus(); // volta o foco
                            }
                          });

                          return const SizedBox();
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: Text(
                              "Digite um título para buscar.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          );
                        } else {
                          return _exibeResultado(snapshot.data);
                        }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _exibeResultado(dynamic dados) {
    if (dados == null) {
      return const Center(
        child: Text(
          "Nenhum resultado encontrado.",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }
    final poster =
        (dados["Poster"] != null &&
            dados["Poster"] != "N/A" &&
            dados["Poster"].toString().isNotEmpty)
        ? dados["Poster"]
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: poster != null
                  ? Image.network(
                      poster,
                      height: 400,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _posterFallback();
                      },
                    )
                  : _posterFallback(),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            dados["Title"] ?? "Título não disponível",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, color: Colors.white, size: 22),
              const SizedBox(width: 6),
              Text(
                dados["Year"] ?? "Ano indisponível",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.star, color: Colors.amber, size: 24),
              const SizedBox(width: 6),
              Text(
                dados["imdbRating"] ?? "Sem avaliação",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              dados["Plot"] ?? "Sem descrição disponível.",
              style: const TextStyle(color: Colors.white70, fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _posterFallback() {
    return Container(
      height: 400,
      width: 270,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_outlined, color: Colors.white54, size: 80),
            SizedBox(height: 10),
            Text(
              "Imagem indisponível",
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _mostrarErro(String mensagem) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Ops!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          mensagem,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.cyanAccent)),
          ),
        ],
      ),
    );
  }
}

