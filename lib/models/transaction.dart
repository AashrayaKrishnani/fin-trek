class Transaction {
  final DateTime dateTime;
  final String title, id;
  final double amt;

  Transaction(
      {required this.title,
      required this.id,
      required this.amt,
      required this.dateTime});
}
