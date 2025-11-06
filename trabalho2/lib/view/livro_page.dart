import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../database/helper/livro_helper.dart';
import '../database/model/livro_model.dart';

class LivroPage extends StatefulWidget {
  final Livro? livro;
  const LivroPage({super.key, this.livro});

  @override
  State<LivroPage> createState() => _LivroPageState();
}

class _LivroPageState extends State<LivroPage> {
  final _formKey = GlobalKey<FormState>();
  final LivroHelper helper = LivroHelper();

  final _tituloCtrl = TextEditingController();
  final _autorCtrl = TextEditingController();
  final _anoCtrl = TextEditingController();
  final _resumoCtrl = TextEditingController();
  final _editoraCtrl = TextEditingController();

  String genero = '';
  String status = 'Quero ler';
  String? capaPath;
  bool saving = false;

  final _picker = ImagePicker();
  final List<String> statuses = ['Lido', 'Lendo', 'Quero ler'];

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      final l = widget.livro!;
      _tituloCtrl.text = l.titulo;
      _autorCtrl.text = l.autor;
      _anoCtrl.text = l.anoPublicacao.toString();
      _resumoCtrl.text = l.resumo;
      _editoraCtrl.text = l.editora;
      genero = l.genero;
      status = l.statusLeitura;
      capaPath = l.capaPath;
    }
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (file != null) {
      setState(() => capaPath = file.path);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => saving = true);

    final livro = Livro(
      id: widget.livro?.id,
      titulo: _tituloCtrl.text.trim(),
      autor: _autorCtrl.text.trim(),
      anoPublicacao: int.tryParse(_anoCtrl.text) ?? 0,
      resumo: _resumoCtrl.text.trim(),
      genero: genero,
      editora: _editoraCtrl.text.trim(),
      statusLeitura: status,
      capaPath: capaPath,
    );

    try {
      if (livro.id == null) {
        await helper.insert(livro);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Livro adicionado com sucesso!')),
        );
      } else {
        await helper.update(livro);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Livro atualizado com sucesso!')),
        );
      }
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  Future<void> _selectGenres() async {
    final allGenres = [
      {'name': 'Romance', 'icon': Icons.favorite_border},
      {'name': 'Fantasia', 'icon': Icons.auto_awesome},
      {'name': 'Ficção científica', 'icon': Icons.science_outlined},
      {'name': 'Terror', 'icon': Icons.nightlight_round},
      {'name': 'Suspense', 'icon': Icons.visibility},
      {'name': 'Aventura', 'icon': Icons.landscape_outlined},
      {'name': 'Mistério', 'icon': Icons.help_outline},
      {'name': 'Biografia', 'icon': Icons.person_outline},
      {'name': 'Histórico', 'icon': Icons.history_edu},
      {'name': 'Não-ficção', 'icon': Icons.book_outlined},
      {'name': 'Drama', 'icon': Icons.theater_comedy},
      {'name': 'Político', 'icon': Icons.account_balance},
      {'name': 'Humor', 'icon': Icons.emoji_emotions_outlined},
      {'name': 'Poesia', 'icon': Icons.menu_book_outlined},
      {'name': 'Autoajuda', 'icon': Icons.psychology_alt},
      {'name': 'Religião', 'icon': Icons.church},
      {'name': 'Tecnologia', 'icon': Icons.computer},
    ];

    final selected = genero.isNotEmpty ? genero.split(', ').toSet() : <String>{};

    final result = await showDialog<List<String>>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFBEED7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Selecione os gêneros',
            style: TextStyle(color: Color(0xFF7B1E1E), fontWeight: FontWeight.bold),
          ),
          content: StatefulBuilder(builder: (ctx, setDialogState) {
            return SizedBox(
              width: double.maxFinite,
              height: 400,
              child: Scrollbar(
                thumbVisibility: true,
                radius: const Radius.circular(8),
                child: ListView.builder(
                  itemCount: allGenres.length,
                  itemBuilder: (_, i) {
                    final g = allGenres[i]['name'] as String;
                    final icon = allGenres[i]['icon'] as IconData;
                    final isSelected = selected.contains(g);
                    return CheckboxListTile(
                      activeColor: const Color(0xFF7B1E1E),
                      value: isSelected,
                      onChanged: (v) {
                        setDialogState(() {
                          if (v == true) {
                            selected.add(g);
                          } else {
                            selected.remove(g);
                          }
                        });
                      },
                      title: Row(
                        children: [
                          Icon(icon, color: const Color(0xFF7B1E1E)),
                          const SizedBox(width: 8),
                          Text(g, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7B1E1E)),
              onPressed: () => Navigator.pop(ctx, selected.toList()),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        genero = result.join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const bordo = Color(0xFF7B1E1E);
    const bege = Color(0xFFFBEED7);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? 'Novo Livro' : 'Editar Livro'),
        backgroundColor: bordo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: capaPath != null && capaPath!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(capaPath!),
                          width: 160,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 160,
                        height: 220,
                        decoration: BoxDecoration(
                          color: bege,
                          border: Border.all(color: bordo, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, color: bordo, size: 40),
                            SizedBox(height: 10),
                            Text('Adicionar capa', style: TextStyle(color: bordo)),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => v!.isEmpty ? 'Título obrigatório' : null,
              ),
              TextFormField(
                controller: _autorCtrl,
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (v) => v!.isEmpty ? 'Autor obrigatório' : null,
              ),
              TextFormField(
                controller: _anoCtrl,
                decoration: const InputDecoration(labelText: 'Ano de publicação'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ano obrigatório';
                  if (int.tryParse(v) == null) return 'Digite apenas números';
                  if (v.length != 4) return 'Ano inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _editoraCtrl,
                decoration: const InputDecoration(labelText: 'Editora'),
              ),
              TextFormField(
                controller: _resumoCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Resumo'),
              ),
              const SizedBox(height: 12),

              TextFormField(
                readOnly: true,
                onTap: _selectGenres,
                controller: TextEditingController(text: genero),
                decoration: const InputDecoration(
                  labelText: 'Gêneros literários',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                validator: (v) => v!.isEmpty ? 'Selecione ao menos um gênero' : null,
              ),

              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(labelText: 'Status de leitura'),
                items: statuses
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => status = v!),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: saving ? null : _save,
                icon: const Icon(Icons.save),
                label: saving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: bordo,
                  minimumSize: const Size(double.infinity, 48),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

