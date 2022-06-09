String formatAmt(double amount) {
  if (amount >= 1000 && amount < 1000000) {
    return (amount / 1000).toStringAsFixed(1) + "k";
  } else if (amount >= 1000000 && amount < 1000000000) {
    return (amount / 1000000).toStringAsFixed(1) + "M";
  } else if (amount >= 1000000000) {
    return (amount / 1000000000).toStringAsFixed(1) + "B";
  }

  return amount.toStringAsFixed(1);
}

String formatDateTime(DateTime dateTime) {
  return dateTime.hour.toString() +
      ":" +
      dateTime.minute.toString() +
      " - " +
      dateTime.day.toString() +
      "/" +
      dateTime.month.toString() +
      "/" +
      dateTime.year.toString();
}
