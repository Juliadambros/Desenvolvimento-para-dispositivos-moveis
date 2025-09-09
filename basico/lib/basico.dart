void exercicio1(int A, int B, int C){
  int soma = A + B;
  String mensagem = soma < C ? 'É menor' : 'É maior';
  print(mensagem);
}

void exercicio2(int numero) {
  String resultado = (numero % 2 == 0) ? 'Par' : 'Ímpar';
  print(resultado);
}

void exercicio3(int A, int B) {
  int C = (A == B) ? (A + B) : (A * B);
  print('Resultado: $C');
}

void exercicio4(int A, int B, int C) {
  if (A > B && A > C) {
    if (B > C) {
      print('$A, $B, $C');
    } else {
      print('$A, $C, $B');
    }
  } else if (B > A && B > C) {
    if (A > C) {
      print('$B, $A, $C');
    } else {
      print('$B, $C, $A');
    }
  } else {
    if (A > B) {
      print('$C, $A, $B');
    } else {
      print('$C, $B, $A');
    }
  }
}

void exercicio5() {
  int soma = 0;
  for (int i = 1; i <= 500; i++) {
    if (i % 2 != 0 && i % 3 == 0) {
      soma += i;
    }
  }
  print('Soma: $soma');
}

void exercicio6() {
  for (int i = 101; i < 200; i += 2) {
    print(i);
  }
}

void exercicio7(int N) {
  for (int i = 0; i <= 10; i++) {
    print('$i x $N = ${i * N}');
  }
}

void exercicio8(int A) {
  int resultado = 1;
  print('$A! =');
  for (int i = A; i >= 1; i--) {
    resultado *= i;
    if (i > 1) {
      print('$i x ');
    } else {
      print('$i');
    }
  }
  print('= $resultado');
}

void lista2exercicio1(){
  List<String> frutas = ["maçã", "banana", "uva", "pera", "abacaxi"];
  print(frutas);
}

void lista2exercicio2(){
  List<String> frutas = ["maçã", "banana", "uva", "pera", "abacaxi"];
  print(frutas[2]);
}

void lista2exercicio3(){
  List<String> frutas = ["maçã", "banana", "uva", "pera", "abacaxi"];
  frutas.add("laranja");
  print(frutas);
  frutas.remove("maçã");
  print(frutas);
}

void lista2exercicio4(){
  List<String> frutas = ["maçã", "banana", "uva", "pera", "abacaxi"];
  for (int i = 0; i < frutas.length; i++) {
    print(frutas[i].toUpperCase());
  }
}

void lista2exercicio5(){
  List<String> frutas = ["maçã", "banana", "uva", "pera", "abacaxi"];
  frutas.forEach((f) => print(f.toLowerCase()));
}

void lista2exercicio6(){
  List<String> frutas = ["maçã", "banana", "uva", "pera", "abacaxi"];
  List<String> frutasComA = [];

  for (var fruta in frutas) {
    if (fruta.isNotEmpty && fruta.toLowerCase()[0] == 'a') {
      frutasComA.add(fruta);
    }
  }

  print(frutasComA);
}

void lista2exercicio7(){
  Map<String, double> precosFrutas = {
    "maçã": 3.0,
    "banana": 2.5,
    "uva": 4.5,
    "pera": 5.0,
    "abacaxi": 3.5
  };
  print(precosFrutas);
}

void lista2exercicio8(){
  Map<String, double> precosFrutas = {
      "maçã": 3.0,
      "banana": 2.5,
      "uva": 4.5,
      "pera": 5.0,
      "abacaxi": 3.5
    };

  for (var chave in precosFrutas.keys) {
    print("$chave: R\$ ${precosFrutas[chave]}");
  }
}

void lista2exercicio9() {
  List<int> numeros = List.generate(20, (i) => i);

  apenasPares(List<int> lista) {
    List<int> pares = [];
    for (var n in lista) {
      if (n % 2 == 0) {
        pares.add(n);
      }
    }
    return pares;
  }

  print("Números originais: $numeros");
  print("Números pares: ${apenasPares(numeros)}");
}

enum Pessoa { Carlos, Ana, Milena, Julia, Eduarda }

void lista2exercicio10() {
  Map<Pessoa, int> idades = {
    Pessoa.Carlos: 20,
    Pessoa.Ana: 17,
    Pessoa.Milena: 22,
    Pessoa.Julia: 15,
    Pessoa.Eduarda: 30
  };

  idades.forEach((pessoa, idade) {
    if (idade >= 18) {
      print("${pessoa.name} é maior de idade.");
    }
  });
}