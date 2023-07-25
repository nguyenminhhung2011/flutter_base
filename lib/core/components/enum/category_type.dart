enum CategoryType {
  all,
  expense,
  income;

  bool get isExpense => this == CategoryType.expense;
}
