class Livro {
  int? id;
  String titulo;
  String autor;
  int anoPublicacao;
  String resumo;
  String genero;
  String editora;
  String statusLeitura; 
  String? capaPath; 

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.anoPublicacao,
    required this.resumo,
    required this.genero,
    required this.editora,
    required this.statusLeitura,
    this.capaPath,
  });

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      id: map['id'] as int?,
      titulo: map['titulo'] as String,
      autor: map['autor'] as String,
      anoPublicacao: map['anoPublicacao'] as int,
      resumo: map['resumo'] as String,
      genero: map['genero'] as String,
      editora: map['editora'] as String,
      statusLeitura: map['statusLeitura'] as String,
      capaPath: map['capaPath'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{
      'titulo': titulo,
      'autor': autor,
      'anoPublicacao': anoPublicacao,
      'resumo': resumo,
      'genero': genero,
      'editora': editora,
      'statusLeitura': statusLeitura,
      'capaPath': capaPath,
    };
    if (id != null) m['id'] = id;
    return m;
  }
}
