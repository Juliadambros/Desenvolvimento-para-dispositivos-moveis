import 'dart:convert';

import 'package:basico/basico.dart' as basico;

void main(List<String> arguments) {
  //chamando função dentro da string ${}, chamando variavel só $
  //print('Hello world: ${basico.calculate()}!');
  //basico.saudacoes('Carlos Eduardo', sobrenome: basico.adicionarSobrenome);
  List<int> intervalo = List.generate(10, (i)=>i*10);
  print(intervalo.isEmpty);
  print(intervalo.isNotEmpty);

  String dadosAluno(){
    return """{
      "nome": "Carlos Eduardo",
      "sobrenome": "Iatskiu",
      "idade": 37,
      "casado":true,
      "telefones":[
        {"ddd": 42, "numero": 9910904415, "tipo": "celular"},
        {"ddd": 42, "numero": 9910904415, "tipo": "comercial"}
      ]
    }""";
  }
  
  Map<String, dynamic> dados = json.decode(dadosAluno());
  print(dados);
  
  basico.exercicio1(4, 6, 9);
  basico.exercicio2(9);
  basico.exercicio3(4, 7);
  basico.exercicio4(4, 5, 6);
  basico.exercicio5();
  basico.exercicio6();
  basico.exercicio7(4);
  basico.exercicio8(5);

  basico.lista2exercicio1();
  basico.lista2exercicio2();
  basico.lista2exercicio3();
  basico.lista2exercicio4();
  basico.lista2exercicio5();
  basico.lista2exercicio6();
  basico.lista2exercicio7();
  basico.lista2exercicio8();
  basico.lista2exercicio9();
  basico.lista2exercicio10();

}
