import 'package:lista3/lista3.dart' as lista3;

void main(List<String> arguments) {
  var baralho = lista3.Baralho();
  baralho.embaralhar();

  print("Cartas compradas:");
  for (int i = 0; i < 5; i++) {
    print(baralho.comprar());
  }

  print("Cartas restantes no baralho: ${baralho.cartasRestantes()}");
}
