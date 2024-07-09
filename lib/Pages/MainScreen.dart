import 'package:flutter/material.dart';
import 'InsertDataScreen.dart';
import 'ResultScreen.dart';
import 'package:praktic/classes/credits.dart';
import 'package:praktic/classes/mortgage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Credits credits;
  late Mortgage mortgage;
  late List<Credits> creditList;
  late List<Mortgage> mortgageList;

  final TextEditingController _mortgageAmountController = TextEditingController();
  final TextEditingController _mortgageRateController = TextEditingController();
  final TextEditingController _mortgageTermController = TextEditingController();
  final TextEditingController _mortgageDownPaymentController = TextEditingController();

  String _selectedOperation = 'Кредит';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    credits = Credits(0, 0, 0, 0, 0);
    mortgage = Mortgage(0, 0, 0, 0, 0, 0);
    creditList = [credits];
    mortgageList = [mortgage];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mortgageAmountController.dispose();
    _mortgageRateController.dispose();
    _mortgageTermController.dispose();
    _mortgageDownPaymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Калькулятор месячного платежа', style: TextStyle(color: Colors.black)),
        bottom: TabBar(
          indicatorColor: Colors.black,
          dividerColor: Colors.black,
          controller: _tabController,
          labelColor: Colors.black,
          tabs: const [
            Tab(text: 'Данные'),
            Tab(text: 'Результат'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Insertdatascreen(
            selectedOperation: _selectedOperation,
            credits: credits,
            mortgage: mortgage,
            creditList: creditList,
            mortgageList: mortgageList,
          ),
          Resultscreen(
            selectedOperation: _selectedOperation,
            credits: credits,
            mortgage: mortgage,
            creditList: creditList,
            mortgageList: mortgageList,
          ),
        ],
      ),
    );
  }
}
