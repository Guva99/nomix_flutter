class ReceiptsEntity {
  final String storeName;
  final String address;
  final DateTime purchaseDate;
  final double amount;
  final String? imageReceipts;

  ReceiptsEntity({
    required this.storeName,
    required this.address,
    required this.purchaseDate,
    required this.amount,
      this.imageReceipts,
  });
}
