int calculateTotalPrice(List<Map<String, dynamic>> items) {
  return items.fold(0, (total, item) {
    final int price = item['price'] is int ? item['price'] : 0;
    final int qty = item['qty'] is int ? item['qty'] : 1;
    return total + (price * qty);
  });
}
