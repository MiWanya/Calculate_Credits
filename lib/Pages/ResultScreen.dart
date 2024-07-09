import 'package:flutter/material.dart';
import 'package:praktic/classes/credits.dart';
import 'package:praktic/classes/mortgage.dart';
import 'ComparisonPage.dart';

class Resultscreen extends StatefulWidget {
  final String selectedOperation;
  final Credits credits;
  final Mortgage mortgage;
  final List<Credits> creditList;
  final List<Mortgage> mortgageList;

  const Resultscreen({
    Key? key,
    required this.selectedOperation,
    required this.credits,
    required this.mortgage,
    required this.creditList,
    required this.mortgageList,
  }) : super(key: key);

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  Set<int> _selectedCreditIndexes = Set<int>();
  Set<int> _selectedMortgageIndexes = Set<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Кредиты:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              widget.creditList.length > 1
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.creditList.length - 1,
                    itemBuilder: (BuildContext context, int index) {
                      final credit = widget.creditList[index + 1];
                      final isSelected = _selectedCreditIndexes.contains(index + 1);
                      return Dismissible(
                        key: Key(credit.toString()),
                        background: Container(color: Colors.red),
                        direction: DismissDirection.none,
                        child: Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value != null && value) {
                                    _selectedCreditIndexes.add(index + 1);
                                  } else {
                                    _selectedCreditIndexes.remove(index + 1);
                                  }
                                });
                              },
                            ),
                            title: Text('Сумма кредита: ${credit.amount.toStringAsFixed(2)}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Процентная ставка: ${credit.rate} %'),
                                Text('Срок кредита (лет): ${credit.term} лет'),
                                Text('Платёж: ${credit.payment.toStringAsFixed(2)} рублей'),
                                Text('Переплата: ${credit.overPayment.toStringAsFixed(2)} рублей'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  widget.creditList.removeAt(index + 1);
                                  _selectedCreditIndexes.remove(index + 1);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        _selectedCreditIndexes.length >= 2
                            ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ComparisonPage(
                                selectedOperation: widget.selectedOperation,
                                credits: widget.credits,
                                mortgage: widget.mortgage,
                                creditList: widget.creditList,
                                mortgageList: widget.mortgageList,
                                selectedCreditIndexes: _selectedCreditIndexes,
                                selectedMortgageIndexes: _selectedMortgageIndexes,
                              )),
                        )
                            : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Выберите 2 кредита для сравнения'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: _selectedCreditIndexes.length >= 2 ? Colors.green : Colors.grey,
                          foregroundColor: Colors.white),
                      child: Text(
                        'Сравнить кредиты',
                        style: TextStyle(
                          color: _selectedCreditIndexes.length >= 2 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
                  : const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Не найдено рассчитанных кредитов'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Ипотеки:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              widget.mortgageList.length > 1
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.mortgageList.length - 1,
                    itemBuilder: (BuildContext context, int index) {
                      final mortgage = widget.mortgageList[index + 1];
                      final isSelected = _selectedMortgageIndexes.contains(index + 1);
                      return Dismissible(
                        key: Key(mortgage.toString()),
                        background: Container(color: Colors.red),
                        direction: DismissDirection.none,
                        child: Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value != null && value) {
                                    _selectedMortgageIndexes.add(index + 1);
                                  } else {
                                    _selectedMortgageIndexes.remove(index + 1);
                                  }
                                });
                              },
                            ),
                            title: Text('Сумма ипотеки: ${mortgage.amount.toStringAsFixed(2)}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Процентная ставка: ${mortgage.rate}'),
                                Text('Срок ипотеки (лет): ${mortgage.term}'),
                                Text('Первоначальный взнос: ${mortgage.fistPayment}'),
                                Text('Платёж: ${mortgage.payment.toStringAsFixed(2)} рублей'),
                                Text('Переплата: ${mortgage.overPayment.toStringAsFixed(2)} рублей'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  widget.mortgageList.removeAt(index + 1);
                                  _selectedMortgageIndexes.remove(index + 1);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        String selectedOperation = widget.selectedOperation;
                        selectedOperation = 'Ипотека';
                        _selectedMortgageIndexes.length >= 2
                            ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ComparisonPage(
                                selectedOperation: selectedOperation,
                                credits: widget.credits,
                                mortgage: widget.mortgage,
                                creditList: widget.creditList,
                                mortgageList: widget.mortgageList,
                                selectedCreditIndexes: _selectedCreditIndexes,
                                selectedMortgageIndexes: _selectedMortgageIndexes,
                              )),
                        )
                            : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Выберите 2 ипотеки для сравнения'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: _selectedMortgageIndexes.length >= 2 ? Colors.green : Colors.grey,
                          foregroundColor: Colors.white),
                      child: Text(
                        'Сравнить ипотеки',
                        style: TextStyle(
                          color: _selectedMortgageIndexes.length >= 2 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
                  : const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Не найдено рассчитанных ипотек'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
