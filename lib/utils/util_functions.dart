class Utils {
  static String formatPrice(double price) {
    var priceString = 'R\$ ${price.toStringAsFixed(2)}';
    return priceString.replaceFirst('.', ',');
  }

  static String formatPriceWithoutR$(double price) {
    var priceString = price.toStringAsFixed(2);
    return priceString.replaceFirst('.', ',');
  }
}
