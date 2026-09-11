/// Bill ids collide across sales / service / rent tables.
String billNumberFor({
  required int id,
  required String saleType,
  String? rentStatus,
}) {
  final t = saleType.toUpperCase();
  if (t == 'SERVICE') return 'SRV-$id';
  if (t == 'RENT' && (rentStatus ?? '').toUpperCase() == 'RETURNED') {
    return 'RET-$id';
  }
  if (t == 'RENT') return 'RENT-$id';
  return 'SALE-$id';
}

bool billHasUnitSerial(String saleType) => saleType.toUpperCase() != 'SERVICE';

bool billHasCreditDue({
  required String paymentMode,
  required String saleType,
  required double amountDue,
}) {
  final t = saleType.toUpperCase();
  return paymentMode.toUpperCase() == 'CREDIT' &&
      t != 'SERVICE' &&
      t != 'RENT' &&
      amountDue > 0.001;
}

String billPaymentLabel({
  required String paymentMode,
  required bool hasCreditDue,
  required double amountDue,
}) =>
    switch (paymentMode.toUpperCase()) {
      'ONLINE' => 'Online',
      'CREDIT' => hasCreditDue
          ? 'Credit · due ₹${amountDue.toStringAsFixed(0)}'
          : 'Credit (paid)',
      _ => 'Cash',
    };
