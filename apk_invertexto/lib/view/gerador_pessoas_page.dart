import 'dart:convert';

import 'package:apk_invertexto/service/invertexto_service.dart';
import 'package:flutter/material.dart';

class GeradorPessoasPage extends StatefulWidget {
  const GeradorPessoasPage({super.key});

  @override
  State<GeradorPessoasPage> createState() => _GeradorPessoasPageState();
}

class _GeradorPessoasPageState extends State<GeradorPessoasPage> {
  String? campo;
  final apiService = InvertextoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/invertexto.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Campos (ex: name,email)",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: apiService.geradorPessoas(
                  campo != null && campo!.isNotEmpty ? campo : "name",
                ),
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
                      if (snapshot.hasError || snapshot.data == null) {
                        return Container(); // ou mostrar uma mensagem de erro
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
    final data = snapshot.data as Map<String, dynamic>;

    // Converte o Map em string JSON formatada
    final jsonStr = const JsonEncoder.withIndent('  ').convert(data);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        jsonStr,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        softWrap: true,
      ),
    );
  }
}
