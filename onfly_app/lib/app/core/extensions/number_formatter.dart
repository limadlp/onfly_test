import 'package:currency_formatter/currency_formatter.dart';

extension NumberFormatter on double {
  String toBRL() {
    final CurrencyFormat brlSettings = const CurrencyFormat(
      symbol: 'R\$',
      symbolSide: SymbolSide.left,
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolSeparator: ' ',
    );

    return CurrencyFormatter.format(
      this,
      brlSettings,
      decimal: 2,
      enforceDecimals: true,
    );
  }
}
