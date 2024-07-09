import 'package:flutter/material.dart';
import 'package:praktic/classes/credits.dart';
import 'package:praktic/classes/mortgage.dart';
import 'dart:math';

class Insertdatascreen extends StatefulWidget {
  final String selectedOperation;
  final Credits credits;
  final Mortgage mortgage;
  final List creditList;
  final List mortgageList;

  const Insertdatascreen({
    super.key,
    required this.selectedOperation,
    required this.credits,
    required this.mortgage,
    required this.creditList,
    required this.mortgageList,
  });

  @override
  State<Insertdatascreen> createState() => _InsertdatascreenState();
}

class _InsertdatascreenState extends State<Insertdatascreen> {
  late String _selectedOperation;
  late Credits _credit;
  late Mortgage _mortgage;
  late List _creditList;
  late List _mortgageList;

  final TextEditingController mortgageAmountController = TextEditingController();
  final TextEditingController mortgageRateController = TextEditingController();
  final TextEditingController mortgageTermController = TextEditingController();
  final TextEditingController mortgageDownPaymentController = TextEditingController();
  final TextEditingController creditAmountController = TextEditingController();
  final TextEditingController creditRateController = TextEditingController();
  final TextEditingController creditTermController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedOperation = widget.selectedOperation;
    _credit = widget.credits;
    _mortgage = widget.mortgage;
    _creditList = widget.creditList;
    _mortgageList = widget.mortgageList;
  }

  void updateSelectedOperation(String operation) {
    setState(() {
      _selectedOperation = operation;
    });
  }

  num calculateMonthlyPayment(num principal, num annualRate, num years) {
    num monthlyRate = annualRate / 12 / 100;
    num totalPayments = years * 12;
    return principal * (monthlyRate * pow(1 + monthlyRate, totalPayments)) / (pow(1 + monthlyRate, totalPayments) - 1);
  }

  void _calculateCredit() {
    if (creditAmountController.text.isEmpty ||
        creditRateController.text.isEmpty ||
        creditTermController.text.isEmpty) {
      _showErrorDialog("Все поля обязательны для заполнения.");
      return;
    }

    try {
      num principal = double.parse(creditAmountController.text);
      num annualRate = double.parse(creditRateController.text);
      num term = int.parse(creditTermController.text);

      num monthlyPayment = calculateMonthlyPayment(principal, annualRate, term);
      num overPayment = monthlyPayment * (term * 12) - principal;

      Credits result = Credits(principal, annualRate, term, monthlyPayment, overPayment);
      _creditList.add(result);
      _showSuccessfulDialog('Кредит успешно расчитан');
    } catch (e) {
      _showErrorDialog("Пожалуйста, введите корректные числовые значения.");
    }
  }

  void _calculateMortgage() {
    if (mortgageAmountController.text.isEmpty ||
        mortgageRateController.text.isEmpty ||
        mortgageTermController.text.isEmpty ||
        mortgageDownPaymentController.text.isEmpty) {
      _showErrorDialog("Все поля обязательны для заполнения.");
      return;
    }

    try {
      num amount = double.parse(mortgageAmountController.text);
      num rate = double.parse(mortgageRateController.text);
      num term = double.parse(mortgageTermController.text);
      num firstPayment = double.parse(mortgageDownPaymentController.text);
      num payment = calculateMonthlyPayment(amount - firstPayment, rate, term);
      num overPayment = payment * (term * 12) - amount;

      Mortgage result = Mortgage(amount, rate, term, firstPayment, payment, overPayment);
      _mortgageList.add(result);
      _showSuccessfulDialog('Ипотека успешно расчитана');
    } catch (e) {
      _showErrorDialog("Пожалуйста, введите корректные числовые значения.");
    }
  }

  void _showSuccessfulDialog(String message){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Успех!'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: Text('OK')
          ),
        ],
      );
      }
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ошибка"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("ОК"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> operationTypes = ['Кредит', 'Ипотека'];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Выберите тип операции: ',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Exo2',
            ),
          ),
          DropdownButton<String>(
            style: const TextStyle(
              color: Colors.black,
            ),
            value: _selectedOperation,
            items: operationTypes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOperation = newValue!;
                updateSelectedOperation(_selectedOperation);
              });
            },
          ),
          const SizedBox(height: 10),
          _selectedOperation == 'Кредит'
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Введите данные по кредиту:',
                style: TextStyle(
                  fontSize: 16
                ),

              ),
              TextField(
                controller: creditAmountController,
                decoration: const InputDecoration(labelText: 'Сумма кредита'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: creditRateController,
                decoration: const InputDecoration(labelText: 'Процентная ставка'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: creditTermController,
                decoration: const InputDecoration(labelText: 'Срок кредита (лет)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              Center(
                child: OutlinedButton(
                    onPressed: _calculateCredit,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green
                    ),
                    child: const Text(
                      'Рассчитать',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    )
                ),
              )
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Введите данные по ипотеке:'),
              TextField(
                controller: mortgageAmountController,
                decoration: const InputDecoration(labelText: 'Сумма ипотеки'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: mortgageRateController,
                decoration: const InputDecoration(labelText: 'Процентная ставка'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: mortgageTermController,
                decoration: const InputDecoration(labelText: 'Срок ипотеки (лет)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: mortgageDownPaymentController,
                decoration: const InputDecoration(labelText: 'Первоначальный взнос'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10,),
              Center(
                child: OutlinedButton(
                    onPressed: _calculateMortgage,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green
                    ),
                    child: const Text(
                      'Рассчитать',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    )
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
