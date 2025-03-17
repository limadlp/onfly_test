enum ExpenseStatus {
  pending('pending'),
  approved('approved'),
  rejected('rejected'),
  unknown('unknown');

  final String label;
  const ExpenseStatus(this.label);
}
