import 'dart:io';
import 'package:flutter/material.dart';
import '../database/helper/livro_helper.dart';
import '../database/model/livro_model.dart';
import 'livro_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

enum OrderOptions { aZ, zA }

class _HomePageState extends State<HomePage> {
  final LivroHelper helper = LivroHelper();
  List<Livro> livros = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    try {
      livros = await helper.getAll();
    } finally {
      setState(() => loading = false);
    }
  }

  void _openForm({Livro? livro}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LivroPage(livro: livro)),
    );
    if (result == true) _load();
  }

  void _confirmDelete(Livro livro, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFBEED7),
        title: const Text('Excluir livro', style: TextStyle(color: Color(0xFF7B1E1E))),
        content: Text('Tem certeza que deseja excluir "${livro.titulo}"?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(ctx),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7B1E1E)),
            child: const Text('Excluir'),
            onPressed: () async {
              if (livro.id != null) await helper.delete(livro.id!);
              setState(() => livros.removeAt(index));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Livro removido')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _orderList(OrderOptions option) {
    setState(() {
      if (option == OrderOptions.aZ) {
        livros.sort((a, b) => a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase()));
      } else {
        livros.sort((a, b) => b.titulo.toLowerCase().compareTo(a.titulo.toLowerCase()));
      }
    });
  }

  Widget _livroCard(Livro l, int index) {
    IconData statusIcon;
    Color statusColor;

    switch (l.statusLeitura) {
      case 'Lido':
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
        break;
      case 'Lendo':
        statusIcon = Icons.menu_book;
        statusColor = Colors.orange;
        break;
      default:
        statusIcon = Icons.favorite_border;
        statusColor = Colors.grey;
    }

    return Card(
      color: const Color(0xFFFBEED7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: InkWell(
        onTap: () => _openForm(livro: l),
        onLongPress: () => _confirmDelete(l, index),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: l.capaPath != null && l.capaPath!.isNotEmpty
                    ? Image.file(File(l.capaPath!), width: 70, height: 100, fit: BoxFit.cover)
                    : Image.asset('assets/imgs/book_placeholder.png', width: 70, height: 100, fit: BoxFit.cover),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.titulo, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("${l.autor} • ${l.editora}", style: const TextStyle(color: Colors.black54)),
                    const SizedBox(height: 6),
                    Text(l.genero, style: const TextStyle(color: Color(0xFF7B1E1E))),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(statusIcon, color: statusColor, size: 20),
                        const SizedBox(width: 6),
                        Text(l.statusLeitura),
                        const Spacer(),
                        Text("${l.anoPublicacao}", style: const TextStyle(color: Colors.black54)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7B1E1E),
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.menu_book_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text('Minha Biblioteca'),
          ],
        ),
        backgroundColor: const Color(0xFF7B1E1E),
        actions: [
          PopupMenuButton<OrderOptions>(
            icon: const Icon(Icons.sort, color: Colors.white),
            onSelected: _orderList,
            itemBuilder: (_) => const [
              PopupMenuItem(value: OrderOptions.aZ, child: Text('Ordenar A-Z')),
              PopupMenuItem(value: OrderOptions.zA, child: Text('Ordenar Z-A')),
            ],
          )
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : livros.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu_book_rounded, size: 80, color: Colors.white70),
                      SizedBox(height: 20),
                      Text(
                        'Nenhum livro adicionado ainda',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      )
                    ],
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBEED7),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 12, bottom: 80),
                    itemCount: livros.length,
                    itemBuilder: (_, i) => _livroCard(livros[i], i),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFBEED7),
        child: const Icon(Icons.add, color: Color(0xFF7B1E1E)),
        onPressed: () => _openForm(),
      ),
    );
  }
}
