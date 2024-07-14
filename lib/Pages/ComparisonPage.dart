import 'package:flutter/material.dart';
import 'package:praktic/classes/credits.dart';
import 'package:praktic/classes/mortgage.dart';

class ComparisonPage extends StatefulWidget {
  final String selectedOperation;
  final Credits credits;
  final Mortgage mortgage;
  final List<Credits> creditList;
  final List<Mortgage> mortgageList;
  final Set<int> selectedCreditIndexes;
  final Set<int> selectedMortgageIndexes;

  const ComparisonPage({
    required this.selectedOperation,
    required this.credits,
    required this.mortgage,
    required this.creditList,
    required this.mortgageList,
    required this.selectedCreditIndexes,
    required this.selectedMortgageIndexes,
    Key? key,
  }) : super(key: key);

  @override
  State<ComparisonPage> createState() => _ComparisonpageState();
}

class _ComparisonpageState extends State<ComparisonPage> {
  late String _selectedOperation;
  late Credits _credit;
  late Mortgage _mortgage;
  late List<Credits> _creditList;
  late List<Mortgage> _mortgageList;
  late Set<int> _selectedCreditIndexes;
  late Set<int> _selectedMortgageIndexes;

  @override
  void initState() {
    _selectedOperation = widget.selectedOperation;
    _credit = widget.credits;
    _mortgage = widget.mortgage;
    _creditList = widget.creditList;
    _mortgageList = widget.mortgageList;
    _selectedCreditIndexes = widget.selectedCreditIndexes;
    _selectedMortgageIndexes = widget.selectedMortgageIndexes;
    super.initState();
  }

  Color getColor(num value, List<num> allValues) {
    allValues.sort();
    if (value == allValues.first) {
      return Colors.red;
    } else if (value == allValues.last) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }

  Color getColorRev(num value, List<num> allValues) {
    allValues.sort();
    if (value == allValues.first) {
      return Colors.green;
    } else if (value == allValues.last) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сравнение'),
      ),
      body: _selectedOperation == 'Кредит'
          ? ListView.builder(
        itemCount: _selectedCreditIndexes.length,
        itemBuilder: (BuildContext context, int index) {
          int selectedIndex = _selectedCreditIndexes.elementAt(index);
          Credits selectedCredit = _creditList[selectedIndex];

          // Extract values for comparison
          List<num> amounts = _selectedCreditIndexes.map((i) => _creditList[i].amount).toList();
          List<num> rates = _selectedCreditIndexes.map((i) => _creditList[i].rate).toList();
          List<num> terms = _selectedCreditIndexes.map((i) => _creditList[i].term).toList();
          List<num> payments = _selectedCreditIndexes.map((i) => _creditList[i].payment).toList();
          List<num> overPayments = _selectedCreditIndexes.map((i) => _creditList[i].overPayment).toList();

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Кредит ${index + 1}'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Сумма кредита: ${selectedCredit.amount.toStringAsFixed(2)}'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedCredit.amount, amounts),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Процентная ставка: ${selectedCredit.rate} %'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColorRev(selectedCredit.rate, rates),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Срок кредита (лет): ${selectedCredit.term}'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedCredit.term.toDouble(), terms.map((e) => e.toDouble()).toList()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Платёж: ${selectedCredit.payment.toStringAsFixed(2)} рублей'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedCredit.payment, payments),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Переплата: ${selectedCredit.overPayment.toStringAsFixed(2)} рублей'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedCredit.overPayment, overPayments),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
          : ListView.builder(
        itemCount: _selectedMortgageIndexes.length,
        itemBuilder: (BuildContext context, int index) {
          int selectedIndex = _selectedMortgageIndexes.elementAt(index);
          Mortgage selectedMortgage = _mortgageList[selectedIndex];

          // Extract values for comparison
          List<num> amounts = _selectedMortgageIndexes.map((i) => _mortgageList[i].amount).toList();
          List<num> rates = _selectedMortgageIndexes.map((i) => _mortgageList[i].rate).toList();
          List<num> terms = _selectedMortgageIndexes.map((i) => _mortgageList[i].term).toList();
          List<num> payments = _selectedMortgageIndexes.map((i) => _mortgageList[i].payment).toList();
          List<num> overPayments = _selectedMortgageIndexes.map((i) => _mortgageList[i].overPayment).toList();

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ипотека ${index + 1}'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Сумма ипотеки: ${selectedMortgage.amount.toStringAsFixed(2)}'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedMortgage.amount, amounts),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Процентная ставка: ${selectedMortgage.rate} %'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColorRev(selectedMortgage.rate, rates),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Срок ипотеки (лет): ${selectedMortgage.term}'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedMortgage.term.toDouble(), terms.map((e) => e.toDouble()).toList()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Первоначальный взнос: ${selectedMortgage.fistPayment} рублей'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedMortgage.fistPayment, payments),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Платёж: ${selectedMortgage.payment.toStringAsFixed(2)} рублей'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedMortgage.payment, payments),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Переплата: ${selectedMortgage.overPayment.toStringAsFixed(2)} рублей'),
                      SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        color: getColor(selectedMortgage.overPayment, overPayments),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
