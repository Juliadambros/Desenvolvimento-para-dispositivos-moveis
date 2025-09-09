// ignore_for_file: constant_identifier_names

enum Naipe { 
  COPAS, 
  OURO, 
  ESPADA, 
  PAUS 
}
enum Valor { 
  AS, 
  DOIS, 
  TRES, 
  QUATRO, 
  CINCO, 
  SEIS, 
  SETE, 
  OITO, 
  NOVE, 
  DEZ, 
  VALETE, 
  DAMA, 
  REI 
}

class Carta {
  final Naipe naipe;
  final Valor valor;

  Carta(this.naipe, this.valor);

  @override
  String toString() {
    String valorStr;
    switch (valor) {
      case Valor.AS: 
        valorStr = "ÁS"; 
      break;
      case Valor.DOIS: 
        valorStr = "2"; 
      break;
      case Valor.TRES: 
        valorStr = "3"; 
      break;
      case Valor.QUATRO: 
        valorStr = "4"; 
      break;
      case Valor.CINCO: 
        valorStr = "5"; 
      break;
      case Valor.SEIS: 
        valorStr = "6"; 
      break;
      case Valor.SETE: 
        valorStr = "7"; 
      break;
      case Valor.OITO: 
        valorStr = "8"; 
      break;
      case Valor.NOVE: 
        valorStr = "9"; 
      break;
      case Valor.DEZ: 
        valorStr = "10"; 
      break;
      case Valor.VALETE: 
        valorStr = "VALETE"; 
      break;
      case Valor.DAMA: 
        valorStr = "DAMA"; 
      break;
      case Valor.REI:  
        valorStr = "REI"; 
      break;
    }

    String naipeStr;
    switch (naipe) {
      case Naipe.COPAS: 
        naipeStr = "COPAS"; 
      break;
      case Naipe.OURO: 
        naipeStr = "OURO"; 
      break;
      case Naipe.ESPADA: 
        naipeStr = "ESPADAS"; 
      break;
      case Naipe.PAUS: 
        naipeStr = "PAUS"; 
      break;
    }

    return "$valorStr DE $naipeStr";
  }
}

class Baralho {
  List<Carta> cartas = [];

  Baralho() {
    for (var naipe in Naipe.values) {
      for (var valor in Valor.values) {
        cartas.add(Carta(naipe, valor));
      }
    }
  }

  void embaralhar() {
    cartas.shuffle();
  }

  Carta comprar() {
    return cartas.removeLast();
  }

  int cartasRestantes() {
    return cartas.length;
  }
}
